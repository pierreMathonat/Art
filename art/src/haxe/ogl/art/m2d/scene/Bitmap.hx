package src.haxe.ogl.art.m2d.scene;
import haxe.ogl.art.core.IndexStream;
import haxe.ogl.art.core.Material;
import haxe.ogl.art.core.Tex2D;
import haxe.ogl.art.core.VertexFormat;
import haxe.ogl.art.core.VertexStream;
import haxe.ogl.art.core.View;
import haxe.ogl.art.m2d.atlas.AtlasNode;
import haxe.ogl.art.m2d.core.QuadBatch;
import haxe.ogl.art.core.M44;
import haxe.ogl.art.m2d.shaders.BitmapMaterial;
import nme.display.BitmapData;
import nme.display3D.Context3DCompareMode;
import nme.Lib;

/**
 * ...
 * @author pierre
 */

class Bitmap extends DisplayObject
{
	public static var batch:QuadBatch;
	
	public var vstream:VertexStream; 
	public var bitmapData(get_bmd, set_bmd):AtlasNode;
	
	
	inline function get_bmd():AtlasNode
	{
		return bitmapData;
	}
	
	inline function set_bmd(b:AtlasNode):AtlasNode
	{
		var w = b.w * .5;
		var h = b.h * .5;
		
		vstream.set2(0, 0, -w, -h);
		vstream.set2(1, 0, -w,  h);
		vstream.set2(2, 0,  w,  h);
		vstream.set2(3, 0,  w, -h);
		
		vstream.set2(0, 3, b.u0, b.v0);
		vstream.set2(1, 3, b.u0, b.v1);
		vstream.set2(2, 3, b.u1, b.v1);
		vstream.set2(3, 3, b.u1, b.v0);
		
		return bitmapData = b;
	}
	
	static var arr:Array<Float>;
	
	public function new(bmd:AtlasNode)
	{
		super("2D.display.Bitmap");
		if (batch == null) batch = new QuadBatch();
		
		vstream = new VertexStream(VertexFormat.DEFAULT);
		vstream.fromArray([ -.5, -.5, 0, 0, 0, 1, 1, 1, 1,
							-.5,  .5, 0, 0, 0, 1, 1, 1, 1,
							 .5,  .5, 0, 0, 0, 1, 1, 1, 1,
							 .5, -.5, 0, 0, 0, 1, 1, 1, 1,
						]);
						
		bitmapData = bmd;
	}
	
	override inline public function render():Void
	{	
		batch.renderQuad(blendMode.blend, vstream, bitmapData, localToWorld, localToWorldColor);
	}
}