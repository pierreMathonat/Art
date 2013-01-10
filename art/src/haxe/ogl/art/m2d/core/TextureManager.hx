package haxe.ogl.art.m2d.core;
import haxe.ogl.art.core.Tex2D;
import nme.display.BitmapData;

/**
 * ...
 * @author pierre
 */
 
class TextureManager 
{

	public static var Textures:Hash<Tex2D> = new Hash<Tex2D>();
	
	public static function has(key:String):Bool
	{
		return Textures.exists(key);
	}
	
	public static function get(bmd:BitmapData):Tex2D
	{
		var key = bmd.
		if (has(key)) {
			return Textures.get(key);
		}else {
			
		}
	}
	
}