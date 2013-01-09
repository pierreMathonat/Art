package haxe.ogl.art;

import haxe.ogl.art.core.Blend;
import haxe.ogl.art.core.IndexStream;
import haxe.ogl.art.core.Material;
import haxe.ogl.art.core.VertexFormat;
import haxe.ogl.art.core.VertexStream;
import nme.Assets;
import nme.display.BitmapData;
import haxe.ogl.art.core.Tex2D;
import haxe.ogl.art.core.View;
import nme.events.Event;
import nme.geom.Matrix3D;
import nme.Lib;
import src.haxe.ogl.art.m2d.scene.DisplayObject;
import src.haxe.ogl.art.m2d.scene.DisplayObjectContainer;
import src.haxe.ogl.art.m2d.scene.Sprite;
import src.haxe.ogl.art.m2d.scene.Stage;
import src.haxe.ogl.art.m2d.scene.Bitmap;

/**
 * ...
 * @author pierre
 */

class Main extends View
{
	
	public function new() 
	{
		super();
		#if iphone
		Lib.current.stage.addEventListener(Event.RESIZE, init);
		#else
		addEventListener(Event.ADDED_TO_STAGE, init);
		#end
	}

	private function init(e)
	{		
				
		scene = new Stage();
		var group = new Sprite();
		
		for (i in 0...400)
		{
			var ds = new Bitmap(Assets.getBitmapData("img/crate.png"));
			ds.x = ds.y = i*32;
			ds.rotationZ = 90;
			group.addChild(ds);			
		}

		
		scene.addChild(group);
		
		//group.x = group.y = 128;
		//group.rotationZ = 45;
		
		
		
/*		var t2D:Tex2D = new Tex2D(nme.Assets.getBitmapData("img/crate.png"));
		var t2D2:Tex2D = new Tex2D(nme.Assets.getBitmapData("img/wall.png"));
		var m:Material = new Material();
		m.blend = Blend.NORMAL;
				
		var vs = new VertexStream(9);
		vs.fromArray([	0, 0, 0, 0, 0,			1,1,1,1,
						0, 256, 0, 0, 1,		1,1,1,1,
						256, 256, 0, 1, 1,		1, 1, 1, 1,
						256, 0, 0, 1, 0,		1,1,1,1,
					]);
		
		var is = new IndexStream();
		is.fromArray([1, 2, 3, 0, 1, 3]);

		
		
		m.bind(vs, { mview:cam2D, transform:new Matrix3D() }, { tex:t2D.native } );
		ctx.drawTriangles(is.buffer);
		m.bind(vs, { mview:cam2D, transform:new Matrix3D() }, { tex:t2D2.native } );
		ctx.drawTriangles(is.buffer);*/
		
		addEventListener(Event.ENTER_FRAME, update);
		

	}
	var scene:Stage;
	inline function update(e):Void
	{
		ctx.clear(.5, .5, .5);
		scene.render();
		ctx.present();	
		trace(fps);
	}
	
	static public function main() 
	{
		var stage = Lib.current.stage;
		stage.scaleMode = nme.display.StageScaleMode.NO_SCALE;
		stage.align = nme.display.StageAlign.TOP_LEFT;
		
		Lib.current.addChild(new Main());
	}
	
}
