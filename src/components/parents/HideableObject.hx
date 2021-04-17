package components.parents;

import characters.Player;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup.FlxTypedSpriteGroup;

import shaders.Outline;

import ui.Prompt;

import utils.Controls;

/**
 * @abstract
 */
class HideableObject extends FlxTypedSpriteGroup<FlxSprite> {
	var hidePrompt: Prompt;
	var unhidePrompt: Prompt;
	var player: Player;
	var visibleSprite: FlxSprite;
	var hiddenSprite: FlxSprite;

	var playerOverlap = false;
	var outlineShader: Outline;

	/**
	 * Hack to delay registering of controls
	 */
	var controlsDelay = false;

	final controls = Controls.instance;

  // @formatter:off
	/**
	 * Makes object hidable by adding prompt, and interaction for player overlap.
   *
	 * @param visibleSprite Sprite to show when player is not hiding behind it
	 * @param hiddenSprite Sprite to show when player is hidden
	 * @param x x position
	 * @param y y position
	 * @param player player sprite used for overlap
	 */
	public function new(
    visibleSprite: FlxSprite,
    hiddenSprite: FlxSprite,
		x: Float = 0,
    y: Float = 0,
    player: Player
  ) {
		super(x, y, 4);

    // 1 - visible sprite
    this.visibleSprite = visibleSprite;
		// shader prep
		outlineShader = new Outline();
    add(visibleSprite);
    // 2 - hidden sprite
    this.hiddenSprite = hiddenSprite;
    hiddenSprite.alpha = 0;
    add(hiddenSprite);
		// 3 - hidePrompt
    final pos = Prompt.promptPosition(visibleSprite, this);
		hidePrompt = new Prompt(pos.x, pos.y, Hide);
		add(hidePrompt);
		// 4 - unhidePrompt
		unhidePrompt = new Prompt(pos.x, pos.y, Unhide);
		add(unhidePrompt);
		// add player
    this.player = player;
	}

	/**
	 * Toggle prompt alphas
	 */
	function promptToggles() {
		if (playerOverlap && player.state != Hiding) {
			hidePrompt.show();
			visibleSprite.shader = outlineShader;
		} else {
			hidePrompt.hide();
			visibleSprite.shader = null;
		}

		if (playerOverlap) {
			(player.state == Hiding)
        ? unhidePrompt.show()
        : unhidePrompt.hide();
		}
	}

  // @formatter:on
	/**
	 * Toggle sprites and player alphas
	 */
	function spriteToggels() {
		if (playerOverlap && controls.up.check() && !controlsDelay) {
			player.hidePlayer();
			visibleSprite.alpha = 0;
			hiddenSprite.alpha = 1;
			haxe.Timer.delay(() -> controlsDelay = true, 250);
		}

		if (player.state == Hiding && controls.up.check() && controlsDelay) {
			player.showPlayer();
			visibleSprite.alpha = 1;
			hiddenSprite.alpha = 0;
			haxe.Timer.delay(() -> controlsDelay = false, 250);
		}
	}

	override public function update(elapsed: Float) {
		super.update(elapsed / 2);
		playerOverlap = FlxG.overlap(player, this);

		if (player.state == Idle || player.state == Hiding) {
			spriteToggels();
			promptToggles();
		}
	}
}