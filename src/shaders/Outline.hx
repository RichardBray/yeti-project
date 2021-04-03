package shaders;

import flixel.system.FlxAssets.FlxShader;

class Outline extends FlxShader {
	@:glFragmentSource('
    #pragma header

    uniform vec2 size;

    void main() {
      vec4 color = texture2D(bitmap, openfl_TextureCoordv);
      float w = size.x / openfl_TextureSize.x;
      float h = size.y / openfl_TextureSize.y;

      if (color.a == 0.) {
        if (texture2D(bitmap, vec2(openfl_TextureCoordv.x + w, openfl_TextureCoordv.y)).a != 0.
        || texture2D(bitmap, vec2(openfl_TextureCoordv.x - w, openfl_TextureCoordv.y)).a != 0.
        || texture2D(bitmap, vec2(openfl_TextureCoordv.x, openfl_TextureCoordv.y + h)).a != 0.
        || texture2D(bitmap, vec2(openfl_TextureCoordv.x, openfl_TextureCoordv.y - h)).a != 0.) {
          gl_FragColor = vec4(0.262, 0.156, 0.4, 0.8);
        } else {
          gl_FragColor = color;
        }
      } else {
        gl_FragColor = color;
      }
    }')
	public function new() {
		super();
		this.size.value = [1, 1];
	}
}