package characters.parents;

import flixel.FlxSprite;

/**
 * Parent for character that needs senses
 */
abstract class SenseChar extends FlxSprite {
	/**
	 * Tells SenseGrp.hx to show or hide senses
	 */
	public var showSenses = false;

	public var isAlert = false;

	/**
	 * Character looks otherway if hearing bound overlap
	 */
	public function lookBehind() {}
}