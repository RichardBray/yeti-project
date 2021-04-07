package;

import flixel.FlxGame;

import openfl.display.Sprite;

class Main extends Sprite {
	public function new() {
		super();
		// Resolution explicitly added here to enable game to scale properly
		// in different resolutions.
		addChild(new FlxGame(1920, 1080, levels.SkiLevel, true));
	}
}