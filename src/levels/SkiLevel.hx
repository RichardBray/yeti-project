package levels;

import components.FlagLeft;
import components.FlagRight;
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
	var flagLeft: FlxSprite;
	var flagRight: FlxSprite;

	override public function create() {
		super.create();
		// - general
		prepareLevel(54, 400);
		// - background
		background = new FlxSprite(0, 0);
		background.loadGraphic(
			"assets/images/environment/L3_BACKGROUND.png",
			FlxG.width,
			FlxG.height
		);
		add(background);
		// - trees
		treeSingle = new TreeSingle(1515, 242, player);
		add(treeSingle);
		treeMulti = new TreeMulti(267, 262, player);
		add(treeMulti);
		// - player
		addPlayer();
		// - foreground
		foreground = new FlxSprite(0, 551);
		foreground.loadGraphic(
			"assets/images/environment/L3_FOREGROUND.png",
			1920,
			529
		);
		add(foreground);
		// - flags
		flagLeft = new FlagLeft(485, 614);
		add(flagLeft);
		flagRight = new FlagRight(1386, 835);
		add(flagRight);

		addVersion();
	}
}