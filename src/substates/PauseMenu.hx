package substates;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.text.FlxText;

import utils.Colors;

class PauseMenu extends FlxSubState {
	var bgOverlay: FlxSprite;
	var title: FlxText;

	override public function create() {
		super.create();

		bgOverlay = new FlxSprite();
		bgOverlay.makeGraphic(FlxG.width, FlxG.height, Colors.WHITE);
		add(bgOverlay);

		title = new FlxText("Game Paused");
		title.screenCenter(X);
		add(title);
	}

	function closeMenu() {
		close();
	}

	override public function update(elapsed: Float) {
		super.update(elapsed);

		if (FlxG.keys.justPressed.ESCAPE) closeMenu();
	}
}