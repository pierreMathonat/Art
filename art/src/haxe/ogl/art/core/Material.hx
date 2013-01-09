package haxe.ogl.art.core;
import hxsl.Shader;
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



class Material 
{
	
	var ctx:Context3D;
	
	public var shader:Shader;
	
	public var useDepth:Bool = true;
	public var blend:Blend;
	public var depth:Context3DCompareMode;
	public var culling:Context3DTriangleFace;
	
	public function new(?s:Shader)
	{
		ctx = View._I.ctx;
		
		blend = Blend.NORMAL;
		depth = Context3DCompareMode.ALWAYS;
		culling = Context3DTriangleFace.NONE;
		
		shader = (s == null)?new DefaultShader():s;
	}
	
	public function prepareContext():Void
	{
		ctx.setBlendFactors(blend.src, blend.dst);
		ctx.setCulling(culling);
		ctx.setDepthTest(useDepth,depth);
	}
	
	public function bind():Void
	{	
		
		//prepareContext();
		//shader.bind(ctx, stream.buffer);

	}
	
	public function render(stream:IndexStream, start:Int=0,num:Int=-1):Void
	{
		ctx.drawTriangles(stream.buffer, start, num);
	}
	
}