package states;

import characters.Player;

import flixel.FlxSprite;
import flixel.math.FlxPoint;

import haxe.ds.Vector;

import utils.Colors;

/**
 * @todo make abstract class
 */
class LevelState extends GameState {
	var player: Player;
	var startingPoint = new FlxPoint(90, 344);
	final GRAVITY = Math.abs(981);
	final velocity = new FlxPoint(200, 500);

	override public function create() {
		super.create();
	}

	public function createPlayer(x: Float = 0, y: Float = 0) {
		player = new Player(x, y);
		add(player);
	}

	/**
	 * Paths for snowball to follow
	 */
	function createProjectilePath() {
		final NO_OF_POINTS = 30;
		final points: Vector<FlxPoint> = new Vector(NO_OF_POINTS);

		for (i in 0...points.length) {
			final time = i / points.length;
			final pointCoordinates = calculateProjectilePoints(time);
			points[i] = new FlxPoint(pointCoordinates.x, pointCoordinates.y);
			final dot = new FlxSprite(
				pointCoordinates.x,
				pointCoordinates.y
			).makeGraphic(5, 5, Colors.white);
			add(dot);
		}

		trace(points);
		// js.Browser.console.log(points);
		// return points;
	}

	/**
	 * Formulas for trajectory
	 * x = startingPoint.x + velocity.x * time
	 * y = startingPoint.y + (velocity.y * time) - (gravity * time(2) / 2)
	 * @param time
	 * @return FlxPoint
	 */
	function calculateProjectilePoints(time: Float): {x: Float, y: Float} {
		var x = startingPoint.x + velocity.x * time;
		var y = startingPoint.y
			- ((velocity.y * time) - (GRAVITY * Math.pow(time, 2) / 2));
		return {
			x: x,
			y: y
		}
	}

	override public function update(elapsed: Float) {
		super.update(elapsed);

		if (player.playerState == States.Throwing) {
			createProjectilePath();
		}
	}
}