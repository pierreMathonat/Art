package haxe.ogl.art.core;

class Vec3 {

	inline public static var EPS:Float = 0.000001;
	
	public var x : Float;
	public var y : Float;
	public var z : Float;
	public var w : Float;

	public function new( x = 0., y = 0., z = 0., w = 1. ) {
		this.x = x;
		this.y = y;
		this.z = z;
		this.w = w;
	}

	public inline function sub( v : Vec3 ) {
		return new Vec3(x - v.x, y - v.y, z - v.z, w - v.w);
	}

	public inline function add( v : Vec3 ) {
		return new Vec3(x + v.x, y + v.y, z + v.z, w + v.w);
	}

	public inline function cross( v : Vec3 ) {
		return new Vec3(y * v.z - z * v.y, z * v.x - x * v.z,  x * v.y - y * v.x, 1);
	}

	public inline function dot3( v : Vec3 ) {
		return x * v.x + y * v.y + z * v.z;
	}

	public inline function dot4( v : Vec3 ) {
		return x * v.x + y * v.y + z * v.z + w * v.w;
	}
	
	public inline function length() {
		return Math.sqrt(x * x + y * y + z * z);
	}

	public function normalize() {
		var k = length();
		k=( k < EPS )? 0 : (1.0 / k);
		x *= k;
		y *= k;
		z *= k;
	}

	public function set(x,y,z,w=1.):Vec3 {
		this.x = x;
		this.y = y;
		this.z = z;
		this.w = w;
		return this;
	}

	public inline function scale3( f : Float ) {
		x *= f;
		y *= f;
		z *= f;
	}
	
	public inline function project( m : M44 ) {
		var px = x * m._11 + y * m._21 + z * m._31 + w * m._41;
		var py = x * m._12 + y * m._22 + z * m._32 + w * m._42;
		var pz = x * m._13 + y * m._23 + z * m._33 + w * m._43;
		var w = 1 / (x * m._14 + y * m._24 + z * m._34 + w * m._44);
		x = px * w;
		y = py * w;
		z = pz * w;
		w = 1;
	}
	
	public inline function project3x4( m : M44 ) {
		var px = x * m._11 + y * m._21 + z * m._31 + w * m._41;
		var py = x * m._12 + y * m._22 + z * m._32 + w * m._42;
		var pz = x * m._13 + y * m._23 + z * m._33 + w * m._43;
		x = px;
		y = py;
		z = pz;
	}

	public inline function copy() {
		return new Vec3(x,y,z,w);
	}

	public function toString() {
		return "{"+x+","+y+","+z+","+w+"}";
	}

}