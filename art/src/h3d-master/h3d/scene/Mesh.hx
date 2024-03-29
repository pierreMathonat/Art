package h3d.scene;

class Mesh extends Object {

	public var primitive : h3d.prim.Primitive;
	public var material : h3d.mat.MeshMaterial;
	
	public function new( prim, ?mat, ?parent ) {
		super(parent);
		this.primitive = prim;
		if( mat == null ) mat = new h3d.mat.MeshMaterial(null);
		this.material = mat;
	}
	
	override function getBounds( ?b : h3d.prim.Bounds ) {
		if( b == null ) b = new h3d.prim.Bounds();
		b.add(primitive.getBounds());
		return super.getBounds(b);
	}
	
	override function clone( ?o : Object ) {
		var m = o == null ? new Mesh(null,material) : cast o;
		m.primitive = primitive;
		m.material = material.clone();
		super.clone(m);
		return m;
	}
	
	override function draw( ctx : RenderContext ) {
		material.setMatrixes(this.absPos, ctx.camera.m);
		ctx.engine.selectMaterial(material);
		primitive.render(ctx.engine);
	}
	
}