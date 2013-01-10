package src.haxe.ogl.art.core;
import haxe.ogl.art.core.Blend;
import haxe.ogl.art.core.IndexStream;
import haxe.ogl.art.core.Material;
import haxe.ogl.art.core.VertexFormat;
import haxe.ogl.art.core.VertexStream;
import haxe.ogl.art.core.View;
import hxsl.Shader;
import nme.display3D.Context3DBlendFactor;
import nme.display3D.Context3DCompareMode;
import nme.display3D.Context3DTriangleFace;
import nme.display3D.Context3D;
import nme.display3D.Context3DProgramType;
import nme.display3D.textures.TextureBase;
import nme.utils.Endian;

/**
 * ...
 * @author pierre
 */

class Renderer 
{
	var ctx:Context3D;

	var currentMaterial:Material;
	var currentShader:ShaderInstance;
	var currentBuffer:VertexStream;
	var curTextures:Array<TextureBase>;
	var curAttributes:Int;
	var curBlend:Blend;
	var curCulling:Context3DTriangleFace;
	var curDepthTest:Context3DCompareMode;
	var curDepthWrite:Bool;
	
	inline public static var MAX_TRIS:Int = 524287;
	inline public static var MAX_QUAD:Int = Std.int(MAX_VERT / 4);
	inline public static var MAX_VERT:Int = 65535;
	
	public function new(c:Context3D) 
	{
		ctx = c;
		curAttributes = 0;
		curTextures = new Array<TextureBase>();
	}
	
	// material	
	public inline function setMaterial(m:Material):Void
	{
		if (m.blend != curBlend) 
		{
			ctx.setBlendFactors(m.blend.src, m.blend.dst);
			curBlend = m.blend;
		}
		if (m.depth != curDepthTest || m.useDepth != curDepthWrite ) 
		{
			ctx.setDepthTest(m.useDepth, m.depth);
			curDepthTest = m.depth;
			curDepthWrite = m.useDepth;
		}
		if (m.culling != curCulling) 
		{
			ctx.setCulling(m.culling);
			curCulling = m.culling;
		}
		
		selectShader(m.shader);
		currentMaterial = m;
	}
	
	inline function selectShader(shader:Shader):Void
	{
		var s:ShaderInstance = shader.getInstance();
		
		if (s.program == null)
		{
			s.program = ctx.createProgram();
			s.program.upload(s.vertexBytes.getData(),s.fragmentBytes.getData());
		}
		if (s != currentShader)
		{
			ctx.setProgram(s.program);
			s.varsChanged = true;
			var tcount:Int = s.textures.length;
			while (curTextures.length > tcount)
			{
				curTextures.pop();
				ctx.setTextureAt(curTextures.length, null);
			}
			currentBuffer = null;
			currentShader = s;
		}
		if (s.varsChanged)
		{
			s.varsChanged = false;
			ctx.setProgramConstantsFromVector(Context3DProgramType.VERTEX, 0, s.vertexVars);
			ctx.setProgramConstantsFromVector(Context3DProgramType.FRAGMENT, 0, s.fragmentVars);
			
			for (i in 0...s.textures.length)
			{
				var t = s.textures[i];
				if (t == null)
				{
					throw("Texture #" + i + " not bound in shader " + shader);
				}
				if (t != curTextures[i])
				{
					ctx.setTextureAt(i, t);
					curTextures[i] = t;
				}
			}
		}
	}
	
	//buffer	
	public inline function setBuffer(v:VertexStream):Void
	{
		if (v == currentBuffer)
		{
			return;
		}
		else
		{			
			if (v.data32PerVertex < currentShader.stride)
			{
				throw ("Buffer Stride (" + v.data32PerVertex +") and shader stride (" + currentShader.stride +") do not match");
			}
			
			var pos = 0, offset = 0;
			var format:VertexFormat = v.format;
			
			while (offset < currentShader.stride)
			{
				var c:VertexComponent = format.components[pos];
				ctx.setVertexBufferAt(pos++, v.buffer, offset, c.C3DFORMAT);
				offset += c.stride;
			}
			
			for ( i in pos...curAttributes)
			{
				ctx.setVertexBufferAt(i, null);
			}
			curAttributes = pos;

			currentBuffer = v;
		}
	}
	
	public inline function draw(triangles:IndexStream,start:Int=0,numTris:Int=-1):Void
	{
		ctx.drawTriangles(triangles.buffer, start, numTris);
	}
}