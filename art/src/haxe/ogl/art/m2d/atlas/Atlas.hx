package haxe.ogl.art.m2d.atlas;
import haxe.ogl.art.core.Tex2D;
import nme.Assets;

/**
 * ...
 * @author pierre
 */

class Atlas 
{
	
	public static var atlases:Array<AtlasTexture> = new Array<AtlasTexture>();

	
	public static inline function getBitmapData(path:String):AtlasNode
	{
		var result:AtlasNode = _findBitmapData(path);
		
		if (result != null) 
		{
			return result; 
		}
		else 
		{
			return _insertBitmapData(path);
		}		
	}
	
	static function _findBitmapData(path:String):AtlasNode
	{
		for (atlas in atlases)
		{
			if (atlas.contains(path)) return atlas.getNode(path);
		}
		return null;
	}
	
	static function _insertBitmapData(path:String):AtlasNode
	{
		var bmd = Assets.getBitmapData(path, false);
		var node:AtlasNode;
		
		for (atlas in atlases)
		{
			node = atlas.insertNode(path, bmd);
			if (node!=null) return node;
		}
		
		var newAtlas = new AtlasTexture();
		node = newAtlas.insertNode(path, bmd);
		
		if (node!=null)
		{
			atlases.push(newAtlas);
			return node;
		}
		else
		{
			throw("YOUR ASSET IS TOO BIG AND CANNOT BE PLACED IN A TEXTUREATLAS");
		}
	}
}