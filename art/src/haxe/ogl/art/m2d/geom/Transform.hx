package haxe.ogl.art.m2d.geom;

/**
 * ...
 * @author pierre
 */

class Transform 
{
	public var matrix:M44;
	public var colorTransform:ColorTransform;
	
	public function new() 
	{
		matrix = new M44();
		colorTransform = new ColorTransform();
	}
}