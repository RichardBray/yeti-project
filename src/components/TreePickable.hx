package components;

import characters.Player;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup.FlxTypedSpriteGroup;

import ui.Prompt;

import utils.Controls;
import utils.Helpers;

// should be sprite grounp
// three sprites, two prompts
final class TreePickable extends FlxTypedSpriteGroup<FlxSprite> {
	public var picked(default, null) = false;

	var pickPrompt: Prompt;
	var putDownPrompt: Prompt;
	var testSprt: FlxSprite;
	var player: Player;
	var promptPost: {x: Float, y: Float} = {x: 0, y: 0};

	var playerOverlap = false;

	/**
	 * Hack to delay registering of controls
	 */
	var controlsDelay = false;

	final controls = Controls.instance;

	public function new(x: Float = 0, y: Float = 0, player: Player) {
		super(x, y, 3);
		// 1 - visible sprite
		testSprt = new FlxSprite();
		testSprt.frames = Helpers.loadFrames("environment/ski_level");
		testSprt.animation.frameName = "TREE_PICKABLE.png";
		testSprt.setSize(81, 184);
		add(testSprt);
		// 2 - pickup prompt
		promptPost = Prompt.promptPosition(testSprt, this);
		pickPrompt = new Prompt(promptPost.x, promptPost.y, Pick);
		add(pickPrompt);
		// 3 - put down prompt
		putDownPrompt = new Prompt(promptPost.x, promptPost.y, Putdown);
		add(putDownPrompt);
		// add player
		this.player = player;
	}

	public function putDown(newX: Float, newY: Float) {
		alpha = 1;
		picked = false;
		this.x = newX;
		this.y = newY;
	}

	// @formatter:off
	function promptToggles() {
		switch (player.state) {
			case Carrying:
				pickPrompt.hide();
				putDownPrompt.alpha = 0;
			case Picking:
				pickPrompt.hide();
				haxe.Timer.delay(() -> putDownPrompt.show(), 250);
			case Idle:
				putDownPrompt.alpha = 0;
			default:
				(playerOverlap)
				? pickPrompt.show()
				: pickPrompt.hide();
		}
	}

	// @formatter:on
	function spriteToggels() {
		// - update prompt positon when player stops
		putDownPrompt.x = promptPost.x + player.stopPosition.x;

		if (playerOverlap && controls.up.check() && !controlsDelay) {
			player.pickedUpItem(PickupItem.Tree);
			testSprt.alpha = 0;
			haxe.Timer.delay(() -> controlsDelay = true, 250);
		}

		if (player.state == Picking && controls.up.check() && controlsDelay) {
			player.putDownItem();
			testSprt.alpha = 1;
			testSprt.x = player.itemDownPosition.x;
			// - update prompt positions based on where player has dropped object
			pickPrompt.x = promptPost.x + player.itemDownPosition.x;
			haxe.Timer.delay(() -> controlsDelay = false, 250);
		}
	}

	override public function update(elapsed: Float) {
		super.update(elapsed / 2);

		playerOverlap = FlxG.overlap(player, this);

		if (!player.overHiddenObject) {
			promptToggles();
			spriteToggels();
		}
	}
}