package characters;

import flixel.FlxSprite;
import flixel.math.FlxPoint;
import flixel.util.FlxPath;

import utils.Colors;

enum SkierStates {
	Approaching;
	StartingSki;
	Skiing;
	Resetting;
}

final class Skier extends FlxSprite {
	static inline final APPROACH_SPEED = -250;
	static inline final SKIING_SPEED = 500;
	static inline final RESET_TIME = 2;

	// @formatter:off
	final movementPathCoords = [
		{x: 843, y: 515},
		{x: 589, y: 581},
		{x: 467, y: 638},
		{x: 461, y: 677},
		{x: 507, y: 702},
		{x: 589, y: 714},
		{x: 930, y: 743},
		{x: 1243, y: 793},
		{x: 1412, y: 864},
		{x: 1432, y: 914},
		{x: 1334, y: 946},
		{x: 1033, y: 971},
		{x: 729, y: 1011},
		{x: 449, y: 1080},
		{x: 160, y: 1190},
	];
	var finishCycleSeconds: Float = 0;
	var state:SkierStates = Approaching;
	var startingPos: FlxPoint;

	/**
	 * Point where skier starts going downhill.
	 * Set in SkiLevel.hx
	 */
	public var reachedSkiStart = false;

	// @formatter:on
	public function new(x: Float = 0, y: Float = 0) {
		super(x, y);
		startingPos = new FlxPoint(x, y);
		makeGraphic(50, 100, Colors.GREY_DARK);
		// - create path
		final flxPointCoords = movementPathCoords.map(
			coords -> new FlxPoint(coords.x, coords.y)
		);
		path = new FlxPath(flxPointCoords);
	}

	// @formatter:off
	function stateMachine(elapsed: Float) {
		switch (state) {
			case Approaching:
				velocity.x = APPROACH_SPEED;
				if (reachedSkiStart) state = StartingSki;
			case StartingSki:
				path.start(null, SKIING_SPEED);
				state = Skiing;
			case Skiing:
				path.onComplete = (_) -> {
					alpha = 0;
					state = Resetting;
				}
			case Resetting:
				finishCycleSeconds += elapsed;

				if (finishCycleSeconds >= RESET_TIME) {
					setPosition(startingPos.x, startingPos.y);
					alpha = 1;
					finishCycleSeconds = 0;
					state = Approaching;
				}
		}
	}

	// @formatter:on
	override public function update(elapsed: Float) {
		super.update(elapsed);

		stateMachine(elapsed);
	}
}