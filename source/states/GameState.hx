package states;

import flixel.FlxG;
import flixel.FlxState;
import flixel.text.FlxText;
import utils.Colors;
import utils.LoadFile;

class GameState extends FlxState {
	private final pjson = LoadFile.json("./package.json");

	public var version = "";

	override public function create() {
		super.create();
		bgColor = Colors.grey;
		version = pjson.version;

		FlxG.autoPause = false;
		FlxG.camera.antialiasing = true;

		add(new FlxText('Hello World ${version}', 32).screenCenter());
	}

	override public function update(elapsed:Float) {
		super.update(elapsed);
	}
}