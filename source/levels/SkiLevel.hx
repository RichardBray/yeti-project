package levels;

import flixel.FlxSprite;

import states.LevelState;

import utils.Colors;

final class SkiLevel extends LevelState {
	override public function create() {
		super.create();
		createPlayer(90, 337);
		// - delete when real ground added
		final tempGround = new FlxSprite(0, 585);
		tempGround.makeGraphic(1920, 100, Colors.white);
		add(tempGround);
	}
}