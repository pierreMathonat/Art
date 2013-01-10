package haxe.ogl.art.m2d.core;
import haxe.ogl.art.core.IndexStream;
import haxe.ogl.art.core.Material;
import haxe.ogl.art.core.VertexFormat;
import haxe.ogl.art.core.VertexStream;
import haxe.ogl.art.m2d.geom.M44;
import hxsl.Shader;
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
		var _alpha:Float;
		
		function vertex()
		{
			out = pos.xyzw * cam;
			_uv = uv;
			_color = color.xyz;
			_alpha = color.w;
		}
		
		function fragment(tex:Texture)
		{
			out = tex.get(_uv) * _color.xyzw * _alpha;
		}
	}
}
 
 
class QuadBatch extends Material
{
	
	public var vstream:VertexStream;
	public var istream:IndexStream;
	public var mshader:QuadShader;
	
	public function new() 
	{
		super(mshader = new QuadShader());
		vstream = new VertexStream( new VertexFormat([VertexComponent.XYZ, VertexComponent.UV, VertexComponent.COLOR]));
	}
	
	public inline function push(b:Bitmap)
	{
		//push verts in vstream , indexes in istream
		//if statechanged draw();
	}
	
	inline function draw():Void
	{
		
	}
}