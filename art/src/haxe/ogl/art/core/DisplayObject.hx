package haxe.ogl.art.core;
import nme.geom.Matrix3D;

/**
 * ...
 * @author pierre
 */

class DisplayObject 
{
	public var localToWorld:Matrix3D;
	public var worldToLocal:Matrix3D;
	
	//if hardwareTransform = vertexShader : pos*mview*localToWorld
	//if CPUTransform = stream.transform(meshOffset, numVertices, localToWorld);
	
	// SpriteMaterial (use constant camera + localToWorld in shader);
	// SpriteBatchMaterial(use 4 float3Registers to rebuild m3D in VertexShader)
	// 
	
	public var x:Float;
	public var y:Float;
	public var z:Float;
	public var scaleX:Float;
	public var scaleY:Float;
	public var scaleZ:Float;
	public var rotationX:Float;
	public var rotationY:Float;
	public var rotationZ:Float;
	
	public var alpha:Float;
	public var r:Float;
	public var g:Float;
	public var b:Float;
	
	public var visible:Bool;
	
	public var vstream:VertexStream;
	public var istream:IndexStream;
	
	public var voffset:Int;
	public var ioffset:Int;
	
	public var numVerts:Int;
	public var numTris:Int;
	
	public function new() 
	{
		
	}
	
}