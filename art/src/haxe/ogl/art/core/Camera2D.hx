package haxe.ogl.art.core;
import nme.geom.Matrix3D;

/**
 * ...
 * @author pierre
 */

class Camera2D extends Matrix3D
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
		appendTranslation(-w/2,-h/2,0);
		appendScale(2/w,-2/h,1);
	}
	
}