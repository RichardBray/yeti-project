package states;

import characters.Player;

import components.Snowball;
import components.SnowballPaths;

import flixel.FlxG;

/**
 * @todo make abstract class
 */
class LevelState extends GameState {
	var player: Player;
	var snowball: Snowball;
	var snowballPaths: SnowballPaths;

	override public function create() {
		super.create();
	}

	function prepareLevel(x: Float = 0, y: Float = 0) {
		// - add player
		player = new Player(x, y);
		add(player);
		// - prepare snowball path sprites
		snowballPaths = new SnowballPaths();
		snowballPaths.prepareDots();
		// - add snowball
		snowball = new Snowball(0, 0);
		add(snowball);
	}

	override public function update(elapsed: Float) {
		super.update(elapsed);

		if (player.state == Gathering) {
			snowballPaths.createThrowPath(player.throwPosition, this);
			snowball.addThrowPath(snowballPaths.line, player.throwPosition);
		} else {
			snowballPaths.killDots();
		}

		if (player.state == Throwing && snowball.gathered) {
			snowball.followPath();
		}

		if (player.state == Running) {
			FlxG.camera.shake(0.004, 0.15);
		}
	}
}