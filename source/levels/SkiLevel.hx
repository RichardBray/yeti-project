package levels;

import flixel.FlxG;
import flixel.FlxSprite;

import states.LevelState;

import utils.Colors;

final class SkiLevel extends LevelState {
	override public function create() {
		super.create();
		prepareLevel(90, 396);
		// - delete when real ground added
		final tempGround = new FlxSprite(0, 526);
		tempGround.makeGraphic(FlxG.width, 100, Colors.white);
		add(tempGround);
	}
}