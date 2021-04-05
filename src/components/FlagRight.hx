package components;

import flixel.FlxSprite;

import utils.Helpers;

final class FlagRight extends FlxSprite {
	public function new(x: Float = 0, y: Float = 0) {
		super(x, y);
		frames = Helpers.loadFrames("environment/ski_level");
		animation.frameName = "L3_FLAG_RIGHT.png";
		setSize(32, 75);
	}
}