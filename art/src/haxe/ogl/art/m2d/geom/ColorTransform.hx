package haxe.ogl.art.m2d.geom;

/**
 * ...
 * @author pierre
 */

class ColorTransform 
{

	public var redOffset:Float=0;
	public var greenOffset:Float=0;
	public var blueOffset:Float=0;
	public var alphaOffset:Float=0;
	
	public var redMultiplier:Float=1;
	public var greenMultiplier:Float=1;
	public var blueMultiplier:Float=1;
	public var alphaMultiplier:Float=1;
	
	public function new()
	{
	}

	public inline function identity():Void
	{
		redOffset = greenOffset = blueOffset = alphaOffset = 0;
		redMultiplier = greenMultiplier = blueMultiplier = alphaMultiplier = 1;
	}
	
	public inline function append(ct:ColorTransform):Void
	{
		redMultiplier *= ct.redMultiplier;
		greenMultiplier *= ct.greenMultiplier;
		blueMultiplier *= ct.blueMultiplier;
		alphaMultiplier *= ct.alphaMultiplier;
		
		redOffset += ct.redOffset;
		greenOffset += ct.greenOffset;
		blueOffset += ct.blueOffset;
		alphaOffset += ct.alphaOffset;
	}
}