package haxe.ogl.art.2D.geom;

/**
 * ...
 * @author pierre
 */

class Transform 
{
	public var matrix:Matrix3D;
	public var colorTransform:ColorTransform;
	
	public function new() 
	{
		matrix = new Matrix3D();
		colorTransform = new ColorTransform();
	}
	
}