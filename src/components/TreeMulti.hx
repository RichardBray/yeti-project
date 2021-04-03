package components;

import characters.Player;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup.FlxTypedSpriteGroup;

import shaders.Outline;

import ui.Prompt;

import utils.Colors;
import utils.Controls;
import utils.Helpers;

final class TreeMulti extends FlxTypedSpriteGroup<FlxSprite> {
	var player: Player;
	var hidePrompt: Prompt;
	var unhidePrompt: Prompt;
	var trees: FlxSprite;
	var hideTree: FlxSprite;

	var playerOverlap = false;
	var outlineShader: Outline;

	/**
	 * Hack to delay registering of controls
	 */
	var controlsDelay = false;

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
		super(x, y, 4);
		// 1 - tree
		trees = new FlxSprite();
		trees.frames = Helpers.loadFrames("environment/ski_level");
		trees.animation.frameName = "L3_TREES_LEFT.png";
		trees.setSize(180, 296);
		add(trees);
		// shader prep
		outlineShader = new Outline();
		// 2 - hiding tree
		hideTree = new FlxSprite();
		hideTree.frames = Helpers.loadFrames("environment/ski_level");
		hideTree.animation.frameName = "L3_TREES_LEFT_HIDE.png";
		hideTree.setSize(180, 296);
		hideTree.alpha = 0;
		add(hideTree);
		// 3 - hidePrompt
		hidePrompt = new Prompt(15, y - 50, Hide);
		add(hidePrompt);
		// 4 - unhidePrompt
		unhidePrompt = new Prompt(15, y - 50, Unhide);
		add(unhidePrompt);

		this.player = player;
	}

	// @formatter:off
	/**
	 * Toggle prompt alphas
	 */
	function promptToggles() {
		if (playerOverlap && player.state != Hiding) {
			hidePrompt.show();
			trees.shader = outlineShader;
		} else {
			hidePrompt.hide();
			trees.shader = null;
		}

		(player.state == Hiding)
			? unhidePrompt.show()
			: unhidePrompt.hide();
	}

	// @formatter:on
	/**
	 * Toggle tress and player alphas
	 */
	function spriteToggels() {
		if (playerOverlap && controls.up.check() && !controlsDelay) {
			player.hidePlayer();
			trees.alpha = 0;
			hideTree.alpha = 1;
			haxe.Timer.delay(() -> controlsDelay = true, 250);
		}

		if (player.state == Hiding && controls.up.check() && controlsDelay) {
			player.showPlayer();
			trees.alpha = 1;
			hideTree.alpha = 0;
			haxe.Timer.delay(() -> controlsDelay = false, 250);
		}
	}

	override public function update(elapsed: Float) {
		super.update(elapsed / 2);

		playerOverlap = FlxG.overlap(player, this);
		promptToggles();
		spriteToggels();
	}
}