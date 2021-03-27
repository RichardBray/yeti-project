package levels;

import components.TreeMulti;
import components.TreeSingle;

import flixel.FlxG;
import flixel.FlxSprite;

import states.LevelState;

final class SkiLevel extends LevelState {
	var background: FlxSprite;
	var foreground: FlxSprite;
	var treeSingle: FlxSprite;
	var treeMulti: FlxSprite;

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
		// - trees
		treeSingle = new TreeSingle(1515, 242);
		add(treeSingle);
		treeMulti = new TreeMulti(187, 262);
		add(treeMulti);
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