package src.haxe.ogl.art.m2d.scene;
import haxe.ogl.art.core.Material;
import haxe.ogl.art.m2d.geom.M44;
import nme.events.Event;
import nme.geom.Matrix3D;
import nme.events.EventDispatcher;
import nme.geom.Vector3D;
/**
 * ...
 * @author pierre
 */

class DisplayObject extends EventDispatcher
{

	public var type:String = "2D.display.DisplayObject";
	override public function toString():String { return type; }
	
	var position	:Vector3D;
	var scale		:Vector3D;
	var rotation	:Vector3D;
	var pchanged:Bool = false;
	var schanged:Bool = false;
	var rchanged:Bool = false;
	
	public var x			(get_x, set_x)					:Float;
	public var y			(get_y, set_y)					:Float;
	public var z			(get_z, set_z)					:Float;
	public var scaleX		(get_scaleX, set_scaleX)		:Float;
	public var scaleY		(get_scaleY, set_scaleY)		:Float;
	public var scaleZ		(get_scaleZ, set_scaleZ)		:Float;
	public var rotationX	(get_rotationX, set_rotationX)	:Float;
	public var rotationZ	(get_rotationZ, set_rotationZ)	:Float;
	public var rotationY	(get_rotationY, set_rotationY)	:Float;
	
	inline function get_x			():Float { return position.x; 	}
	inline function get_y			():Float { return position.y; 	}
	inline function get_z			():Float { return position.z; 	}
	inline function get_scaleX		():Float { return scale.x; 		}
	inline function get_scaleY		():Float { return scale.y; 		}
	inline function get_scaleZ		():Float { return scale.z; 		}
	inline function get_rotationX	():Float { return rotation.x; 	}
	inline function get_rotationY	():Float { return rotation.y; 	}
	inline function get_rotationZ	():Float { return rotation.z; 	}
	
	inline function set_x			(v:Float):Float { pchanged = true; return position.x 	= v; }
	inline function set_y			(v:Float):Float { pchanged = true; return position.y 	= v; }
	inline function set_z			(v:Float):Float { pchanged = true; return position.z 	= v; }
	inline function set_scaleX		(v:Float):Float { schanged = true; return scale.x 		= v; }
	inline function set_scaleY		(v:Float):Float { schanged = true; return scale.y 		= v; }
	inline function set_scaleZ		(v:Float):Float { schanged = true; return scale.z 		= v; }
	inline function set_rotationX	(v:Float):Float { rchanged = true; return rotation.x 	= v; }
	inline function set_rotationY	(v:Float):Float { rchanged = true; return rotation.y 	= v; }
	inline function set_rotationZ	(v:Float):Float { rchanged = true; return rotation.z 	= v; }
	
	//--------transform
	
	var _m:M44;
	var _ltw:M44;
	var _wtl:M44;
	var matrix(get_matrix, set_matrix):M44;
	var localToWorld(get_localToWorld,null):M44;
	var worldToLocal(get_worldToLocal,null):M44;
	
	function get_matrix():M44
	{
		if (pchanged || schanged || rchanged)
		{
			return updateTransform();
		}else 
		{
			return _m;	
		}
	}
	
	function set_matrix(m:M44):M44
	{
		return _m=m;
	}
	
	function updateTransform():M44
	{
		_m.recompose(position, scale, rotation);
		pchanged = schanged = rchanged = false;
		return _m;
	}

	
	function get_localToWorld():M44
	{
		_ltw.loadFrom(matrix);
		if (parent != null) 
		{
			_ltw.add(parent.localToWorld);
		}
		return _ltw;
	}
	
	inline function get_worldToLocal():M44
	{
		_wtl.loadFrom(localToWorld);
		_wtl.invert();
		return _wtl;
	}
	
	//-------Stage
	
	public var stage(get_stage, null):Stage;
		
	function get_stage():Stage
	{
		if (parent != null)
		{
			return parent.stage;
		}
		return null;
	}
	
	//-------Parent
	
	public var parent(get_parent, set_parent):DisplayObjectContainer;
	
	inline function get_parent():DisplayObjectContainer
	{
		return parent;
	}
	
	function set_parent(v:DisplayObjectContainer):DisplayObjectContainer
	{
		if (parent == v) 
		{
			return parent; 
		}
		else
		{
			if (parent != null)
			{
				parent.removeChild(v);
			}
			
			if (parent == null && v != null)
			{
				parent = v;
				onAdded(stage!=null);
			}
			else if (parent != null && v == null)
			{
				parent = v;
				onRemoved(stage!=null);
			}
			else
			{
				parent = v;
			}
			return parent;
		}
		
	}
	
	function onAdded(stage:Bool = false)
	{
		dispatchEvent(new Event(Event.ADDED));
		if (stage)
		{
			dispatchEvent(new Event(Event.ADDED_TO_STAGE));
		}
	}
	
	function onRemoved(stage:Bool = true)
	{
		dispatchEvent(new Event(Event.REMOVED));
		if (stage)
		{
			dispatchEvent(new Event(Event.REMOVED_FROM_STAGE));
		}
	}
	
	//------------------------------------------------------------------------
	// blend
	
	public var blendMode:BlendMode;
	
	//----------------------------------------------------------------------
	// contructor
	//----------------------------------------------------------------------
	
	public function new(t:String="") 
	{
		
		type = t;
		
		position 		= new Vector3D(0,0,0);
		scale 			= new Vector3D(1,1,1);
		rotation 		= new Vector3D(0,0,0);		
		
		_ltw			= new M44();
		_wtl			= new M44();
		_m 				= new M44();
		
		blendMode = BlendMode.NORMAL;
		
		super();
	}
	
	//-----------------------------------------------------------------------
	// render
	//------------------------------------------------------------------------
	
	public function render():Void
	{
		throw(type + " ::render(); must be overriden in subClass");
	}
	
}