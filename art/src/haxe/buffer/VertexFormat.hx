package haxe.ogl.art.core.buffer;
import nme.display3D.Context3DVertexBufferFormat;

/**
 * ...
 * @author pierre
 */

 
 enum C3DSTREAM_USAGE
 {
	READ;
	WRITE;
	STATIC;
	DYNAMIC;
 }
 
 enum C3DSTREAM_FORMAT
 {
	FLOAT_1;
	FLOAT_2;
	FLOAT_3;
	FLOAT_4;
 }
 
 class C3DSTREAM_COMP
 {
	
	public static var XYZ:C3DSTREAM_COMP = new C3DSTREAM_COMP(["x", "y", "z"], C3DSTREAM_FORMAT.FLOAT_3);
	
	public var a:Array<String>;
	public var f:C3DSTREAM_FORMAT;
	public function new(attributes:Array<String>, format:C3DSTREAM_FORMAT)
	{
		a = attributes;
		f = format;
	}
 }
 
 class C3DSTREAM_VERTEXFORMAT
 {
	public var stride(get_stride, null):Int;
	
	public var c:Array<C3DSTREAM_COMP>;
	public var a:Array<String>;
	
	public function new(components:Array<C3DSTREAM_COMP>, usage:C3DSTREAM_USAGE)
	{
		c = new Array<C3DSTREAM_COMP>();
		a = new Array<String>();
	}
	
	inline function get_stride():Int
	{
		return a.length;
	}
	
	public function add(_c:C3DSTREAM_COMP):Void
	{
		c.push(_c);
		
		for (_a in _c.a)
		{
			a.push(_a);
		}
	}
	
	public function remove(_c:C3DSTREAM_COMP):Void
	{
		if (c.remove(_c))
		{
			for (_a in _c.a)
			{
				a.remove(_a);
			}
		}
	}
	
	public function attributeOffset(_a:String):Int
	{
		return a.indexOf(_a);
	}
	
	public function componentOffset(_c:C3DSTREAM_COMP):Int
	{
		return c.indexOf(_c);
	}
 }