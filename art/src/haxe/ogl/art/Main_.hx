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
import nme.display.StageQuality;
import nme.events.Event;
import nme.geom.Matrix3D;
import nme.Lib;
import nme.display.Sprite;
import nme.display.Stage;
import nme.display.Bitmap;

/**
 * ...
 * @author pierre
 */

class Main extends Sprite
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
		var group = new Sprite();
		
		for (i in 0...1000)
		{
			var ds = new Bitmap(Assets.getBitmapData("img/crate.png",false));
			ds.x = ds.y = i*32;
			ds.rotation = 90;
			group.addChild(ds);
		}

		
		addChild(group);
		addEventListener(Event.ENTER_FRAME, update);
		
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
		
		
		

	}
	
	var time:Int;
	var fpst:Int;
	var frame:Int;
	var fps:Int;
	inline function update(e):Void
	{
		frame++;
		
		time = Lib.getTimer();
		if (fpst == 0) fpst = time;
		
		if (time-fpst > 1000)
		{
			fps = frame;
			frame = 0;
			fpst = time;
			trace(fps);
		}
		
		
	}
	
	static public function main() 
	{
		var stage = Lib.current.stage;
		stage.scaleMode = nme.display.StageScaleMode.NO_SCALE;
		stage.align = nme.display.StageAlign.TOP_LEFT;
		stage.quality = StageQuality.LOW;
		
		Lib.current.addChild(new Main());
	}
	
}
