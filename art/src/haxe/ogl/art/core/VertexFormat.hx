package haxe.ogl.art.core;

import nme.display3D.Context3DVertexBufferFormat;

/**
 * ...
 * @author pierre
 */

 enum USAGE
 {
	position;
	color;
	uv;
	normal;
	tangent;
 }
 
 enum FORMAT
 {
	float1;
	float2;
	float3;
	float4;
 }
 
 class VertexComponent
 {
	public static var XYZ		:VertexComponent = new VertexComponent("xyz"		, USAGE.position	, FORMAT.float3);
	public static var COLOR		:VertexComponent = new VertexComponent("color"		, USAGE.color		, FORMAT.float4);
	public static var NORMAL	:VertexComponent = new VertexComponent("normal"		, USAGE.normal		, FORMAT.float3); 
	public static var UV		:VertexComponent = new VertexComponent("uv"  		, USAGE.uv 			, FORMAT.float2);
	
	
	//--------------------------------------------------------------------------------------------------------------------
	
	public static var UNIQUE_ID:Int = 0;
	
	public var id			:Int;
	public var name			:String;
	public var usage		:USAGE;
	public var format		:FORMAT;
	public var stride		:Int;
	public var C3DFORMAT	:Context3DVertexBufferFormat;
	
	public function new(n:String, u:USAGE, f:FORMAT)
	{
		name 		= n;
		id			= UNIQUE_ID++;
		usage 		= u;
		format 		= f;
		stride 		= sizeOf(format);
		C3DFORMAT 	= typeOf(format);
	}
	
	inline function sizeOf(f:FORMAT):Int
	{
		return switch(f)
		{
			case FORMAT.float1:1;
			case FORMAT.float2:2;
			case FORMAT.float3:3;
			case FORMAT.float4:4;
		}
	}
	
	inline function typeOf(f:FORMAT):Context3DVertexBufferFormat
	{
		return switch(f)
		{
			case FORMAT.float1:Context3DVertexBufferFormat.FLOAT_1;
			case FORMAT.float2:Context3DVertexBufferFormat.FLOAT_2;
			case FORMAT.float3:Context3DVertexBufferFormat.FLOAT_3;
			case FORMAT.float4:Context3DVertexBufferFormat.FLOAT_4;
		}
	}
 }
 
 class VertexFormat
 {
	
	public static var DEFAULT:VertexFormat = new VertexFormat([
		VertexComponent.XYZ, 
		VertexComponent.UV, 
		VertexComponent.COLOR
	]);
	 
	//----------------------------------------------------------------------------------------------------------
	
	public var components	:Array<VertexComponent>;
	public var offsets		:Array<Int>;
	public var stride		:Int;
	
	public function new (comps:Array<VertexComponent>)
	{
		components 			= new Array<VertexComponent>();
		offsets				= new Array<Int>();
		
		for (c in comps) addComponent(c);
	}
	
	public function build():Void
	{
		stride = 0;
		
		for (c in components)
		{
			offsets[c.id] = stride;
			stride += c.stride;
		}
	}
	
	public inline function componentAt(i:Int):VertexComponent
	{
		return components[i];
	}
	
	public function addComponent(comp:VertexComponent):Void
	{
		components.push(comp);
		offsets[comp.id] = stride;
		stride += comp.stride;
	}
	
	public function removeComponent(comp:VertexComponent):Void
	{
		components.remove(comp);
		offsets[comp.id]=-1;
		build();
	}
	
	public function hasComponent(comp:VertexComponent):Bool
	{
		return offsets[comp.id]>=0;
	}
	
	public function offset(comp:VertexComponent):Int
	{
		return offsets[comp.id];
	}
	
	public function hasUsage(u:USAGE):Bool
	{
		for (c in components) if (c.usage == u) return true;
		return false;
	}
	public function offsetByUsage(u:USAGE):Int
	{
		for (c in components) if (c.usage == u) return offsets[c.id];
		return -1;
	}
 }