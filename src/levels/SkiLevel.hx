package levels;

import components.FlagLeft;
import components.FlagRight;
import components.TreeMulti;
import components.TreePickable;
import components.TreeSingle;

import flixel.FlxG;
import flixel.FlxSprite;

import states.LevelState;

final class SkiLevel extends LevelState {
	override public function create() {
		super.create();
		// - general
		prepareLevel(54, 400);
		// - background
		final background = new FlxSprite(0, 0);
		background.loadGraphic(
			"assets/images/environment/L3_BACKGROUND.png",
			FlxG.width,
			FlxG.height
		);
		add(background);
		// - hideable trees
		final treeSingle = new TreeSingle(1515, 242, player);
		add(treeSingle);
		final treeMulti = new TreeMulti(267, 262, player);
		add(treeMulti);
		// - pickable tree
		final treePickable = new TreePickable(1073, 395, player);
		add(treePickable);
		// - player
		addPlayer();
		// - foreground
		final foreground = new FlxSprite(0, 551);
		foreground.loadGraphic(
			"assets/images/environment/L3_FOREGROUND.png",
			1920,
			529
		);
		add(foreground);
		// - flags
		final flagLeft = new FlagLeft(485, 614);
		add(flagLeft);
		final flagRight = new FlagRight(1386, 835);
		add(flagRight);

		addVersion();
	}
}