package;

import flixel.FlxState;
import flixel.text.FlxText;
import utils.LoadFile;

class PlayState extends FlxState {
	// final pjson = LoadFile.json("/Users/richardoliverbray/yeti-project/package.json");
	override public function create() {
		super.create();
		add(new FlxText('Hello World', 32).screenCenter());
	}

	override public function update(elapsed:Float) {
		super.update(elapsed);
	}
}