package characters.parents;

import flixel.FlxSprite;

/**
 * Parent for character that needs senses
 */
abstract class SenseChar extends FlxSprite {
	/**
	 * Tells SenseGrp.hx to show or hide senses
	 */
	public var showSenses(default, null) = false;

	public var alert(default, null) = false;
	public var isCaught = false;

	/**
	 * Character looks otherway if hearing bound overlap
	 */
	public function lookBehind() {}

	/**
	 * Toggle alert for outside clases
	 */
	public function isAlert() {
		alert = true;
	}
}