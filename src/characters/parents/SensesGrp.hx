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
    // 1 - hearing hearingBound
    hearingBound = new FlxSprite();
    hearingBound.makeGraphic(320, 152);
    add(hearingBound);
    // 2 - vision cone
    visionCone = new VisionCone();
    add(visionCone);
    // 3 - character
    character = npc;
    add(character);
	}
  // @formatter:on
	function visionConeUpdates() {
		visionCone.setPosition(
			(character.x - visionCone.width),
			(character.y - (visionCone.height / 2) + (character.height / 2))
		);
	}

	function hearingBoundUpdate() {
		hearingBound.x = (character.x + character.width);
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

	override public function update(elapsed: Float) {
		super.update(elapsed);

		visionConeUpdates();
		hearingBoundUpdate();
		sensesVisibility();

		hearingOverlap = (FlxG.overlap(hearingBound, snowball)
			|| FlxG.overlap(hearingBound, player));
		visionOverlap = (FlxG.overlap(visionCone, snowball)
			|| FlxG.overlap(visionCone, player));

		if (hearingOverlap || visionOverlap) {
			character.isAlert = true;
		}

		if (hearingOverlap) {
			character.lookBehind();
		}
	}
}