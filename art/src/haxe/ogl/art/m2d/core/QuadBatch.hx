package haxe.ogl.art.m2d.core;
import haxe.ogl.art.core.Blend;
import haxe.ogl.art.core.IndexStream;
import haxe.ogl.art.core.Material;
import haxe.ogl.art.core.Tex2D;
import haxe.ogl.art.core.VertexFormat;
import haxe.ogl.art.core.VertexStream;
import haxe.ogl.art.core.M44;
import haxe.ogl.art.core.View;
import haxe.ogl.art.m2d.atlas.AtlasNode;
import haxe.ogl.art.m2d.geom.ColorTransform;
import hxsl.Shader;
import nme.display3D.Context3DCompareMode;
import src.haxe.ogl.art.core.Renderer;
import src.haxe.ogl.art.m2d.scene.Bitmap;

/**
 * ...
 * @author pierre
 */
class QuadShader extends Shader
{
	static var SRC =
	{
		var input: {
			pos:Float3,
			uv:Float2,
			color:Float4
		};
		
		var cam:M44;
		
		var _uv:Float2;
		var _color:Float3;
		
		function vertex()
		{
			out = pos.xyzw * cam;
			_uv = uv;
			_color = color.xyz*color.z;
		}
		
		function fragment(tex:Texture)
		{
			out = tex.get(_uv, mm_linear) * _color.xyzw;
		}
	}
}
 
 
class QuadBatch extends Material
{
	public var renderer:Renderer;
	
	public var vstream:VertexStream;
	public var istream:IndexStream;
	public var mshader:QuadShader;
	
	var numQuads:Int;
	var curTexture:Tex2D;
	
	public function new() 
	{
		renderer = View._I.renderer;
		
		super(mshader = new QuadShader());
		
		
		vstream = new VertexStream( new VertexFormat([VertexComponent.XYZ, VertexComponent.UV, VertexComponent.COLOR]));
		istream = new IndexStream();
		
		//depth = Context3DCompareMode.LESS_EQUAL;
	}
	
	public inline function renderQuad(blendMode:Blend, instream:VertexStream, texture:AtlasNode, ?matrix:M44, ?color:ColorTransform)
	{
		setState(blendMode, texture.atlas.tex);
		
		var id = numQuads * 4;
		
		var hw = texture.w * .5;
		var hh = texture.h * .5;
		
		vstream.concat(instream);
/*		vstream.pushArray([
			-hw, -hh, 0, texture.u0, texture.v0, 1, 1, 1, 1,
			-hw,  hh, 0, texture.u0, texture.v1, 1, 1, 1, 1,
			 hw,  hh, 0, texture.u1, texture.v1, 1, 1, 1, 1,
			 hw, -hh, 0, texture.u1, texture.v0, 1, 1, 1, 1,
		]);*/
		
		istream.pushArray([
			id + 1, id + 2, id + 3,
			id + 3, id , id + 1,
		]);
		
		numQuads++;
		
		if(matrix!=null)vstream.transform(matrix, 0, id, 4);
		if(color!=null)vstream.colorTransform(color.raw, 5, id, 4);
		
		//vstream.colorTransform(b.colorTransform, 5, 0, 4);
	}
	
	inline function setState(blend:Blend, texture:Tex2D)
	{
		var changed:Bool = false;
		if (blend != this.blend)
		{
			this.blend = blend;
			changed = true;
		}
		if (texture != curTexture)
		{
			curTexture = texture;
			changed = true;
		}
		
		if (changed) draw();
	}
	
	inline public function draw():Void
	{
		if (numQuads > 0)
		{
			mshader.cam = View._I.cam2D;
			mshader.tex = curTexture.native;
			renderer.setMaterial(this);
			
			vstream.unlock();
			istream.unlock();

			renderer.setBuffer(vstream);
			renderer.draw(istream,0,numQuads*2);
			
			vstream.lock();
			istream.lock();
			vstream.clear();
			istream.clear();
			numQuads = 0;
		}
	}
}