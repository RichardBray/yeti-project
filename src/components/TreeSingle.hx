package components;

import characters.Player;

import components.parents.HideableObject;

import flixel.FlxSprite;

import utils.Helpers;

final class TreeSingle extends HideableObject {
	public function new(x: Float = 0, y: Float = 0, player: Player) {
		// - visibleTree
		var visibleTree = new FlxSprite();
		visibleTree.frames = Helpers.loadFrames("environment/ski_level");
		visibleTree.animation.frameName = "L3_TREE_RIGHT.png";
		visibleTree.setSize(83, 324);
		// - hiddenTree
		var hiddenTree = new FlxSprite();
		hiddenTree.frames = Helpers.loadFrames("environment/ski_level");
		hiddenTree.animation.frameName = "L3_TREE_RIGHT_HIDE.png";
		hiddenTree.setSize(89, 324);

		super(visibleTree, hiddenTree, x, y, player);
	}
}