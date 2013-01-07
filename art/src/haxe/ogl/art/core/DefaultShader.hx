package haxe.ogl.art.core;
import format.hxsl.Shader;
import nme.display3D.Program3D;

/**
 * ...
 * @author pierre
 */

class DefaultShader extends Shader
{
	
	
	
	//public var program(get_program,null):Program3D;
	//inline function get_program():Program3D { return p; }
	
	/*	init
	 * 	-ctx.setProgram
	 * 	-ctx.setConstantsFromVector
	 *  -ctx.setTextureAt
	 * 
	 *  -ctx.setVertexBufferAt
	 */
	
	 
	static var SRC =
	{
		var input:
		{
			pos:Float3,
			uv:Float2,
			color:Float4,
		}
		
		var uvt:Float2;
		var colort:Float3;
		var alphat:Float;
		
		function vertex(mview:M44)
		{
			out = pos.xyzw * mview;
			uvt = uv;
			colort = color.xyz;
			alphat = color.w;
		}
		function fragment(tex:Texture)
		{
			var f = tex.get(uvt) * colort.xyzw * alphat;
			out = f;
		}
	}
	
}