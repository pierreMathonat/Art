package haxe.ogl.art.m2d.atlas;
import nme.display.Bitmap;
import nme.display.BitmapData;
import nme.geom.Point;
import nme.geom.Rectangle;
import haxe.ogl.art.core.Tex2D;
import nme.Lib;
import nme.utils.ByteArray;

/**
 * ...
 * @author pierre
 */

class AtlasTexture 
{
	inline public static var SIZE:Int = 2048;
	
	var nodeCache:Array<AtlasNode>;
	public var nodes:Hash<AtlasNode>;
	
	public var bmd:BitmapData;
	
	var changed:Bool = true;
	var _tex:Tex2D;
	public var tex(get_tex,null):Tex2D;
	
	var tmpRect:Rectangle;
	
	public function new() 
	{
		tmpRect = new Rectangle();
		nodes = new Hash<AtlasNode>();
		nodeCache = new Array<AtlasNode>();
		_tex = new Tex2D();
		nodeCache.push(new AtlasNode(0, 0, SIZE, SIZE,this));
	}
	
	inline function pushNode(key:String, bmd:BitmapData):AtlasNode
	{
		var w = bmd.width;
		var h = bmd.height;
		var bestNode:AtlasNode=null;
		
		for (node in nodeCache)
		{	
			//TODO add a cost value to determine which node is best for the asset
			if (node.canContain(w, h))
			{
				bestNode = node;
			}
		}
		
		if (bestNode != null)
		{
			splitNode(bestNode, key, bmd, w, h);
			
			return bestNode;
		}
		else
		{
			return null;
		}
	}
	
	inline static var AXIS_X:Int = -1;
	inline static var AXIS_Y:Int = 1;
	
	function splitNode(Node:AtlasNode, key:String, bmd:BitmapData, w:Int, h:Int ):Void
	{	

		

		
		var x:Int = Node.x + w;
		var y:Int = Node.y + h;
		var xmargin:Int = Node.w - w;
		var ymargin:Int = Node.h - h;
		
		if (xmargin <= 1 && ymargin <= 1) return;
		
		var axis:Int; //-1 for x, 1 for y
		
		if (w > h)
		{
			if (xmargin < ymargin)
			{
				axis = AXIS_X;
			}else {
				axis = AXIS_Y;
			}
		}
		else
		{
			if (xmargin < ymargin)
			{
				axis = AXIS_Y;
			}else {
				axis = AXIS_X;
			}
		}
		//split on x or y;
		
		switch(axis)
		{
			case AXIS_X:
					nodeCache.push(new AtlasNode(x, Node.y, xmargin, h + ymargin, this));
					nodeCache.push(new AtlasNode(Node.x, y, w, ymargin, this));
			case AXIS_Y:
					nodeCache.push(new AtlasNode(x, Node.y, xmargin, ymargin, this));
					nodeCache.push(new AtlasNode(Node.x, y, w + xmargin, ymargin, this));
		}
		
		Node.fill(bmd);
		changed = true;
		nodes.set(key, Node);
	}
	
	public function insertNode(key:String,bmd:BitmapData):AtlasNode
	{		
		if (contains(key))
		{
			return getNode(key);
		}
		else
		{
			return pushNode(key, bmd);
		}
	}
	
	public function contains(key:String):Bool
	{
		return nodes.exists(key);
	}
	
	public function getNode(key:String):AtlasNode
	{
		return nodes.get(key);
	}
	
	
	inline function get_tex():Tex2D
	{
		if (changed) upload();
		return _tex;
	}
	inline function upload():Void
	{
		
		bmd = new BitmapData(SIZE, SIZE, true, 0);
		var p = new Point();
		
		for (n in nodes)
		{
			p.x = n.x;
			p.y = n.y;
			bmd.copyPixels(n.bmd, n.bmd.rect, p);
		}
		
		
		
		trace("uploading atlas");
		_tex.bitmapData(bmd,true);
		
		//Lib.current.stage.addChild(new Bitmap(bmd));
		bmd.dispose();
		bmd = null;
		
		changed = false;
	}
}