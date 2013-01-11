package haxe.ogl.art.core;
import nme.display3D.Context3DBlendFactor;

/**
 * ...
 * @author pierre
 */

class Blend
{
	public static var NORMAL	:Blend = new Blend(Context3DBlendFactor.SOURCE_ALPHA, 		Context3DBlendFactor.ONE_MINUS_SOURCE_ALPHA);
	public static var ADD		:Blend = new Blend(Context3DBlendFactor.SOURCE_ALPHA, 		Context3DBlendFactor.DESTINATION_ALPHA);
	public static var NONE		:Blend = new Blend(Context3DBlendFactor.ONE, 				Context3DBlendFactor.ZERO);
	public static var MULTIPLY	:Blend = new Blend(Context3DBlendFactor.DESTINATION_COLOR, 	Context3DBlendFactor.ONE_MINUS_SOURCE_ALPHA);
	public static var ERASE		:Blend = new Blend(Context3DBlendFactor.ZERO, 				Context3DBlendFactor.ONE_MINUS_SOURCE_ALPHA);
	public static var SCREEN	:Blend = new Blend(Context3DBlendFactor.SOURCE_ALPHA, 		Context3DBlendFactor.ONE);
	
	public var src:Context3DBlendFactor;
	public var dst:Context3DBlendFactor;
	
	public function new(s:Context3DBlendFactor,d:Context3DBlendFactor)
	{
		src = s;
		dst = d;
	}
}