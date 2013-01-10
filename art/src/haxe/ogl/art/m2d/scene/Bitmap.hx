package src.haxe.ogl.art.m2d.scene;
import haxe.ogl.art.core.IndexStream;
import haxe.ogl.art.core.Material;
import haxe.ogl.art.core.Tex2D;
import haxe.ogl.art.core.VertexFormat;
import haxe.ogl.art.core.VertexStream;
import haxe.ogl.art.core.View;
import haxe.ogl.art.m2d.core.QuadBatch;
import haxe.ogl.art.m2d.geom.M44;
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
	public var vstream:VertexStream;
	public static var istream:IndexStream;
	
	public static var batch:QuadBatch;
	
	public var mat:BitmapMaterial;
	
	var tex:Tex2D;
	
	public function new(bmd:Tex2D)
	{
		super("2D.display.Bitmap");
		
		mat = new BitmapMaterial();
		if (batch == null) batch = new QuadBatch();
		 
		if (vstream == null)
		{
			vstream = new VertexStream( VertexFormat.DEFAULT );		
			vstream.fromArray([
				-.5, -.5, 0, 0, 0, 1, 1, 1, 1,
				-.5, 0.5, 0, 0, 1, 1, 1, 1, 1,
				0.5, 0.5, 0, 1, 1, 1, 1, 1, 1,
				0.5, -.5, 0, 1, 0, 1, 1, 1, 1,
			]);
		}
		
		if (istream == null)
		{
			istream = new IndexStream();
			istream.fromArray([
				1, 2, 3,
				3, 0, 1
			]);
		}
		
		tex = bmd;
	}
	
	override inline public function render():Void
	{
		//QuadBatch.add(localToWorld,blendMode,tex);
		vstream.fromArray([
				-50, -50, 0, 0, 0, 1, 1, 1, 1,
				-50, 050, 0, 0, 1, 1, 1, 1, 1,
				050, 050, 0, 1, 1, 1, 1, 1, 1,
				050, -50, 0, 1, 0, 1, 1, 1, 1,
			]);
			
		vstream.transform(localToWorld , 0);
		//trace(localToWorld);
		//trace(vstream);
		
		mat.mpos = localToWorld;
		mat.blend = blendMode.blend;
		mat.texture = tex;

		var r = View._I.renderer;
		r.setMaterial (mat);
		r.setBuffer (vstream);
		r.draw(istream);
	}
}