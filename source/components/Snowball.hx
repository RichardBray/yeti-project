package components;

import flixel.FlxSprite;
import flixel.math.FlxPoint;
import flixel.util.FlxPath;

import haxe.ds.Vector;

import utils.Colors;

final class Snowball extends FlxSprite {
	public var prepared(default, null) = false;

	public function new(x: Float, y: Float) {
		super(x, y);
		makeGraphic(50, 50, Colors.white);
	}

  // @formatter:off
	public function prepare(
		snowballPath: Vector<FlxPoint>,
		throwPosition: FlxPoint
	) {
		final throwPath: Array<FlxPoint> = cast snowballPath;

		setPosition(throwPosition.x, throwPosition.y);
		path = new FlxPath(throwPath);
		prepared = true;

		// path.onComplete = (_) -> {
		// 	alpha = 0;
		// }
	}
}