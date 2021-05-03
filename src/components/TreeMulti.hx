package components;

import characters.Player;

import components.parents.HideableObjectGrp;

import flixel.FlxSprite;

import utils.Helpers;

final class TreeMulti extends HideableObjectGrp {
	/**
	 * Group of sprites to display tress and prompt when player overlaps.
	 *
	 * @param x x position
	 * @param y y position
	 * @param player player sprite for overlap
	 */
	public function new(x: Float = 0, y: Float = 0, player: Player) {
		// tree
		var trees = new FlxSprite();
		trees.frames = Helpers.loadFrames("environment/ski_level");
		trees.animation.frameName = "L3_TREES_LEFT.png";
		trees.setSize(180, 296);
		// hiding tree
		var hideTree = new FlxSprite();
		hideTree.frames = Helpers.loadFrames("environment/ski_level");
		hideTree.animation.frameName = "L3_TREES_LEFT_HIDE.png";
		hideTree.setSize(180, 296);

		super(trees, hideTree, x, y, player);
	}
}