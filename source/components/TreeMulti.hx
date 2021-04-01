package components;

import characters.Player;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup.FlxTypedSpriteGroup;

import ui.Prompt;

import utils.Controls;
import utils.Helpers;

final class TreeMulti extends FlxTypedSpriteGroup<FlxSprite> {
	var player: Player;
	var prompt: Prompt;
	var trees: FlxSprite;
	var hideTree: FlxSprite;

	var playerHidden = false;

	final controls = Controls.instance;

	/**
	 * Group of sprites to display rress and prompt when player overlaps.
	 * Max group sprites set to 3.
	 *
	 * @param x x position
	 * @param y y position
	 * @param player player sprite for overlap
	 */
	public function new(x: Float = 0, y: Float = 0, player: Player) {
		super(x, y, 3);
		// 1 - tree
		trees = new FlxSprite();
		trees.frames = Helpers.loadFrames("environment/ski_level");
		trees.animation.frameName = "L3_TREES_LEFT.png";
		trees.setSize(180, 296);
		add(trees);
		// 2 - hiding tree
		hideTree = new FlxSprite();
		hideTree.frames = Helpers.loadFrames("environment/ski_level");
		hideTree.animation.frameName = "L3_TREES_LEFT_HIDE.png";
		hideTree.setSize(180, 296);
		hideTree.alpha = 0;
		add(hideTree);
		// 3 - prompt
		prompt = new Prompt(15, y - 50, Hide);
		add(prompt);

		this.player = player;
	}

	// @formatter:off
	override public function update(elapsed: Float) {
		super.update(elapsed / 4);

		if (FlxG.overlap(player, this)) {
			prompt.show();

			if (controls.up.check() && !playerHidden) {
				player.hidePlayer();
				trees.alpha = 0;
				hideTree.alpha = 1;
				playerHidden = true;
			}
		} else {
			prompt.hide();
		}
	}
}