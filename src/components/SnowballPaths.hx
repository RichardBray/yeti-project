package components;

import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxPoint;

import haxe.ds.Vector;

import utils.Colors;

final class SnowballPaths {
	static inline final SURFACE = 190;
	static inline final GRAVITY = 981;
	static inline final NO_OF_POINTS = 20;

	final throwVelocity = new FlxPoint(590, 500);

	var playerThrowPos: FlxPoint;

	public final linePath: Vector<FlxPoint> = new Vector(NO_OF_POINTS);

	public function new() {}

	// @formatter:off
	/**
	 * Paths for snowball to follow
	 *
	 * @param throwPos player throw position
	 * @param grpDots used to add dots to level
	 * @param playerFacing used to determine path position
	 */
	public function createThrowPath(
		throwPos: FlxPoint,
		grpDots: FlxTypedGroup<FlxSprite>,
		playerFacing: Int
	) {
		playerThrowPos = throwPos;
		final flightTimeBetweenPoints = timeOfFlight() / NO_OF_POINTS;
		// Flip dots if based on player facing
		throwVelocity.x = (playerFacing == FlxObject.LEFT)
			? -Math.abs(throwVelocity.x)
			: Math.abs(throwVelocity.x);

		for (i in 0...NO_OF_POINTS) {
			final time = flightTimeBetweenPoints * i;
			final pointCoords = calculateProjectilePoints(time);
			final singleDotFromGrp = grpDots.members[i];

			linePath[i] = new FlxPoint(pointCoords.x, pointCoords.y);
			singleDotFromGrp.setPosition(pointCoords.x, pointCoords.y);
			singleDotFromGrp.alpha = 1;
		}
	}
  // @formatter:on
	/**
	 * Set empty sprites in snowbll dot group
	 */
	public function createDots(): FlxTypedGroup<FlxSprite> {
		final color = Colors.SNOWBALL_PATH;
		color.alpha = 50;
		final grpDots = new FlxTypedGroup<FlxSprite>(NO_OF_POINTS);

		for (_ in 0...NO_OF_POINTS) {
			final dot = new FlxSprite(0, 0).makeGraphic(5, 5, color);
			dot.alpha = 0;
			grpDots.add(dot);
		}

		return grpDots;
	}

	public function killDots(grpDots: FlxTypedGroup<FlxSprite>) {
		grpDots.forEach((member: FlxSprite) -> {
			member.alpha = 0;
		});
	}

	/**
	 * Formulas for trajectory x and y coords
	 * x = startingPoint.x + velocity.x * time
	 * y = startingPoint.y + (velocity.y * time) - (gravity * time² / 2)
	 */
	function calculateProjectilePoints(time: Float): {x: Float, y: Float} {
		final x = playerThrowPos.x + throwVelocity.x * time;
		final y = playerThrowPos.y
			- ((throwVelocity.y * time) - (GRAVITY * Math.pow(time, 2) / 2));

		return {
			x: x,
			y: y
		}
	}

	/**
	 * Get time value to manually position lowest point of trajectory
	 * (velocity.y + √ (velocity.y² + 2 * gravity * (startingPoint.y - surface))) / gravity
	 */
	function timeOfFlight(): Float {
		final velocityYSquared = throwVelocity.y * throwVelocity.y;
		return (throwVelocity.y
			+ Math.sqrt(
				velocityYSquared + 2 * GRAVITY * (playerThrowPos.y - SURFACE)
			)) / GRAVITY;
	}
}