package states;

import characters.Player;

import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxPoint;

import haxe.ds.Vector;

import utils.Colors;

/**
 * @todo make abstract class
 */
class LevelState extends GameState {
	var player: Player;
	var yLimit = 200;
	final grpSnowballDots = new FlxTypedGroup<FlxSprite>(NO_OF_POINTS);

	final GRAVITY = 981;

	static inline final NO_OF_POINTS = 20;

	final velocity = new FlxPoint(590, 500);

	override public function create() {
		super.create();

		// set empty sprites in snowbll dot group
		for (_ in 0...NO_OF_POINTS) {
			final dot = new FlxSprite(0, 0).makeGraphic(5, 5, Colors.white);
			dot.alpha = 0;
			grpSnowballDots.add(dot);
		}
	}

	public function createPlayer(x: Float = 0, y: Float = 0) {
		player = new Player(x, y);
		add(player);
	}

	/**
	 * Paths for snowball to follow
	 */
	function createProjectilePath() {
		final points: Vector<FlxPoint> = new Vector(NO_OF_POINTS);
		final lowestTimeValue = maxTime() / NO_OF_POINTS;

		for (i in 0...NO_OF_POINTS) {
			final time = lowestTimeValue * i;
			final pointCoords = calculateProjectilePoints(time);
			final selectedDot = grpSnowballDots.members[i];

			selectedDot.setPosition(pointCoords.x, pointCoords.y);
			selectedDot.alpha = 1;
			// points[i] = new FlxPoint(pointCoordinates.x, pointCoordinates.y);
		}

		add(grpSnowballDots);
		grpSnowballDots.revive();
	}

	/**
	 * Formulas for trajectory x and y coords
	 * x = startingPoint.x + velocity.x * time
	 * y = startingPoint.y + (velocity.y * time) - (gravity * time(2) / 2)
	 * @param time
	 */
	function calculateProjectilePoints(time: Float): {x: Float, y: Float} {
		final x = player.throwPosition.x + velocity.x * time;
		final y = player.throwPosition.y
			- ((velocity.y * time) - (GRAVITY * Math.pow(time, 2) / 2));

		return {
			x: x,
			y: y
		}
	}

	function maxTime(): Float {
		final multiVelocity = velocity.y * velocity.y;
		final time = (velocity.y
			+ Math.sqrt(
				multiVelocity + 2 * GRAVITY * (player.throwPosition.y - yLimit)
			)) / GRAVITY;
		return time;
	}

	override public function update(elapsed: Float) {
		super.update(elapsed);

		if (player.state == States.Gathering) {
			createProjectilePath();
		}

		if (player.state != States.Gathering) {
			grpSnowballDots.kill();
		}
	}
}