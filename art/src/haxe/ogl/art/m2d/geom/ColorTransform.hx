package haxe.ogl.art.m2d.geom;
import haxe.ogl.art.core.Vec3;

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
	
	public var raw(get_raw,null):Vec3;
	inline function get_raw():Vec3
	{
		var i = 1 / 255;
		raw.set(redOffset * i + redMultiplier, greenOffset * i + greenMultiplier, blueOffset * i + blueMultiplier, alphaOffset + alphaMultiplier);
		return raw;
	}
	
	public function new(rm:Float=1,gm:Float=1,bm:Float=1,am:Float=1,ro:Float=0,go:Float=0,bo:Float=0,ao:Float=0 )
	{
		redMultiplier = rm;
		greenMultiplier = gm;
		blueMultiplier = bm;
		alphaMultiplier = am;
		redOffset = ro;
		greenOffset = go;
		blueOffset = bo;
		alphaOffset = ao;
		
		raw = new Vec3();
	}

	public inline function loadFrom(ct:ColorTransform):Void
	{
		redOffset = ct.redOffset;
		greenOffset = ct.greenOffset;
		blueOffset = ct.blueOffset;
		alphaOffset = ct.alphaOffset;
		redMultiplier = ct.redMultiplier;
		greenMultiplier = ct.greenMultiplier;
		blueMultiplier = ct.blueMultiplier;
		alphaMultiplier = ct.alphaMultiplier;
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