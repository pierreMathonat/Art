package haxe.ogl.art.core;
import format.tools.BufferInput;
import haxe.ogl.art.m2d.geom.ColorTransform;
import haxe.ogl.art.core.M44;
import native.display3D.Context3DVertexBufferFormat;
import nme.display3D.Context3D;
import nme.display3D.VertexBuffer3D;
import nme.Vector;
import haxe.ogl.art.core.VertexFormat;

/**
 * ...
 * @author pierre
 */

class VertexStream 
{

	
	public var ctx:Context3D;
	
	public var format										:VertexFormat;
	public var data32PerVertex	(default, set_data32)		:Int;
	public var numFloats		(default, set_numFloats)	:Int;
	public var numVertices		(default, null)				:Int;
	public var raw				(default, set_raw)			:Vector<Float>;
	public var buffer			(get_buffer, null)			:VertexBuffer3D;
	
	public var sizeAtLock		:Int;
	public var locked			:Bool = false;
	public var datachanged		:Bool = false;
	public var sizechanged		:Bool = false;
	
	public function new(f:VertexFormat)
	{
		ctx = View._I.ctx;
		
		format 				= f;
		data32PerVertex 	= format.stride;
		numVertices 		= 0;
		numFloats 			= 0;
		raw 				= new Vector<Float>();
	}
	
	var oldSize:Int = 0;
	public inline function lock():Void
	{
		oldSize = numFloats;
		locked = true;
	}
	
	public inline function unlock():Void
	{
		locked = false;
		if(oldSize!=numFloats)datachanged = true;
	}
	
	inline function set_data32(v:Int):Int
	{
		if (v != data32PerVertex) {
			if(!locked)sizechanged = true;
			data32PerVertex = v;
			numVertices = Std.int(numFloats / data32PerVertex);			
		}
		
		return data32PerVertex;
	}
	
	inline function set_numFloats(v:Int):Int
	{
		if (v != numFloats) {
			if(!locked)sizechanged = true;
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
			trace("new buffer created");
			if (buffer != null) buffer.dispose();
			buffer = ctx.createVertexBuffer(numVertices, data32PerVertex);
			sizechanged = false;
			datachanged = true;
		}
		
		if (datachanged)
		{
			buffer.uploadFromVector(raw, 0, numVertices);
			datachanged = false;
		}
		
		return buffer;
	}
	
	
	//--------------------------------------------------------------------------
	
	public inline function clear():Void
	{
		numFloats = 0;
	}
	
	public inline function fill(numVerts:Int):Void
	{
		numFloats = numVerts * data32PerVertex;
		for (i in 0...numFloats)
		{
			raw[i] = 0;
		}
	}
	
	public inline function concat(vstream:VertexStream):Void
	{		
		var p = numFloats;
		numFloats += vstream.numFloats;
		
		for (i in 0...vstream.numFloats)
		{
			raw[p++] = vstream.raw[i];
		}
	}
	
	public inline function setFloats(id:Int, inArray:Array<Float>):Void
	{
		id *= data32PerVertex;
		
		var j = 0;
		for (i in id...id + inArray.length)
		{
			raw[i] = inArray[j++];
		}
	}
	
	public inline function fromArray(inArray:Array<Float>):Void
	{
		var l = inArray.length;
		
		if (l != numFloats) {
			numFloats = l;
		}
				
		for (i in 0...numFloats)
		{
			raw[i] = inArray[i];
		}
	}
	
	public inline function pushArray(inArray:Array<Float>):Void
	{
		var l = inArray.length;
		
		var s = numFloats;
		numFloats += inArray.length;
				
		for (i in 0...l)
		{
			raw[s++] = inArray[i];
		}
	}
	
	public inline function set(id:Int, off:Int, value:Float):Void
	{
		datachanged = true;
		raw[id * data32PerVertex + off] = value;
	}
	
	public inline function set2(id:Int, off:Int, v1:Float, v2:Float):Void
	{
		var o = id * data32PerVertex + off;
		
		raw[o 	 ] = v1;
		raw[o + 1] = v2;
		
		datachanged = true;
	}
	
	public inline function set3(id:Int, off:Int, v1:Float, v2:Float, v3:Float):Void
	{
		var o = id * data32PerVertex + off;
		
		raw[o 	 ] = v1;
		raw[o + 1] = v2;
		raw[o + 2] = v3;
		
		datachanged = true;
	}
	
