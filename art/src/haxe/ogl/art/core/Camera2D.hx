package haxe.ogl.art.core;

/**
 * ...
 * @author pierre
 */

class Camera2D extends M44
{

	public var width:Float;
	public var height:Float;
	
	
	public function new() 
	{
		super();
	}
	
	public inline function resize(w:Float, h:Float)
	{
		width = w;
		height = h;
		
		identity();
		translate(-w*.5,-h*.5);
		scale(2/w,-2/h);
	}
	
}