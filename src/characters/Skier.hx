package characters;

import characters.parents.SenseChar;

import flixel.math.FlxPoint;
import flixel.util.FlxPath;

import utils.Colors;

enum SkierStates {
	Approaching;
	StartingSki;
	Skiing;
	Resetting;
	Alert;
}

final class Skier extends SenseChar {
	static inline final APPROACH_SPEED = -250;
	static inline final SKIING_SPEED = 680;
	static inline final RESET_TIME = 0.2;
	static inline final ALERT_TIME = 4; // seconds

	var alertSeconds: Float = 0;

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
	var startingPos: FlxPoint;

	public var state(default, null):SkierStates = Approaching;

	/**
	 * Point where skier starts going downhill.
	 * Set in SkiLevel.hx
	 */
	public var reachedSkiStart = false;

	// @formatter:on
	public function new(x: Float = 0, y: Float = 0) {
		super(x, y);
		startingPos = new FlxPoint(1921, 486);
		makeGraphic(50, 70, Colors.GREY_DARK);
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
				if (isAlert) state = Alert;
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
			case Alert:
				velocity.x = 0;
				alertSeconds += elapsed;
				if (alertSeconds >=ALERT_TIME) {
					isAlert = false;
					state = Approaching;
				}
		}
	}

	// @formatter:on
	override public function update(elapsed: Float) {
		super.update(elapsed);

		stateMachine(elapsed);

		if (state == Approaching || state == Alert) {
			showSenses = true;
		} else {
			showSenses = false;
		}
	}
}