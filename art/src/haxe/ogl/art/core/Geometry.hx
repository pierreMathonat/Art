package haxe.ogl.art.core;

/**
 * ...
 * @author pierre
 */

class Geometry 
{	
	
	public var vstream:VertexStream;
	public var istream:IndexStream;
	
	public function new() 
	{
		vstream = new VertexStream();
		istream = new IndexStream();
	}
}