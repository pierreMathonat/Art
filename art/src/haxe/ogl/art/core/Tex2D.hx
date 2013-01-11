package haxe.ogl.art.core;
import nme.display.BitmapData;
import nme.display3D.Context3D;
import nme.display3D.Context3DTextureFormat;
import nme.display3D.textures.Texture;
import nme.geom.Matrix;

/**
 * ...
 * @author pierre
 */

class Tex2D 
{
	var ctx:Context3D;
	
	public var width(default, null):Int;
	public var height(default,null):Int;
	public var native(default, null):Texture;

	public function new(?bmd:BitmapData)
	{
		ctx = View._I.ctx;
		if (bmd != null) bitmapData(bmd,true);
	}
	
	inline public function bitmapData(bmd:BitmapData, createMip:Bool=false):Void
	{
		width = bmd.width;
		height = bmd.height;
		
		alloc();
		
		if (createMip) {
			createMipmaps(bmd);
		}else {
			upload(bmd);
		}
	}
	
	inline public function alloc():Void
	{
		if (native != null) dispose();
		native = ctx.createTexture(width,height, Context3DTextureFormat.BGRA, false);
	}
	
	inline public function createMipmaps(bmd:BitmapData):Void
	{
		var w = bmd.width;
		var h = bmd.height;
		var mip = 0;
		var m:Matrix = new Matrix();
		while (w > 0 && h > 0)
		{
			var tmp:BitmapData = new BitmapData(w, h, true, 0);
			tmp.draw(bmd, m, null, null, null, true);
			upload(tmp, mip);
			
			m.scale(.5, .5);
			mip++;
			w >>= 1;
			h >>= 1;
		}
	}
	
	inline public function upload(bmd:BitmapData, mip:Int = 0):Void
	{
		native.uploadFromBitmapData(bmd, mip);
	}
	
	inline public function dispose():Void
	{
		native.dispose();
		native = null;
	}
}