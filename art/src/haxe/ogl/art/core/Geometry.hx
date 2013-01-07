package haxe.ogl.art.core;

/**
 * ...
 * @author pierre
 */

class Geometry 
{

	public var mat:Material;
	
	public var usePosition:Bool;
	public var useUv:Bool;
	public var useNormal:Bool;
	
	public var vstream:VertexStream;
	public var istream:IndexStream;
	public var voff:Int;
	public var ioff:Int;
	
	public var numv:Int;
	public var numt:Int;
	
	public function new() 
	{
		
	}
}