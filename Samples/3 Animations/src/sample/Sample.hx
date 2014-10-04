package sample;
import com.creativemage.tilesheet.EasyTilesheet;
import flash.events.Event;
import openfl.Assets;
import openfl.display.BitmapData;
import openfl.display.Sprite;
import openfl.events.TimerEvent;
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
	

	public function new() 
	{
		super();
		
		makeTilesheet();
		var renderedIndexes = renderMovieClip();
		createAnimatedObjects(renderedIndexes);
		
		setTimer();
		start();
	}
	
	function makeTilesheet() 
	{
		tileSheet = new EasyTilesheet( this.graphics );
	}
	
	function createAnimatedObjects(frameIndexes:Array<Int>) 
	{
		for ( i in 0...100)
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
			
			var index:Int = tileSheet.addTextureToAtlas( bd );
			frameIndexArray.push(index);
		}
		
		return frameIndexArray;
	}
	
	// EVENT HANDLERS
	
	private function tick(e:Event):Void 
	{
		for (a in aniObjArray)
		{
			a.x += a.speedX;
			a.y += a.speedY;
		}
		
		tileSheet.update();
	}
	
}