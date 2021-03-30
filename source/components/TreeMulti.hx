package components;

import characters.Player;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup.FlxTypedSpriteGroup;

import ui.Prompt;

final class TreeMulti extends FlxTypedSpriteGroup<FlxSprite> {
	var player: Player;
	var prompt: Prompt;
	var trees: FlxSprite;

	public function new(x: Float = 0, y: Float = 0, player: Player) {
		super(x, y, 2);
		// - tree
		trees = new FlxSprite(x, y);
		trees.loadGraphic("assets/images/environment/L3_TREES_LEFT.png");
		add(trees);
		// - prompt
		prompt = new Prompt(x, y, Hide);
		add(prompt);

		this.player = player;
	}

	// @formatter:off
	override public function update(elapsed: Float) {
		super.update(elapsed / 4);

		(FlxG.overlap(player, this))
			? prompt.show()
			: prompt.hide();
	}
}