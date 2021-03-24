package states;

import flixel.FlxG;
import flixel.FlxState;
import flixel.system.FlxAssets;
import flixel.text.FlxText;

import utils.Colors;
import utils.LoadFile;

class GameState extends FlxState {
	private final pjson = LoadFile.json("./package.json");

	override public function create() {
		super.create();
		bgColor = Colors.grey;

		FlxAssets.FONT_DEFAULT = "assets/fonts/OpenSans-Regular.ttf";

		final versionText = new FlxText(
			FlxG.width - 70,
			FlxG.height - 50,
			pjson.version,
			20
		);
		versionText.scrollFactor.set(0, 0);

		add(versionText);

		FlxG.autoPause = false;
		FlxG.camera.antialiasing = true;
		FlxG.mouse.useSystemCursor = true;

		#if !debug
		FlxG.mouse.visible = false;
		#else
		flixel.addons.studio.FlxStudio.create();
		#end
	}
}