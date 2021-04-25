package ui;

import flixel.FlxSprite;

import utils.Colors;

final class VisionCone extends FlxSprite {
	public function new(x: Float = 0, y: Float = 0) {
		super(x, y);
		makeGraphic(320, 152, Colors.PURPLE);
	}
}