package components;

import flixel.FlxSprite;
import flixel.math.FlxPoint;
import flixel.util.FlxPath;

import haxe.ds.Vector;

import utils.Colors;

final class Snowball extends FlxSprite {
	// - snowball gathered to be thrown
	public var gathered(default, null) = false;

	public function new(x: Float, y: Float) {
		super(x, y);
		makeGraphic(50, 50, Colors.white);
		alpha = 0;
	}

	/**
	 * Add path to snowball sprite
	 * @param snowballLinePath
	 * @param throwPosition
	 */
  // @formatter:off
	public function addThrowPath(
		snowballLinePath: Vector<FlxPoint>,
		throwPosition: FlxPoint
	) {
		final throwPath: Array<FlxPoint> = cast snowballLinePath;

		setPosition(throwPosition.x, throwPosition.y);
		path = new FlxPath(throwPath);
		gathered = true;

		// path.onComplete = (_) -> {
		// 	alpha = 0;
		// }
	}
  // @formatter:on
	public function followPath() {
		alpha = 1;
		path.start(null, 800, FlxPath.FORWARD);
		gathered = false;
	}
}