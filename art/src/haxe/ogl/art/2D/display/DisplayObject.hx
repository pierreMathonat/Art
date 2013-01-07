package src.haxe.ogl.art.2D.display;
import haxe.ogl.art.core.Material;
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

	public function toString():String { return "2D.display.DisplayObject"; }
	
	var position	:Vector3D;
	var scale		:Vector3D;
	var rotation	:Vector3D;
	var pchanged:Bool = false;
	var schanged:Bool = false;
	var rchanged:Bool = false;
	
	public var x			(get_x,set_x)			:Float;
	public var y			(get_y,set_y)			:Float;
	public var z			(get_z,set_z)			:Float;
	public var scaleX		(get_scaleX,set_scaleX)	:Float;
	public var scaleY		(get_scaleY,set_scaleY)	:Float;
	public var scaleZ		(get_scaleZ,set_scaleZ)	:Float;
	public var rotationX	(get_rotX,set_rotX)		:Float;
	public var rotationZ	(get_rotY,set_rotY)		:Float;
	public var rotationY	(get_rotZ, set_rotZ)	:Float;
	
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
	
	var matrix(get_matrix, set_matrix):Matrix3D;
	var localToWorld(get_localToWorld,null):Matrix3D;
	var worldToLocal(get_worldToLocal,null):Matrix3D;
	
	inline function get_matrix():Matrix3D
	{
		if (pchanged || schanged || rchanged)
		{
			updateTransform();
		}else 
		{
			return matrix;	
		}
	}
	
	inline function updateTransform()
	{
		localToWorld.identity();
		localToWorld.appendTranslation(x, y, z);
		localToWorld.appendScale(scaleX, scaleY, scaleZ);
		
		//localToWorld.recompose(position, scale, rotation);
		
		pchanged = schanged = rchanged = false;
	}
	
	inline function set_matrix(m:Matrix3D):Matrix3D
	{
		//localToWorld.decompose(position, scale, rotation);
		
		return m;
	}
	
	inline function get_localToWorld():Matrix3D
	{
		localToWorld.copyFrom(matrix);
		if (parent != null) 
		{
			localToWorld.append(parent.localToWorld);
		}
		return localToWorld;
	}
	
	inline function get_worldToLocal():Matrix3D
	{
		return localToWorld.invert();
	}
	
	//-------Stage
	
	public var stage(get_stage, null):Stage
		
	inline function get_stage():Stage
	{
		if (parent != null)
		{
			return parent.stage;
		}
	}
	
	//-------Parent
	
	public var parent(get_parent, set_parent):DisplayObjectContainer;
	
	inline function get_parent():DisplayObjectContainer
	{
		return parent;
	}
	
	inline function set_parent(v:DisplayObjectContainer):DisplayObjectContainer
	{
		if (parent == v) 
		{
			return parent; 
		}
		else
		{
			if (parent != null)
			{
				parent.removeChild(d);
			}
			
			if (parent == null && v != null)
			{
				parent = v;
				onAdded();
			}
			else if (parent != null && v == null)
			{
				parent = v;
				onRemoved();
			}
			else
			{
				parent = v;
			}
			return parent;
		}
		
	}
	
	inline function onAdded(stage:Bool = false)
	{
		dispatchEvent(new Event(Event.ADDED));
		if (stage)
		{
			dispatchEvent(new Event(Event.ADDED_TO_STAGE));
		}
	}
	
	inline function onRemoved(stage:Bool = true)
	{
		dispatchEvent(new Event(Event.REMOVED));
		if (stage)
		{
			dispatchEvent(new Event(Event.REMOVED_FROM_STAGE));
		}
	}
	
	//----------------------------------------------------------------------
	// contructor
	//----------------------------------------------------------------------
	
	public function new() 
	{
		localToWorld	= new Matrix3D();
		matrix 			= new Matrix3D();
		
		position 		= new Vector3D();
		scale 			= new Vector3D();
		rotation 		= new Vector3D();
	}
	
}