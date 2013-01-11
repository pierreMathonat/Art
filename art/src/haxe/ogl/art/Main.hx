package haxe.ogl.art;

import com.eclecticdesignstudio.motion.Actuate;
import haxe.ogl.art.core.Blend;
import haxe.ogl.art.core.IndexStream;
import haxe.ogl.art.core.Material;
import haxe.ogl.art.core.VertexFormat;
import haxe.ogl.art.core.VertexStream;
import haxe.ogl.art.m2d.atlas.Atlas;
import haxe.ogl.art.m2d.geom.ColorTransform;
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
		var group:Sprite = new Sprite();
		
		var bmd2 = Atlas.getBitmapData("img/wall.png");
		
		trace(bmd2);
		
		for (x in 0...50)
		{
			for (y in 0...20)
			{
				var ds = new Bitmap(Atlas.getBitmapData("img/crate.png"));
				ds.x = x * 128;
				ds.y = y * 128;
				ds.rotationZ = 90;
				ds.scaleX = ds.scaleY = Math.random();
				Actuate.tween(ds, 20, { rotationZ:360 } ).repeat().reflect();
				group.addChild(ds);	
			}
			
			var b2 = new Bitmap(bmd2);
			b2.x = b2.y = x * 32;
			group.addChild(b2);
			
		}
		
		group.colorTransform = new ColorTransform(1.4, 1.4, 1.4);
		scene.addChild(group);
		addEventListener(Event.ENTER_FRAME, update);
	}
	
	var scene:Stage;
	inline function update(e):Void
	{
		ctx.clear();
		scene.render();
		Bitmap.batch.draw();
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
