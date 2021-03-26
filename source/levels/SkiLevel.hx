package levels;

import flixel.FlxG;
import flixel.FlxSprite;

import states.LevelState;

final class SkiLevel extends LevelState {
	var background: FlxSprite;
	var foreground: FlxSprite;

	override public function create() {
		super.create();
		// - background
		background = new FlxSprite(0, 0);
		background.loadGraphic(
			"assets/images/environment/L3_BACKGROUND.png",
			FlxG.width,
			FlxG.height
		);
		add(background);
		// - general stuff
		prepareLevel(90, 400);
		// - foreground
		foreground = new FlxSprite(0, 551);
		foreground.loadGraphic(
			"assets/images/environment/L3_FOREGROUND.png",
			1920,
			529
		);
		add(foreground);
	}
}