package levels;

import states.LevelState;

final class SkiLevel extends LevelState {
	override public function create() {
		super.create();
		createPlayer(990, 337);
	}
}