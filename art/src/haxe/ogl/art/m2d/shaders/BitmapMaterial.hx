package haxe.ogl.art.m2d.shaders;
import haxe.ogl.art.core.Camera2D;
import haxe.ogl.art.core.Material;
import haxe.ogl.art.core.Tex2D;
import haxe.ogl.art.core.VertexStream;
import haxe.ogl.art.core.View;
import haxe.ogl.art.m2d.geom.M44;
import hxsl.Shader;
import nme.display3D.Context3DCompareMode;
import nme.geom.Vector3D;

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
		var _color:Float3;
		
		function vertex(cam:M44,mpos:M44,size:Float3)
		{
			var p:Float4;
			p.xyz = pos * size;
			p.w = color.z;
			out = ((mpos != null)?p.xyzw * mpos:p.xyzw) * cam;
			
			_uv = uv;
			_color = color.xyz*color.w;
		}
		
		function fragment(tex:Texture)
		{
		out = (useTex)?tex.get(_uv) * _color.xyzw:_color.xyzw;
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
			mshader.size = new Vector3D(t.width, t.height);
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