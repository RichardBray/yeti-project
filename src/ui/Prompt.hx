package ui;

import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup.FlxTypedSpriteGroup;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.typeLimit.OneOfTwo;

import utils.Colors;

enum Types {
	Putdown;
	Hide;
	Unhide;
	Pick;
}

class Prompt extends FlxTypedSpriteGroup<OneOfTwo<FlxSprite, FlxText>> {
	public static inline final WIDTH = 200;
	static inline final HEIGHT = 50;
	static inline final TWEEN_SPEED = 0.25;

	var box: FlxSprite;
	var text: FlxText;

	var showYPos: Float;
	var hideYPos: Float;

	public function new(x: Float = 0, y: Float = 0, type: Types) {
		super(x, y, 2);
		showYPos = y - 5;
		hideYPos = y;

		// 1 - prompt bg
		box = new FlxSprite().makeGraphic(WIDTH, HEIGHT, Colors.PROMPT_BG);
		add(box);
		// 2 - prompt text
		text = new FlxText(0, 5, WIDTH, promptText(type), 24);
		text.alignment = FlxTextAlign.CENTER;
		add(text);

		alpha = 0;
	}

	public function show() {
		FlxTween.tween(
			this,
			{y: showYPos, alpha: 1},
			TWEEN_SPEED,
			{ease: FlxEase.cubeIn}
		);
	}

	public function hide() {
		FlxTween.tween(
			this,
			{y: hideYPos, alpha: 0},
			TWEEN_SPEED,
			{ease: FlxEase.cubeIn}
		);
	}

	// @formatter:off
	/**
	 * Calculates center x pos for prompt
	 * @param prompt
	 * @param parentSprt
	 */
	public static function promptPosition(
		parentSprt: FlxSprite,
		parentGroup: FlxTypedSpriteGroup<FlxSprite>
	): { x: Float, y: Float} {
		final promptMid = WIDTH / 2;
		final spriteMid = parentSprt.width / 2;

		final xPos: Float = (spriteMid < promptMid)
			? (spriteMid - promptMid)
			: (promptMid - spriteMid);
		final yPos = parentGroup.y - 50;

		return {x: xPos, y: yPos};
	}

	// @formatter:on
	inline function promptText(type: Types): String {
		switch (type) {
			case Hide:
				return "⬆️ to Hide";
			case Unhide:
				return "⬆️ to Unhide";
			case Pick:
				return "⬆️ to Pick up";
			case Putdown:
				return "⬆️ to Put down";
		}
	}
}