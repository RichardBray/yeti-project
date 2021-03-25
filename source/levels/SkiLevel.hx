package levels;

import flixel.FlxG;
import flixel.FlxSprite;

import states.LevelState;

import utils.Colors;

final class SkiLevel extends LevelState {
	var tempGround: FlxSprite;

	override public function create() {
		super.create();
		prepareLevel(90, 396);
		// - delete when real ground added
		tempGround = new FlxSprite(0, 526);
		tempGround.makeGraphic(FlxG.width, 100, Colors.white);
		tempGround.immovable = true;
		add(tempGround);
	}

	override public function update(elapsed: Float) {
		super.update(elapsed);
		FlxG.collide(snowball, tempGround);
	}
}