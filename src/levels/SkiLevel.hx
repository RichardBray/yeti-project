package levels;

import characters.Skier;

import components.FlagLeft;
import components.FlagRight;
import components.TreeMulti;
import components.TreePickable;
import components.TreeSingle;
import components.parents.HideableObject;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;

import states.LevelState;

final class SkiLevel extends LevelState {
	/**
	 * Group objects that can be hidden so picking and
	 * hiding does not happen at same time.
	 */
	var grpHideables: FlxTypedGroup<HideableObject>;

	var skierOverlap: FlxObject;
	var skier: Skier;

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
		// - hideables group
		grpHideables = new FlxTypedGroup<HideableObject>();
		add(grpHideables);
		// - hideable trees
		final treeMulti = new TreeMulti(267, 262, player);
		grpHideables.add(treeMulti);
		final treeSingle = new TreeSingle(1515, 242, player);
		grpHideables.add(treeSingle);
		// - pickable tree
		final treePickable = new TreePickable(1073, 378, player);
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
		// - skier NPC
		skier = new Skier(1921, 456);
		skierOverlap = new FlxObject(774, 415, 100, 147);
		add(skier);
		add(skierOverlap);
		// - flags
		final flagLeft = new FlagLeft(485, 614);
		add(flagLeft);
		final flagRight = new FlagRight(1386, 835);
		add(flagRight);

		addVersion();
	}

	override public function update(elapsed: Float) {
		super.update(elapsed);
		player.overHiddenObject = FlxG.overlap(player, grpHideables);
		skier.reachedSkiStart = FlxG.overlap(skier, skierOverlap);
	}
}