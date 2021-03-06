package components;

import flixel.FlxSprite;

import utils.Helpers;

final class FlagLeft extends FlxSprite {
	public function new(x: Float = 0, y: Float = 0) {
		super(x, y);
		frames = Helpers.loadFrames("environment/ski_level");
		animation.frameName = "L3_FLAG_LEFT.png";
		setSize(31, 73);
	}
}