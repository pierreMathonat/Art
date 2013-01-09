package src.haxe.ogl.art.m2d.scene;

/**
 * ...
 * @author pierre
 */

class Sprite extends DisplayObjectContainer
{

	public function new() 
	{
		super("2D.display.Sprite");
	}
	
	override public function render():Void 
	{
		for (i in children)
		{
			i.render();
		}
	}
}