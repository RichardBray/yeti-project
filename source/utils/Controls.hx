package utils;

import flixel.input.actions.FlxAction.FlxActionDigital;

final class Controls {
	public var left:FlxActionDigital;
	public var right:FlxActionDigital;
	public var circle:FlxActionDigital;

	public static final instance:Controls = new Controls();

	private function new() {
		initInputs();
		keyboardInputs();
	}

	function initInputs() {
		left = new FlxActionDigital();
		right = new FlxActionDigital();
		circle = new FlxActionDigital();
	}

	function keyboardInputs() {
		// - left
		left.addKey(LEFT, PRESSED);
		left.addKey(A, PRESSED);
		// - right
		right.addKey(RIGHT, PRESSED);
		right.addKey(D, PRESSED);
		// - circle
		circle.addKey(SHIFT, PRESSED);
	}
}