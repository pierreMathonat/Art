package haxe.ogl.art;

import haxe.ogl.art.core.IndexStream;
import haxe.ogl.art.core.Material;
import haxe.ogl.art.core.VertexStream;
import nme.display.BitmapData;
import haxe.ogl.art.core.Tex2D;
import haxe.ogl.art.core.View;
import nme.display.Sprite;
import nme.events.Event;
import nme.geom.Matrix3D;
import nme.Lib;

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
		var t2D:Tex2D = new Tex2D(new BitmapData(512, 512, true, 0xFFFFCCCC));
		var m:Material = new Material();
				
		var vs = new VertexStream(9);
		vs.fromArray([	0, 0, 0, 0, 0,			2,0,0,1,
						0, 256, 0, 0, 1,		1,0,0,1,
						256, 256, 0, 1, 1,		1, 1, 1, 0,
						256, 0, 0, 1, 0,		1,1,1,0,
					]);
		
		var is = new IndexStream();
		is.fromArray([1, 2, 3, 0, 1, 3]);
		
		var m3d:Matrix3D = new Matrix3D();
		m3d.appendTranslation(-s.stageWidth/2.0, -s.stageHeight/2.0, 0);
		m3d.appendScale(2.0 / s.stageWidth, -2.0 / s.stageHeight, 1);

		m.bind(vs, { mview:m3d }, { tex:t2D.native } );
				
		ctx.clear(.5, .5, .5);
		ctx.drawTriangles(is.buffer);
		ctx.present();
	}
	
	static public function main() 
	{
		var stage = Lib.current.stage;
		stage.scaleMode = nme.display.StageScaleMode.NO_SCALE;
		stage.align = nme.display.StageAlign.TOP_LEFT;
		
		Lib.current.addChild(new Main());
	}
	
}
