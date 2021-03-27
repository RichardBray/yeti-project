package components;

import flixel.FlxSprite;

final class FlagLeft extends FlxSprite {
	public function new(x: Float = 0, y: Float = 0) {
		super(x, y);
		loadGraphic("assets/images/environment/L3_FLAG_LEFT.png");
	}
}