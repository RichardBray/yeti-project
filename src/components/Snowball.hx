package components;

import flixel.FlxSprite;
import flixel.math.FlxPoint;
import flixel.util.FlxPath;

import haxe.ds.Vector;

import utils.Colors;

final class Snowball extends FlxSprite {
	static inline final THROW_SPEED = 1150;

	// - snowball gathered to be thrown
	public var gathered(default, null) = false;

	public function new(x: Float, y: Float) {
		super(x, y);
		makeGraphic(25, 25, Colors.WHITE);
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

		path.onComplete = (_) -> {
			haxe.Timer.delay(() -> alpha = 0, 150);
		}
	}

  // @formatter:on
	public function followPath() {
		alpha = 1;
		path.start(null, THROW_SPEED);
		gathered = false;
	}
}