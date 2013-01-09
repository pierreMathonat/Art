package haxe.ogl.art.core;
import nme.display.Sprite;
import nme.display.Stage;
import nme.display.Stage3D;
import nme.display3D.Context3D;
import nme.events.Event;
import nme.Lib;
import src.haxe.ogl.art.core.Renderer;

/**
 * ...
 * @author pierre
 */

class View extends Sprite
{
	public static var _I:View;
	
	public var s:Stage;
	public var s3d:Stage3D;
	public var ctx:Context3D;
	
	public var cam2D:Camera2D;
	
	var enterFrameEvent:Event;
	
	public var time:Int;
	public var fps:Int;
	
	public var renderer:Renderer;
	
	public function new() 
	{
		enterFrameEvent = new Event(Event.ENTER_FRAME);
		
		super();
		cam2D = new Camera2D();
		addEventListener(Event.ADDED_TO_STAGE, _init);
	}
	
	function _init(e)
	{
		e.stopImmediatePropagation();
		removeEventListener(Event.ADDED_TO_STAGE, _init);
		
		s = Lib.current.stage;
		
		s.addEventListener(Event.ENTER_FRAME, enterFrame);
		s.addEventListener(Event.RESIZE, resize);
		
		s3d = s.stage3Ds[0];
		s3d.addEventListener(Event.CONTEXT3D_CREATE, init3d);
		s3d.requestContext3D();
	}
	
	function init3d(e)
	{
		s3d.removeEventListener(Event.CONTEXT3D_CREATE, init3d);
		ctx = s3d.context3D;
		resize(e);
		
		if (_I == null)_I = this;
		renderer = new Renderer(ctx);
		
		dispatchEvent(new Event(Event.ADDED_TO_STAGE));
	}
	
	function resize(e):Void
	{
		ctx.configureBackBuffer(s.stageWidth, s.stageHeight, 0);
		cam2D.resize(s.stageWidth, s.stageHeight);
	}
	
	var fpstime:Int;
	var frames:Int;
	function enterFrame(e):Void
	{
		time = Lib.getTimer();
		dispatchEvent(enterFrameEvent);
		frames++;
		
		if (fpstime == 0) fpstime = time;
		if (time-fpstime > 1000)
		{
			fps = frames;
			frames = fpstime = 0;
		}
	}
	
	function drawTriangles(istream:IndexStream, first:Int=0, numTris:Int=-1):Void
	{
		ctx.drawTriangles(istream.buffer, first, numTris);
	}
}