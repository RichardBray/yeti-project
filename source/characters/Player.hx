package characters;

import flixel.FlxObject;
import flixel.FlxSprite;
import utils.Colors;
import utils.Controls;

enum States {
	Sneaking;
	Running;
	Idle;
}

final class Player extends FlxSprite {
	final SNEAK_SPEED = 125;
	final RUN_SPEED = 250;
	final controls:Controls = Controls.instance;

	var playerState:States = States.Idle;
	// - controls
	var left = false;
	var right = false;
	var runBtnPressed = false;
	// - control mods
	var bothDirectionsPressed = false;
	var singleDirectionPressed = false;
	var noDirectionPressed = false;

	public function new(x:Float = 0, y:Float = 0) {
		super(x, y);
		makeGraphic(100, 200, Colors.white);
		drag.x = RUN_SPEED * 4;

		setFacingFlip(FlxObject.LEFT, true, false);
		setFacingFlip(FlxObject.RIGHT, false, false);
	}

	function movement(speed:Int) {
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
				if (runBtnPressed) playerState = States.Running;
			case States.Running:
				movement(RUN_SPEED);
				if (!runBtnPressed) playerState = States.Sneaking;
			case States.Idle:
				velocity.x = 0;
				if (singleDirectionPressed) playerState = States.Sneaking;
		}
	}

	function updateControls() {
		left = controls.left.check();
		right = controls.right.check();
		runBtnPressed = controls.circle.check();

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