package characters;

import flixel.FlxSprite;
import flixel.math.FlxPoint;
import flixel.util.FlxPath;

import utils.Colors;

final class Skier extends FlxSprite {
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
		{x: 240, y: 1090},
	];
	var completedCycle = false;
	var finishCycleSeconds: Float = 0;

	// @formatter:on
	public function new(x: Float = 0, y: Float = 0) {
		super(x, y);
		makeGraphic(50, 100, Colors.GREY_DARK);
		createPath();
	}

	function createPath() {
		final flxPointCoords = movementPathCoords.map(
			coords -> new FlxPoint(coords.x, coords.y)
		);
		path = new FlxPath(flxPointCoords);
	}

	public function followPath(elapsed: Float) {
		path.start(null, 500, FlxPath.LOOP_FORWARD);
		path.onComplete = (_) -> {
			alpha = 0;
			completedCycle = true;
			finishCycleSeconds += elapsed;
		}
	}

	public function restartPath() {
		alpha = 1;
		completedCycle = false;
		finishCycleSeconds = 0;
	}
}