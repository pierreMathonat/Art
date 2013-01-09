package src.haxe.ogl.art.m2d.scene;
import haxe.ogl.art.core.IndexStream;
import haxe.ogl.art.core.Material;
import haxe.ogl.art.core.Tex2D;
import haxe.ogl.art.core.VertexFormat;
import haxe.ogl.art.core.VertexStream;
import haxe.ogl.art.core.View;
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
	public var verts:Array<Float>;
	public var istream:IndexStream;
		
	var mat:BitmapMaterial;
	var tex:Tex2D;
	
	public function new(bmd:BitmapData)
	{
		super("2D.display.Bitmap");
		
		vstream = new VertexStream( VertexFormat.DEFAULT );
		
		verts = [
			-120.5, -120.5, 0, 0, 0, 1, 1, 1, 1,
			-120.5, 120.5, 0, 0, 1, 1, 1, 1, 1,
			120.5, 120.5, 0, 1, 1, 1, 1, 1, 1,
			120.5, -120.5, 0, 1, 0, 1, 1, 1, 1,
		];
		
		vstream.fromArray(verts);
		
		istream = new IndexStream();
		istream.fromArray([
			1, 2, 3,
			3, 0, 1
		]);
		
		//use a MemoryManager
		tex = new Tex2D(bmd);
		mat = new BitmapMaterial();
	}
	
	override public function render():Void
	{
		mat.mpos = localToWorld;
		mat.blend = blendMode.blend;
		mat.texture = tex;
		
		var r = View._I.renderer;
		r.setMaterial (mat);
		r.setBuffer (vstream);
		r.draw(istream,0,2);
		//r.drawQuads(vstream,2);
	}
}