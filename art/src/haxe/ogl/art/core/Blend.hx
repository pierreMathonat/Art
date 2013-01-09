package haxe.ogl.art.core;
import nme.display3D.Context3DBlendFactor;

/**
 * ...
 * @author pierre
 */

class Blend
{
	public static var NORMAL	:Blend = new Blend(SOURCE_ALPHA, ONE_MINUS_SOURCE_ALPHA);
	public static var ADD		:Blend = new Blend(SOURCE_ALPHA, ONE_MINUS_DESTINATION_ALPHA);
	public static var NONE		:Blend = new Blend(ONE, ZERO);
	public static var MULTIPLY	:Blend = new Blend(DESTINATION_COLOR, ONE_MINUS_SOURCE_ALPHA);
	public static var ERASE		:Blend = new Blend(ZERO, ONE_MINUS_SOURCE_ALPHA);
	public static var HIDE		:Blend = new Blend(ZERO, ONE);
	
	public var src:Context3DBlendFactor;
	public var dst:Context3DBlendFactor;
	
	public function new(s:Context3DBlendFactor,d:Context3DBlendFactor)
	{
		src = s;
		dst = d;
	}
}