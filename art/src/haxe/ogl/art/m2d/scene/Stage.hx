package src.haxe.ogl.art.m2d.scene;
import haxe.ogl.art.core.Camera2D;
import haxe.ogl.art.core.View;

/**
 * ...
 * @author pierre
 */

class Stage extends DisplayObjectContainer
{
	public var cam:Camera2D;
	public function new() 
	{
		stage = this;
		cam = View._I.cam2D;
		super("2D.display.Stage");
	}
	
	override public function render():Void 
	{
		for (i in children)
		{
			i.render();
		}
	}
}