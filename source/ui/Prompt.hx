package ui;

import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup.FlxTypedSpriteGroup;
import flixel.text.FlxText;

import utils.Colors;

enum Types {
	Hide;
	Pick;
}

class Prompt extends FlxTypedSpriteGroup<FlxSprite> {
	var box: FlxSprite;
	var text: FlxSprite;

	public function new(x: Float = 0, y: Float = 0, type: Types) {
		super(x, y, 2);
		// - prompt bg
		box = new FlxSprite().makeGraphic(300, 100, Colors.red);
		add(box);
		// - prompt text
		text = new FlxText(x, y, "Hide", 32);
		add(text);
	}

	public function show() {
		alpha = 1;
	}

	public function hide() {
		alpha = 0;
	}
}