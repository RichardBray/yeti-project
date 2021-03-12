package states;

import characters.Player;
import flixel.math.FlxPoint;
import utils.Controls;

/**
 * @todo make abstract class
 */
class LevelState extends GameState {
	final controls:Controls = Controls.instance;

	var player:Player;

	override public function create() {
		super.create();
	}

	public function createPlayer(x:Float = 0, y:Float = 0) {
		player = new Player(x, y);
		add(player);
	}

	/**
	 * Paths for snowball to follow
	 */
	function createProjectilePath() {
		var points:Array<FlxPoint> = [];

		for (i in 0...30) {
			points.push(new FlxPoint(0, 1 * i));
		}
		trace(points);
		// return points;
	}

	override public function update(elapsed:Float) {
		super.update(elapsed);

		if (controls.cross.check()) {
			createProjectilePath();
		}
	}
}