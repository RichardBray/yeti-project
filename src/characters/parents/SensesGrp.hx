package characters.parents;

import characters.Player;

import components.Snowball;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup.FlxTypedSpriteGroup;

import ui.VisionCone;
final class SensesGrp extends FlxTypedSpriteGroup<FlxSprite> {
	// - overlaps
	var hearingOverlap = false;
	var visionOverlap = false;
	// - objects
	var visionCone: VisionCone;
	var hearingBound: FlxSprite;
	var character: SenseChar;
	var snowball: Snowball;
	var player: Player;

  // @formatter:off
	public function new(
    npc: SenseChar,
    x: Float = 0,
    y: Float = 0,
    player: Player,
    snowball: Snowball,
		vision: Bool = true
  ) {
		super(x, y, 3);
    // overlap objects
    this.player = player;
    this.snowball = snowball;
		// 1 - hearingBound
    hearingBound = new FlxSprite(0, 0);
    hearingBound.makeGraphic(320, 152);
    // add(hearingBound);
    // 2 - vision cone
    visionCone = new VisionCone();
    // add(visionCone);
    // 3 - character
    character = npc;
    add(character);
	}
  // @formatter:on
	function visionConeUpdates() {
		visionOverlap = senseTrigger(visionCone);
		visionCone.setPosition(
			(character.x - visionCone.width),
			(character.y - (visionCone.height / 2) + (character.height / 2))
		);
		if (visionOverlap) {
			character.isAlert();
		}

		// if (player vision overlap for more than two seconds) {
		//   player.isCaught = true;
		// }
	}

	function hearingBoundUpdate() {
		hearingOverlap = senseTrigger(hearingBound);
		hearingBound.x = (character.x + character.width);
		if (hearingOverlap) {
			character.isAlert();
			character.lookBehind();
		}
	}

	function sensesVisibility() {
		if (character.showSenses) {
			visionCone.alpha = 1;
			hearingBound.alpha = 1;
		} else {
			visionCone.alpha = 0;
			hearingBound.alpha = 0;
		}
	}

	/**
	 * Trigger when player or snowball overlaps
	 *
	 * @param sense Vision on hearing
	 */
	function senseTrigger(sense: FlxSprite): Bool {
		// @formatter:off
		return (
			(snowball.alpha == 1 && FlxG.overlap(sense, snowball))
			|| FlxG.overlap(sense, player)
		);
	}

	// @formatter:on
	override public function update(elapsed: Float) {
		super.update(elapsed);

		if (character.showSenses) {
			visionConeUpdates();
			hearingBoundUpdate();
		}
		sensesVisibility();
	}
}