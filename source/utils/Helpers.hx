package utils;

final class Helpers {
	/**
	 * Frame names used for sprite atlas animation
	 * @param noOfFrames frames used in animation
	 * @param imgPrefix frame image name as stated in data file
	 * @return Array<String>
	 */
	public static function frameNames(noOfFrames:Int,
			imgPrefix:String):Array<String> {
		var frameNames:Array<String> = [];

		for (frameNo in 1...(noOfFrames + 1)) {
			final addLeadingZero = (frameNo < 10) ? ('0$frameNo') : '$frameNo';
			frameNames.push('${imgPrefix}${addLeadingZero}.png');
		}

		return frameNames;
	}
}