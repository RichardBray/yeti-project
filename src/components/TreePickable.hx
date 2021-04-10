package components;

import characters.Player;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup.FlxTypedSpriteGroup;

import ui.Prompt;

import utils.Colors;
import utils.Controls;

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
		testSprt.makeGraphic(100, 160, Colors.PURPLE);
		add(testSprt);
		// 2 - pickup prompt
		promptPost = Prompt.promptPosition(testSprt, this);
		pickPrompt = new Prompt(promptPost.x, promptPost.y, Pick);
		add(pickPrompt);
		// 3- put down prompt
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

	function promptToggles() {
		if (playerOverlap && player.state != Picking) {
			pickPrompt.show();
		} else {
			pickPrompt.hide();
		}
	}

	function updatePromptPosition() {}

	function spriteToggels() {
		if (playerOverlap && controls.up.check() && !controlsDelay) {
			player.pickedUpItem(PickupItem.Tree);
			testSprt.alpha = 0;
			haxe.Timer.delay(() -> controlsDelay = true, 250);
		}

		if (player.state == Picking && controls.up.check() && controlsDelay) {
			player.putDownItem();
			testSprt.alpha = 1;
			testSprt.x = player.itemDownPosition.x;
			pickPrompt.x = promptPost.x + player.itemDownPosition.x;
			haxe.Timer.delay(() -> controlsDelay = false, 250);
		}
	}

	override public function update(elapsed: Float) {
		super.update(elapsed / 2);

		playerOverlap = FlxG.overlap(player, this);
		if (testSprt.alpha == 1) {
			promptToggles();
		}

		spriteToggels();
	}
}