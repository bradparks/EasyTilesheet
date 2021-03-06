package sample;
import com.creativemage.tilesheet.EasyTilesheet;
import openfl.display.Bitmap;
import openfl.events.Event;
import openfl.Assets;
import openfl.display.BitmapData;
import openfl.display.Sprite;
import openfl.events.MouseEvent;
import openfl.events.TimerEvent;
import openfl.geom.Point;
import openfl.Lib;
import openfl.utils.Timer;
import sample.animationObjects.AnimatedObject;

/**
 * ...
 * @author Creative Magic
 */
class Sample extends Sprite
{
	private var tileSheet:EasyTilesheet;
	private var aniObjArray:Array<AnimatedObject> = [];
	private var timer:Timer;
	var renderedIndexes:Array<Int>;
	

	public function new() 
	{
		super();
		
		makeTilesheet();
		renderedIndexes = renderMovieClip();
		createAnimatedObjects(renderedIndexes);
		
		setTimer();
		start();
		
		Lib.current.stage.addEventListener(MouseEvent.CLICK, onMouseClicked);
	}
	
	function makeTilesheet() 
	{
		tileSheet = new EasyTilesheet( this.graphics );
		
	}
	
	function createAnimatedObjects(frameIndexes:Array<Int>) 
	{
		for ( i in 0...1000)
		{
			var aObj:AnimatedObject = new AnimatedObject(frameIndexes);
			aObj.x = Lib.current.stage.stageWidth * Math.random();
			aObj.y = Lib.current.stage.stageHeight * Math.random();
			tileSheet.addAnimationBody(aObj);
			aniObjArray.push(aObj);
		}		
	}
	
	function setTimer() 
	{
		timer = new Timer(33);
		timer.addEventListener(TimerEvent.TIMER, tick);
	}
	
	function start() 
	{
		tileSheet.init();
		timer.start();
	}
	
	function renderMovieClip():Array<Int>
	{
		// rendering SWF to BitmapData
		var mc = Assets.getMovieClip("sampleAnimation:SampleClip");
		var frameIndexArray:Array<Int> = [];
		for (i in 0...mc.totalFrames)
		{
			mc.gotoAndStop(i + 1);
			
			var bd:BitmapData = new BitmapData( Std.int(mc.width), Std.int(mc.height), true, 0x00000000 );
			bd.draw(mc);
			
			var centerPoint = new Point();
			centerPoint.x = bd.width / 2;
			centerPoint.y = bd.height / 2;
			
			var index:Int = tileSheet.addTextureToAtlas( bd, centerPoint );
			frameIndexArray.push(index);
		}
		
		return frameIndexArray;
	}
	
	// EVENT HANDLERS
	
	private function onMouseClicked(e:Event):Void 
	{
		createAnimatedObjects(renderedIndexes);
	}
	
	private function tick(e:Event):Void 
	{
		for (a in aniObjArray)
		{
			a.x += a.speedX;
			
			if ( a.x > Lib.current.stage.stageWidth || a.x < 0)
				a.speedX *= -1;
				
			a.rotation += .1;
		}
		
		tileSheet.update();
	}
	
}