package haxe.ogl.art;

import com.eclecticdesignstudio.motion.Actuate;
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
		
		var bmd = new Tex2D(Assets.getBitmapData("img/crate.png", false));
		
		for (x in 0...20)
		{
			for (y in 0...20)
			{
				var ds = new Bitmap(bmd);
				ds.x = x * 64;
				ds.y = y * 64;
				ds.rotationZ = 90;
				ds.scaleX = ds.scaleY = Math.random();
				Actuate.tween(ds, 20, { rotationZ:360 } ).repeat().reflect();
				group.addChild(ds);				
			}

		}
		
		scene.addChild(group);
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
		stage.quality = StageQuality.LOW;
		
		Lib.current.addChild(new Main());
	}
	
}
