package states;

import characters.Player;

import components.Snowball;
import components.SnowballPaths;

import flixel.FlxG;
import flixel.FlxObject;

/**
 * @todo make abstract class
 */
class LevelState extends GameState {
	var player: Player;
	var snowball: Snowball;
	var snowballPaths: SnowballPaths;
	var leftBound: FlxObject;

	override public function create() {
		super.create();
	}

	/**
	 * Elements that need to be prepared for all the levels
	 *
	 * @param playerX Starting x pos
	 * @param playerY Starting y pos
	 */
	function prepareLevel(playerX: Float = 0, playerY: Float = 0) {
		// - left bound
		leftBound = new FlxObject(0, 0, 5, FlxG.height);
		leftBound.immovable = true;
		add(leftBound);
		// - prepare player
		player = new Player(playerX, playerY);
		// - prepare snowball path sprites
		snowballPaths = new SnowballPaths();
		snowballPaths.prepareDots();
		// - prepare snowball
		snowball = new Snowball(0, 0);
	}

	/**
	 * Seperate add method for level ordering purposes
	 */
	function addPlayer() {
		add(player);
		add(snowball);
	}

	override public function update(elapsed: Float) {
		super.update(elapsed);

		if (player.state == Gathering) {
			snowballPaths.createThrowPath(
				player.throwPosition,
				this,
				player.facing
			);
			snowball.addThrowPath(snowballPaths.line, player.throwPosition);
		} else {
			snowballPaths.killDots();
		}

		if (player.state == Throwing && snowball.gathered) {
			snowball.followPath();
		}

		FlxG.collide(player, leftBound);
	}
}