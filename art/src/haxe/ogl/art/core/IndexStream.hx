package haxe.ogl.art.core;
import nme.display3D.Context3D;
import nme.display3D.IndexBuffer3D;
import nme.Vector;
import nme.Vector;

/**
 * ...
 * @author pierre
 */

class IndexStream 
{
	var ctx:Context3D;
	
	public var numInt(default,set_numInt):Int;
	public var numTriangles(default, null):Int;
	public var raw(default, set_raw):Vector<UInt>;
	
	public var buffer(get_buffer, null):IndexBuffer3D;
	
	public var locked:Bool = false;
	public var sizechanged:Bool = false;
	public var datachanged:Bool = false;
	
	public function new()
	{
		ctx = View._I.ctx;
		
		numInt = 0;
		numTriangles = 0;
		raw = new Vector<UInt>();
	}
	
	public inline function fromArray(inArray:Array<Int>):Void
	{
		var l = inArray.length;
		
		if (l != numInt) numInt = l; 
		
		lock();
		
		for (i in 0...numInt)
		{
			raw[i] = inArray[i];
		}
		
		unlock();
	}
	
	var oldSize:Int = 0;
	public inline function lock():Void
	{
		oldSize = numInt;
		locked = true;
	}
	
	public inline function unlock():Void
	{
		locked = false; 
		datachanged = true;
		if (numInt != oldSize) sizechanged = true;
	}
	
	inline function set_numInt(v:Int):Int
	{
		if (v != numInt)
		{
			numInt = v;
			numTriangles = Std.int(numInt / 3);
			sizechanged = true;
		}
		
		return numInt;
	}
	
	inline function set_raw(v:Vector<UInt>):Vector<UInt>
	{
		if (!locked) datachanged = true;
		return raw = v;
	}

	function get_buffer():IndexBuffer3D
	{
		if (buffer == null)
		{
			sizechanged = true;
		}
		
		if (sizechanged)
		{
			if (buffer != null) buffer.dispose();
			buffer = ctx.createIndexBuffer(numInt);
			datachanged = true;
		}
		if (datachanged)
		{
			buffer.uploadFromVector(raw, 0, numInt);
		}
		
		return buffer;
	}
	
	public function toString():String
	{
		return "ISTREAM"+raw;
	}
	
}