	public inline function set4(id:Int, off:Int, v1:Float, v2:Float, v3:Float, v4:Float):Void
	{
		var o = id * data32PerVertex + off;
		
		raw[o 	 ] = v1;
		raw[o + 1] = v2;
		raw[o + 2] = v3;
		raw[o + 3] = v4;
		
		datachanged = true;
	}
	
	public inline function get(id:Int, off:Int):Float
	{
		return raw[id * data32PerVertex + off];
	}
	
	
	public static var TMP_NUMBERS:Vector<Float> = new Vector<Float>();
	
	public inline function transform(m:M44, offset:Int=0, startid:Int=0, num:Int=-1):Void
	{	
		
		if (num < 0) num = numVertices - startid;
		TMP_NUMBERS.length = num * 3;
		
		
		var tmp = 0;
		var start = startid;
		for (i in 0...num)
		{
			var o = start++ * data32PerVertex + offset;
			TMP_NUMBERS[tmp++] = raw[o	  ];
			TMP_NUMBERS[tmp++] = raw[o + 1];
			TMP_NUMBERS[tmp++] = raw[o + 2];
		}
		
		m.transformRawData(TMP_NUMBERS, TMP_NUMBERS);
		
		tmp = 0;
		start = startid;
		for (i in 0...num)
		{
			set3(start++,offset, TMP_NUMBERS[tmp++], TMP_NUMBERS[tmp++], TMP_NUMBERS[tmp++]);
		}
		
	}
	
	public inline function colorTransform(ct:Vec3, offset:Int=0, startid:Int = 0, num:Int = -1):Void
	{		
		if (num < 0) num = numVertices - startid;
		
		for (i in 0...num)
		{
			set4(startid++, offset, ct.x, ct.y, ct.z, ct.w);
		}
	}
	
	
	public function iterator():VertexIterator
	{
		return new VertexIterator(this);
	}
	public inline function toString():String
	{
		return "VSTREAM::"+raw;
	}
}

class VertexIterator
{
	public var v:Vertex;
	public var pos:Int = 0;
	public var numV:Int;
	
	public function new(stream:VertexStream)
	{
		numV = stream.numVertices;
		v = new Vertex(stream);
	}
	
	public inline function hasNext():Bool
	{
		return pos < numV;
	}
	
	public inline function next():Vertex
	{
		v.id = pos++;
		return v;
	}
}

class Vertex
{
	public var id:Int = 0;
	public var stream:VertexStream;
	public var format:VertexFormat;
	public function new(s:VertexStream, i:Int=0)
	{
		id = i;
		stream = s;
		format = s.format;
	}
	
	public function toString():String
	{
		var v:String = "VERT::" + id +"{ ";
		
		for (i in 0...format.stride)
		{
			v+=stream.get(id, i) + " ; ";
		}
		
		return v + " }";
	}
	
	public inline function set1(off:Int, value:Float)
	{
		stream.set(id, off, value);
	}
	
	public inline function set2(off:Int, v1:Float, v2:Float)
	{
		stream.set2(id, off, v1, v2);
	}
	
	public inline function set3(off:Int, v1:Float, v2:Float, v3:Float)
	{
		stream.set3(id, off, v1, v2, v3);
	}
	
	public inline function set4(off:Int, v1:Float, v2:Float, v3:Float, v4:Float)
	{
		stream.set4(id, off, v1, v2, v3, v4);
	}
	
	public inline function get1(off:Int):Float
	{
		return stream.get(id, off);
	}
	
	public inline function setPosition(x:Float, y:Float, z:Float):Void
	{
		var o = format.offsetByUsage(USAGE.position);
		if (o >= 0)
		{
			
			stream.set3(id, o, x, y, z);
		}
	}
	
	public inline function setUv(u:Float, v:Float):Void
	{
		var o = format.offsetByUsage(USAGE.uv);
		if (o >= 0)
		{
			stream.set2(id, o, u, v);
		}
	}
	
	public inline function setColor(r:Float, g:Float, b:Float, a:Float):Void
	{
		var o = format.offsetByUsage(USAGE.color);
		if (o >= 0)
		{
			stream.set4(id, o, r, g, b, a);
		}
	}
}