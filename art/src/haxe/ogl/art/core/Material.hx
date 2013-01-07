package haxe.ogl.art.core;
import format.hxsl.Shader;
import nme.display3D.Context3DCompareMode;
import nme.display3D.Context3DTriangleFace;
import nme.display3D.Context3D;
import nme.display3D.Context3DBlendFactor;
import nme.display3D.Context3DVertexBufferFormat;
import nme.Vector;

/**
 * ...
 * @author pierre
 */

class Blend
{
	public static var NORMAL	:Blend = new Blend(SOURCE_ALPHA, ONE_MINUS_SOURCE_ALPHA);
	public static var ADD		:Blend = new Blend(SOURCE_ALPHA, ONE_MINUS_DESTINATION_ALPHA);
	
	public var src:Context3DBlendFactor;
	public var dst:Context3DBlendFactor;
	
	public function new(s:Context3DBlendFactor,d:Context3DBlendFactor)
	{
		src = s;
		dst = d;
	}
}

class Material 
{
	
	var ctx:Context3D;
	
	public var shader:DefaultShader;
	
	public var useDepth:Bool = true;
	public var blend:Blend;
	public var depth:Context3DCompareMode;
	public var culling:Context3DTriangleFace;
	
	public function new(?s:DefaultShader)
	{
		ctx = View._I.ctx;
		
		blend = Blend.NORMAL;
		depth = Context3DCompareMode.ALWAYS;
		culling = Context3DTriangleFace.NONE;
		
		shader = (s == null)?new DefaultShader(ctx):s;
	}
	
	public function prepareContext():Void
	{
		ctx.setBlendFactors(blend.src, blend.dst);
		ctx.setCulling(culling);
		ctx.setDepthTest(useDepth,depth);
	}
	
	public function bind(stream:VertexStream, vertexConst:Dynamic, fragmentConst:Dynamic)
	{	
		
		prepareContext();
		shader.init( vertexConst, fragmentConst);
		shader.bind(stream.buffer);
		
		// toReplace with stream.bind();
/*		ctx.setVertexBufferAt(0, stream.buffer, 0, Context3DVertexBufferFormat.FLOAT_3);
		ctx.setVertexBufferAt(1, stream.buffer, 3, Context3DVertexBufferFormat.FLOAT_2);*/
	}
}