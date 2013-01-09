package src.haxe.ogl.art.m2d.scene;
import haxe.ogl.art.core.Blend;

/**
 * ...
 * @author pierre
 */

class BlendMode 
{
	
	public static var NORMAL	:BlendMode = new BlendMode(Blend.NORMAL		);
	public static var NONE		:BlendMode = new BlendMode(Blend.NONE		);
	public static var ADD		:BlendMode = new BlendMode(Blend.ADD		);
	public static var MULTIPLY	:BlendMode = new BlendMode(Blend.MULTIPLY	);
	public static var ERASE		:BlendMode = new BlendMode(Blend.ERASE		);
	public static var HIDE		:BlendMode = new BlendMode(Blend.HIDE		);
	
	public var blend:Blend;
	
	public function new(b:Blend) 
	{
		blend = b;
	}
	
}