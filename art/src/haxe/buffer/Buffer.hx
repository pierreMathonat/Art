package haxe.ogl.art.core.buffer;
import browser.geom.Vector3D;
import nme.Vector;

/**
 * ...
 * @author pierre
 */

class Buffer 
{
	public var stride:Int;
	
	public var raw:Vector<Float>;
	
	public function new(s:Int) 
	{
		stride = s;
		raw = new Vector<Float>();
	}
}