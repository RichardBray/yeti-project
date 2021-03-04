package;

import flixel.FlxState;
import flixel.text.FlxText;
import utils.LoadFile;

class PlayState extends FlxState {
	final pjson = LoadFile.json("./package.json");

	override public function create() {
		super.create();
		trace(pjson, "test");
		add(new FlxText('Hello World ${pjson.version}', 32).screenCenter());
	}

	override public function update(elapsed:Float) {
		super.update(elapsed);
	}
}