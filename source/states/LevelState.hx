package states;

import characters.Player;

import components.Snowball;

import flixel.util.FlxPath;

import utils.Colors;

/**
 * @todo make abstract class
 */
class LevelState extends GameState {
	var player: Player;
	var snowball: Snowball;
	var snowballPrepared = false;

	override public function create() {
		super.create();
	}

	function prepareLevel(x: Float = 0, y: Float = 0) {
		// - add player
		player = new Player(x, y);
		add(player);
		// - add invisible snowball
		snowball = new Snowball(0, 0);
		snowball.alpha = 0;
		snowball.prepareDots();
		add(snowball);
	}

	override public function update(elapsed: Float) {
		super.update(elapsed);

		if (player.state == States.Gathering) {
			snowball.createProjectilePath();
			snowball.prepareSnowball();
		} else {
			snowball.killDots();
		}

		if (player.state == States.Throwing && snowballPrepared) {
			snowball.alpha = 1;
			snowball.path.start(null, 800, FlxPath.FORWARD);
			snowballPrepared = false;
		}
	}
}