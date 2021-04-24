package characters;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.math.FlxPoint;

import utils.Controls;
import utils.Helpers;

enum PlayerStates {
	Picking;
	Carrying;
	Hiding;
	Throwing;
	Gathering;
	Sneaking;
	Running;
	Idle;
}

enum PickupItem {
	Tree;
	Nothing;
}

final class Player extends FlxSprite {
	static inline final SNEAK_SPEED = 100;
	static inline final RUN_SPEED = 400;
	static inline final RUN_SHAKE_INTENSITY = 0.0012;
	static inline final RUN_SHAKE_DURATION = 0.15;

	final controls = Controls.instance;

	// - timers
	var throwSeconds: Float = 0;
	var finishThrowSeconds: Float = 0;
	// - controls
	var leftBtnPressed = false;
	var rightBtnPressed = false;
	var runBtnPressed = false;
	var throwBtnPressed = false;
	// - control modificaitons
	var bothDirectionsPressed = false;
	var singleDirectionPressed = false;
	var noDirectionPressed = false;

	var pickupItem: PickupItem = Nothing;

	public var state(default, null): PlayerStates = Idle;

	/**
	 * Throw snowball from this point when throw btn is pressed
	 */
	public var throwPosition(default, null) = new FlxPoint();

	/**
	 * Place pick up prompt here when player is Idle and overlaps object
	 */
	public var itemDownPosition(default, null) = new FlxPoint();

	/**
	 * Place put down prompt here when player is Idle
	 */
	public var stopPosition(default, null) = new FlxPoint();

	/**
	 * Prevents picked object from being placed over hideable object.
	 */
	public var overHiddenObject = false;

	// @formatter:off
	public function new(x: Float = 0, y: Float = 0) {
		super(x, y);
		drag.x = RUN_SPEED * 4;
		frames = Helpers.loadFrames("characters/yeti");

		Helpers.changeHitbox(247, 90, this, 60);
		// - animations
		animation.addByNames(
			"idle",
			Helpers.frameNames(5, "YETI_IDLE_"),
			5
		);
		animation.addByNames(
			"sneaking",
			Helpers.frameNames(13, "YETI_CREEP_"),
			8
		);
		animation.addByNames(
			"running",
			Helpers.frameNames(8, "YETI_RUN_"),
			10
		);
		animation.addByNames(
			"throwing",
			Helpers.frameNames(22, "YETI_THROW_"),
			12
		);
		animation.addByNames(
			"hiding",
			Helpers.frameNames(5, "YETI_HIDE_"),
			5
		);
		animation.addByNames(
			"picking_tree",
			Helpers.frameNames(9, "YETI_TREE_"),
			10
		);

		// - single frames

		setFacingFlip(FlxObject.LEFT, true, false);
		setFacingFlip(FlxObject.RIGHT, false, false);
	}

	public function hidePlayer() {
		state = Hiding;
		alpha = 0;
	}

	public function showPlayer() {
		state = Idle;
		alpha = 1;
	}

	public function pickedUpItem(item: PickupItem) {
		state = Picking;
		pickupItem = item;
	}

	public function putDownItem() {
		state = Idle;
		pickupItem = Nothing;
		itemDownPosition.set(x, y);
	}

	// @formatter:on
	function movement(speed: Int, stationaryState: PlayerStates = Idle) {
		if (bothDirectionsPressed || noDirectionPressed) {
			state = stationaryState;
		} else {
			velocity.x = rightBtnPressed ? speed : -speed;
			facing = rightBtnPressed ? FlxObject.RIGHT : FlxObject.LEFT;
		}
	}

	// @formatter:off
	function stateMachine(elapsed: Float) {
		switch (state) {
			case Sneaking:
				movement(SNEAK_SPEED);
				animation.play("sneaking");
				if (runBtnPressed)
					state = Running;

			case Running:
				movement(RUN_SPEED);
				FlxG.camera.shake(RUN_SHAKE_INTENSITY, RUN_SHAKE_DURATION);
				animation.play("running");
				if (!runBtnPressed)
					state = Sneaking;

			case Gathering:
				var animPaused = false;
				animation.play("throwing");
				throwSeconds += elapsed;
				if (throwSeconds >= 1.2) {
					animation.pause();
					animPaused = true;
				}
				if (throwBtnPressed && animPaused)
					state = Throwing;
				if (singleDirectionPressed)
					state = Sneaking;

			case Throwing:
				animation.resume();
				finishThrowSeconds += elapsed;
				// Hack to prevent player from spamming throw buttom
				// and seeing the snowball in the path too early
				if (finishThrowSeconds >= 0.5)
					animation.play("idle");
				if (finishThrowSeconds >= 0.85)
					state = Idle;

			case Hiding:
				// Let's game know player is hidden so NPC's won't spot player.

			case Picking:
				pickingFrame();
				stopPosition.set(x, y);
				if (singleDirectionPressed)
					state = Carrying;

			case Carrying:
				carryingAnim();

			case Idle:
				velocity.x = 0;
				throwSeconds = 0;
				finishThrowSeconds = 0;
				animation.play("idle");
				if (singleDirectionPressed)
					state = Sneaking;
				if (throwBtnPressed) {
					throwPosition.set(x, y);
					state = Gathering;
				}
		}
	}

	// @formatter:on
	function carryingAnim() {
		switch (pickupItem) {
			case Tree:
				movement(SNEAK_SPEED, Picking);
				animation.play("picking_tree");
			case Nothing:
				// Player not holding anything
		}
	}

	function pickingFrame() {
		switch (pickupItem) {
			case Tree:
				animation.frameName = "YETI_TREE_06.png";
			case Nothing:
				// Player not holding anything
		}
	}

	function updateControls() {
		leftBtnPressed = controls.left.check();
		rightBtnPressed = controls.right.check();
		runBtnPressed = controls.cross.check();
		throwBtnPressed = controls.circle.check();
		// hidePressed = controls.up.check();

		bothDirectionsPressed = leftBtnPressed && rightBtnPressed;
		singleDirectionPressed = leftBtnPressed || rightBtnPressed;
		noDirectionPressed = !singleDirectionPressed;
	}

	override public function update(elapsed: Float) {
		super.update(elapsed);

		updateControls();
		stateMachine(elapsed);
	}
}