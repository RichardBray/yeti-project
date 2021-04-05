package components;

import characters.Player;

import flixel.FlxG;
import flixel.FlxSprite;

import utils.Colors;

// should be sprite grounp
// three sprites, two prompts
final class TreePickable extends FlxSprite {
	public var picked(default, null) = false;

	var playerOverlap = false;
	var player: Player;

	public function new(x: Float = 0, y: Float = 0, player: Player) {
		super(x, y);
		makeGraphic(100, 160, Colors.PURPLE);

		this.player = player;
	}

	function pickUp() {
		alpha = 0;
		picked = true;
	}

	public function putDown(newX: Float, newY: Float) {
		alpha = 1;
		picked = false;
		this.x = newX;
		this.y = newY;
	}

	override public function update(elapsed: Float) {
		super.update(elapsed / 2);

		playerOverlap = FlxG.overlap(player, this);

		// if (playerOverlap && pickupButtonPressed)
		//   pickUp();
	}
}