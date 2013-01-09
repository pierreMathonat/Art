package haxe.ogl.art.m2d.shaders;
import haxe.ogl.art.core.Camera2D;
import haxe.ogl.art.core.Material;
import haxe.ogl.art.core.Tex2D;
import haxe.ogl.art.core.VertexStream;
import haxe.ogl.art.core.View;
import haxe.ogl.art.m2d.geom.M44;
import hxsl.Shader;

/**
 * ...
 * @author pierre
 */
class BitmapShader extends Shader
{	
	static var SRC =
	{
		var input: {
			pos:Float3,
			uv:Float2,
			color:Float4,
		}
		
		var useTex:Bool;
		
		var _uv:Float2;
		var _alpha:Float;
		var _color:Float3;
		
		function vertex(cam:M44,mpos:M44)
		{
			var _pos:Float4 = (mpos != null)?pos.xyzw * mpos:pos.xyzw;
			out = _pos * cam;
			
			_uv = uv;
			_color = color.xyz;
			_alpha = color.w;
		}
		
		function fragment(tex:Texture)
		{
			var f:Float4 = _color.xyzw * _alpha;
			out = (useTex)?tex.get(_uv) * f:f;
		}
	}
}
class BitmapMaterial extends Material
{

	var mshader:BitmapShader;
	public var texture(null,setTexture):Tex2D;
	public var view(null,setView):Camera2D;
	public var mpos(null,setMpos):M44;
	
	inline function setTexture(t:Tex2D):Tex2D
	{
		if (t != null)
		{
			mshader.useTex = true;
			mshader.tex = t.native;
		}else {
			mshader.useTex = false;
		}
		
		return t;
	}
	
	inline function setView(v:Camera2D):Camera2D
	{
		mshader.cam = v;
		return v;
	}
	
	inline function setMpos(m:M44):M44
	{
		mshader.mpos = m.m3d;
		return m;
	}
	
	public function new() 
	{
		super(mshader = new BitmapShader());
		view = View._I.cam2D;
	}
}