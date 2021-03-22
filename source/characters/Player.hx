package characters;

import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.math.FlxPoint;

import utils.Controls;
import utils.Helpers;

enum States {
	Gathering;
	Sneaking;
	Running;
	Idle;
}

final class Player extends FlxSprite {
	final SNEAK_SPEED = 70;
	final RUN_SPEED = 300;
	final controls: Controls = Controls.instance;

	var throwSeconds: Float = 0;
	// - controls
	var left = false;
	var right = false;
	var runBtnPressed = false;
	var throwBtnPressed = false;
	// - control mods
	var bothDirectionsPressed = false;
	var singleDirectionPressed = false;
	var noDirectionPressed = false;

	public var state(default, null): States = States.Idle;
	public var throwPosition(default, null): FlxPoint;

	public function new(x: Float = 0, y: Float = 0) {
		super(x, y);
		drag.x = RUN_SPEED * 4;
		frames = FlxAtlasFrames.fromTexturePackerJson(
			"assets/images/yeti.png",
			"assets/images/yeti.json"
		);

		scale.set(0.75, 0.75);
		animation.addByNames("idle", Helpers.frameNames(5, "YETI_IDLE_"), 5);
		animation.addByNames(
			"sneaking",
			Helpers.frameNames(13, "YETI_CREEP_"),
			8
		);
		animation.addByNames("running", Helpers.frameNames(8, "YETI_RUN_"),
			10);
		animation.addByNames(
			"throwing",
			Helpers.frameNames(22, "YETI_THROW_"),
			10
		);

		setFacingFlip(FlxObject.LEFT, true, false);
		setFacingFlip(FlxObject.RIGHT, false, false);
	}

	function movement(speed: Int) {
		if (bothDirectionsPressed || noDirectionPressed) {
			state = States.Idle;
		} else {
			velocity.x = right ? speed : -speed;
			facing = right ? FlxObject.RIGHT : FlxObject.LEFT;
		}
	}

	function stateMachine(elapsed: Float) {
		switch (state) {
			case States.Sneaking:
				movement(SNEAK_SPEED);
				animation.play("sneaking");
				if (runBtnPressed) state = States.Running;
			case States.Running:
				movement(RUN_SPEED);
				animation.play("running");
				if (!runBtnPressed) state = States.Sneaking;
			case States.Gathering:
				animation.play("throwing");
				throwSeconds += elapsed;
				if (throwSeconds >= 1.5) {
					animation.pause();
				}
				if (singleDirectionPressed) {
					state = States.Sneaking;
				}
			case States.Idle:
				velocity.x = 0;
				throwSeconds = 0;
				animation.play("idle");
				if (singleDirectionPressed) {
					state = States.Sneaking;
				}
				if (throwBtnPressed) {
					throwPosition = new FlxPoint(x, y);
					state = States.Gathering;
				}
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

	override function update(elapsed: Float) {
		super.update(elapsed);
		updateControls();
		stateMachine(elapsed);
	}
}