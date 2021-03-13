package characters;

import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.graphics.frames.FlxAtlasFrames;
import utils.Controls;
import utils.Helpers;

enum States {
	Sneaking;
	Running;
	Idle;
}

final class Player extends FlxSprite {
	final SNEAK_SPEED = 70;
	final RUN_SPEED = 300;
	final controls:Controls = Controls.instance;

	var playerState:States = States.Idle;
	// - controls
	var left = false;
	var right = false;
	var runBtnPressed = false;

	public var throwBtnPressed = false;

	// - control mods
	var bothDirectionsPressed = false;
	var singleDirectionPressed = false;
	var noDirectionPressed = false;
	// - hack to fix idle heigh issue
	var originalY:Float = 0;
	var idleY:Float = 0;

	public function new(x:Float = 0, y:Float = 0) {
		super(x, y);

		originalY = y;
		idleY = y + 8;
		drag.x = RUN_SPEED * 4;
		frames = FlxAtlasFrames.fromTexturePackerJson("assets/images/yeti.png",
			"assets/images/yeti.json");

		scale.set(0.75, 0.75);
		animation.addByNames("idle", Helpers.frameNames(5, "Yeti_Idle-"), 5);
		animation.addByNames("sneaking",
			Helpers.frameNames(13, "Yeti_Creep-"), 8);
		animation.addByNames("running", Helpers.frameNames(8, "Yeti_Run-"), 10);

		setFacingFlip(FlxObject.LEFT, true, false);
		setFacingFlip(FlxObject.RIGHT, false, false);
	}

	function movement(speed:Int) {
		y = originalY;
		if (bothDirectionsPressed || noDirectionPressed) {
			playerState = States.Idle;
		} else {
			velocity.x = right ? speed : -speed;
			facing = right ? FlxObject.RIGHT : FlxObject.LEFT;
		}
	}

	function stateMachine() {
		switch (playerState) {
			case States.Sneaking:
				movement(SNEAK_SPEED);
				animation.play("sneaking");
				if (runBtnPressed) playerState = States.Running;
			case States.Running:
				movement(RUN_SPEED);
				animation.play("running");
				if (!runBtnPressed) playerState = States.Sneaking;
			case States.Idle:
				velocity.x = 0;
				animation.play("idle");
				y = idleY;
				if (singleDirectionPressed) playerState = States.Sneaking;
		}
	}

	function updateControls() {
		left = controls.left.check();
		right = controls.right.check();
		runBtnPressed = controls.circle.check();
		throwBtnPressed = controls.cross.check();

		bothDirectionsPressed = left && right;
		singleDirectionPressed = left || right;
		noDirectionPressed = !singleDirectionPressed;
	}

	override function update(elapsed:Float) {
		super.update(elapsed);
		updateControls();
		stateMachine();
	}
}