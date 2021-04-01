package ui;

import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup.FlxTypedSpriteGroup;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.typeLimit.OneOfTwo;

import utils.Colors;

enum Types {
	Hide;
	Pick;
}

class Prompt extends FlxTypedSpriteGroup<OneOfTwo<FlxSprite, FlxText>> {
	var box: FlxSprite;
	var text: FlxText;

	var showYPos: Float;
	var hideYPos: Float;

	static inline final TWEEN_SPEED = 0.35;

	public function new(x: Float = 0, y: Float = 0, type: Types) {
		super(x, y, 2);
		showYPos = y - 5;
		hideYPos = y;
		trace(x, y);
		// - prompt bg
		box = new FlxSprite().makeGraphic(150, 50, Colors.purple);
		add(box);
		// - prompt text
		text = new FlxText(0, 5, 150, "⬆️ to Hide", 24);
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
}