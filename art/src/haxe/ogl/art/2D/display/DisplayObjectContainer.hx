package src.haxe.ogl.art.2D.display;

/**
 * ...
 * @author pierre
 */

class DisplayObjectContainer extends DisplayObject
{
	
	public var numChildren:Int=0;
	private var children:Array<DisplayObject>;
	
	public function new() 
	{
		children = new Array<DisplayObject>();
	}
	
	public function addChild(d:DisplayObject):Void
	{
		removeChild(d);
		children.push(d);
		numChildren++;
		d.parent = this;
	}
	
	public function removeChild(d:DisplayObject):Void
	{
		if (children.remove(d)) numChildren--;
		d.parent = null;
	}
	
	override private function onAdded(stage:Bool = false):Dynamic 
	{
		super.onAdded(stage);
		for (c in children)
		{
			c.onAdded(stage);
		}
	}
	
	override private function onRemoved(stage:Bool = true):Dynamic 
	{
		super.onRemoved(stage);
		for (c in children)
		{
			c.onRemoved(stage);
		}
	}
}