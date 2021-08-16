package states;

import characters.Player;

import components.Snowball;
import components.SnowballPaths;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;

import substates.PauseMenu;

abstract class LevelState extends GameState {
	var player: Player;
	var snowball: Snowball;
	var snowballPaths: SnowballPaths;
	var snowballPathDots: FlxTypedGroup<FlxSprite>;
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
		// - prepare snowball path sprites
		snowballPaths = new SnowballPaths();
		snowballPathDots = snowballPaths.createDots();
		// - prepare player
		player = new Player(playerX, playerY);
		// - prepare snowball
		snowball = new Snowball(0, 0);
	}

	/**
	 * Seperate add method for level ordering purposes
	 */
	function addPlayer() {
		add(snowballPathDots);
		add(player);
		add(snowball);
	}

	override public function update(elapsed: Float) {
		super.update(elapsed);

		if (player.state == Gathering) {
			snowballPaths.createThrowPath(
				player.throwPosition,
				snowballPathDots,
				player.facing
			);
			snowball.addThrowPath(snowballPaths.linePath,
				player.throwPosition);
		} else {
			snowballPaths.killDots(snowballPathDots);
		}

		if (player.state == Throwing && snowball.gathered) {
			snowball.followPath();
		}

		// - pause screen
		if (FlxG.keys.justPressed.ESCAPE) {
			final pauseMenu = new PauseMenu();
			openSubState(pauseMenu);
		}

		FlxG.collide(player, leftBound);

		// player caughts
		// if (player.isCaught == true) {
		// 	show
		// 	game
		// 	over
		// 	screen
		// }
	}
}