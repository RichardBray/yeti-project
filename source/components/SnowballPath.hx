package components;

import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxPoint;

import haxe.ds.Vector;

import utils.Colors;

final class SnowballPath {
	static inline final Y_LIMIT = 200;
	static inline final GRAVITY = 981;
	static inline final NO_OF_POINTS = 20;

	public final grpDots = new FlxTypedGroup<FlxSprite>(NO_OF_POINTS);
	public final line: Vector<FlxPoint> = new Vector(NO_OF_POINTS);

	final throwVelocity = new FlxPoint(590, 500);
	var throwPosition: FlxPoint;

	public function new(throwPosition: FlxPoint) {
		this.throwPosition = throwPosition;
	}

	/**
	 * Paths for snowball to follow
	 */
	public function createProjectilePath() {
		final lowestTimeValue = timeValue() / NO_OF_POINTS;

		for (i in 0...NO_OF_POINTS) {
			final time = lowestTimeValue * i;
			final pointCoords = calculateProjectilePoints(time);
			final selectedDot = grpDots.members[i];

			selectedDot.setPosition(pointCoords.x, pointCoords.y);
			selectedDot.alpha = 1;
			line[i] = new FlxPoint(pointCoords.x, pointCoords.y);
		}

		// add(grpDots);
		grpDots.revive();
	}

	/**
	 * Set empty sprites in snowbll dot group
	 */
	public function prepareDots() {
		for (_ in 0...NO_OF_POINTS) {
			final dot = new FlxSprite(0, 0).makeGraphic(5, 5, Colors.white);
			dot.alpha = 0;
			grpDots.add(dot);
		}
	}

	public function killDots() {
		grpDots.kill();
	}

	/**
	 * Formulas for trajectory x and y coords
	 * x = startingPoint.x + throwVelocity.x * time
	 * y = startingPoint.y + (throwVelocity.y * time) - (gravity * time(2) / 2)
	 *
	 * @param time
	 */
	function calculateProjectilePoints(time: Float): {x: Float, y: Float} {
		final x = throwPosition.x + throwVelocity.x * time;
		final y = throwPosition.y
			- ((throwVelocity.y * time) - (GRAVITY * Math.pow(time, 2) / 2));

		return {
			x: x,
			y: y
		}
	}

	/**
	 * Get time value to manually position lowest point of trajectory
	 */
	function timeValue(): Float {
		final multiVelocity = throwVelocity.y * throwVelocity.y;
		final time = (throwVelocity.y
			+ Math.sqrt(
				multiVelocity + 2 * GRAVITY * (throwPosition.y - Y_LIMIT)
			)) / GRAVITY;
		return time;
	}
}