package components;

import flixel.FlxSprite;
import flixel.util.FlxPath;
import utils.Colors;

final class Snowball extends FlxSprite {
	public function new(x:Float, y:Float, pathArg:FlxPath) {
		super(x, y);
		makeGraphic(50, 50, Colors.white);
		path = pathArg;
		path.start(null, 100, FlxPath.FORWARD);
	}
}