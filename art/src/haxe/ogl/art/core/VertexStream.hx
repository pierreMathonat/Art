package haxe.ogl.art.core;
import format.tools.BufferInput;
import native.display3D.Context3DVertexBufferFormat;
import nme.display3D.Context3D;
import nme.display3D.VertexBuffer3D;
import nme.Vector;

/**
 * ...
 * @author pierre
 */

class VertexStream 
{
	static var FORMATS = [
		Context3DVertexBufferFormat.BYTES_4,
		Context3DVertexBufferFormat.FLOAT_1,
		Context3DVertexBufferFormat.FLOAT_2,
		Context3DVertexBufferFormat.FLOAT_3,
		Context3DVertexBufferFormat.FLOAT_4,
	];
	
	public var ctx:Context3D;
	
	public var data32PerVertex(default, set_data32):Int;
	public var numFloats(default, set_numFloats):Int;
	
	public var numVertices(default, null):Int;
	public var raw(default, set_raw):Vector<Float>;
	
	public var buffer(get_buffer, null):VertexBuffer3D;
	
	public var sizeAtLock:Int;
	public var locked:Bool = false;
	public var datachanged:Bool = false;
	public var sizechanged:Bool = false;
	
	public function new(perVertex:Int)
	{
		ctx = View._I.ctx;
		
		data32PerVertex = perVertex;
		numVertices = 0;
		numFloats = 0;
		raw = new Vector<Float>();
	}
	
	public inline function lock():Void
	{
		locked = true;
	}
	
	public inline function unlock():Void
	{
		locked = false;
		datachanged = true;
	}
	
	inline function set_data32(v:Int):Int
	{
		if (v != data32PerVertex) {
			sizechanged = true;
			data32PerVertex = v;
			numVertices = Std.int(numFloats / data32PerVertex);			
		}
		
		return data32PerVertex;
	}
	
	inline function set_numFloats(v:Int):Int
	{
		if (v != numFloats) {
			sizechanged = true;
			numFloats = v;
			numVertices = Std.int(numFloats / data32PerVertex);
		}

		return numFloats;
	}
	
	inline function set_raw(v:Vector<Float>):Vector<Float>
	{
		if(!locked)datachanged = true;
		return raw = v;
	}
	
	function get_buffer():VertexBuffer3D
	{
		if (buffer == null) {
			
			sizechanged = true;
		
		}
			
		if (sizechanged)
		{
			if (buffer != null) buffer.dispose();
			buffer = ctx.createVertexBuffer(numVertices, data32PerVertex);
			datachanged = true;
		}
			
		if (datachanged)
		{
			buffer.uploadFromVector(raw, 0, numVertices);
		}
		
		return buffer;
	}
	
	
	//--------------------------------------------------------------------------
	
	
	public inline function fromArray(inArray:Array<Float>):Void
	{
		var l = inArray.length;
		
		if (l != numFloats) {
			numFloats = l;
		}
		
		lock();
		
		for (i in 0...numFloats)
		{
			raw[i] = inArray[i];
		}
		
		unlock();
	}
	

}