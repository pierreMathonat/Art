package haxe.ogl.art.m2d.atlas;
import nme.display.BitmapData;
import nme.utils.ByteArray;

/**
 * ...
 * @author pierre
 */

class AtlasNode 
{
	public var x:Int;
	public var y:Int;
	public var w:Int;
	public var h:Int;
	
	public var empty:Bool = true;
	public var bmd:BitmapData;
	public var atlas:AtlasTexture;
	
	public var u0:Float;
	public var v0:Float;
	public var u1:Float;
	public var v1:Float;
	
	public function new(x,y,w,h, atlas:AtlasTexture)
	{
		this.x = x;
		this.y = y;
		this.w = w;
		this.h = h;
		this.atlas = atlas;
	}
	
	public inline function canContain(w, h):Bool
	{
		return (empty) && (this.w >= w) && (this.h >= h);
	}
	
	public inline function fill(bmd:BitmapData)
	{
		this.bmd = bmd;
		empty = false;
		
		w = bmd.width;
		h = bmd.height;
		
		var size = 1/AtlasTexture.SIZE;
		u0 = x * size;
		v0 = y * size;
		u1 = (x + w) * size;
		v1 = (y + h) * size;
		
		trace(u0 + ";" + u1 + ";" + v0 + ";" + v1);
	}
	
	public inline function clear()
	{
		bmd.dispose();
		empty = true;
	}
	
	public function toString():String
	{
		return "ATLASNODE:: " + x + ";" + y + ";" + w + ";" + h + ";" + bmd;
	}
}