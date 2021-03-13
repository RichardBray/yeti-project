package states;

import flixel.FlxG;
import flixel.FlxState;
import flixel.system.FlxAssets;
import utils.Colors;
import utils.LoadFile;

class GameState extends FlxState {
	private final pjson = LoadFile.json("./package.json");

	public var version = "";

	override public function create() {
		super.create();

		bgColor = Colors.grey;
		version = pjson.version;

		FlxAssets.FONT_DEFAULT = "assets/fonts/OpenSans-Regular.ttf";
		FlxG.autoPause = false;
		FlxG.camera.antialiasing = true;

		#if !debug
		FlxG.mouse.visible = false;
		#end
	}
}