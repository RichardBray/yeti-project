package utils;

import flixel.FlxSprite;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.graphics.frames.FlxFramesCollection;

final class Helpers {
	/**
	 * Frame names used for sprite atlas animation
	 * @param noOfFrames frames used in animation
	 * @param imgPrefix frame image name as stated in data file
	 * @return Array<String>
	 */
	public static function frameNames(noOfFrames: Int,
			imgPrefix: String): Array<String> {
		var frameNames: Array<String> = [];

		for (frameNo in 1...(noOfFrames + 1)) {
			final addLeadingZero = (frameNo < 10) ? ('0$frameNo') : '$frameNo';
			frameNames.push('${imgPrefix}${addLeadingZero}.png');
		}

		return frameNames;
	}

	// @formatter:off
	/**
	 * Method to change the site of a sprite's hitbox size.
	 *
	 * @param width Amount to want to reduce or increase the hitbox WIDTH by
	 * @param height Amount to want to reduce or increase the hitbox HEIGHT by
	 * @param sprite sprite instance
	 * @param customOffset Self explanitory [width, height]
	 */
	public static function changeHitbox(
		width: Int,
		height: Int,
		sprite: FlxSprite,
		?heightOffset: Int,
		?widthOffset: Int
	) {
		final newHitboxWidth: Int = Std.int(sprite.width - width);
		final newHitboxHeight: Int = Std.int(sprite.height - height);

		var offsetWidth: Float = width / 2;
		var offsetHeight: Float = height;

		if (widthOffset != null)
			offsetWidth = widthOffset;

		if (heightOffset != null)
			offsetHeight = heightOffset;

		sprite.setGraphicSize(newHitboxWidth, newHitboxHeight);
		sprite.updateHitbox();
		sprite.offset.set(offsetWidth, offsetHeight);
		sprite.scale.set(1, 1);
	}

	/**
	 * Load textpure packer frames for FlxSprite.
	 *
	 * @param path where frames are located, exclude extention and assets/images/
	 */
	public static function loadFrames(path: String): FlxFramesCollection {
		return FlxAtlasFrames.fromTexturePackerJson(
			'assets/images/$path.png',
			'assets/images/$path.json'
		);
	}
}