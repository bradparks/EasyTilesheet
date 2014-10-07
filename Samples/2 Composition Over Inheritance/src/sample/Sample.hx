package sample;
import com.creativemage.tilesheet.EasyTilesheet;
import flash.events.Event;
import openfl.Assets;
import openfl.display.Sprite;
import openfl.events.TimerEvent;
import openfl.Lib;
import openfl.utils.Timer;
import sample.composedGraphics.ComposedGraphics;
import sample.inheritedGraphics.InheritedGraphics;

/**
 * ...
 * @author Creative Magic
 */
class Sample extends Sprite
{
	private var tileSheet:EasyTilesheet;
	
	private var composedObjArray:Array<ComposedGraphics> = [];
	private var inheritedObjArray:Array<InheritedGraphics> = [];
	
	private var timer:Timer;

	public function new() 
	{
		super();
		
		makeTileSheet();
		
		makeInheritedGraphics();
		makeComposedGraphics();
		
		setTimer();
		start();
	}
	
	function makeTileSheet() 
	{
		tileSheet = new EasyTilesheet( this.graphics );
		tileSheet.addTextureToAtlas( Assets.getBitmapData("img/bunny.png") ); // if you want, you can just remember the indexes and not store them
		tileSheet.addTextureToAtlas( Assets.getBitmapData("img/carrot.png") ); // indexes are particularly useful if you make renderer classes for animated objects
	}
	
	function makeInheritedGraphics() 
	{
		for ( i in 0...10000)
		{
			var obj:InheritedGraphics = new InheritedGraphics();
			obj.x = Math.random() * Lib.current.stage.stageWidth;
			obj.y = Math.random() * Lib.current.stage.stageHeight;
			tileSheet.addAnimationBody( obj );
			inheritedObjArray.push(obj);
		}
	}
	
	function makeComposedGraphics() 
	{
		for ( i in 0...10000)
		{
			var obj:ComposedGraphics = new ComposedGraphics();
			obj.animatedBody.x = Math.random() * Lib.current.stage.stageWidth;
			obj.animatedBody.y = Math.random() * Lib.current.stage.stageHeight;
			tileSheet.addAnimationBody( obj.animatedBody );
			composedObjArray.push(obj);
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
	
	// EVENT HANDLERS
	
	private function tick(e:Event):Void 
	{
		for ( iGfx in inheritedObjArray)
		{
			iGfx.x += iGfx.speedX;
			
			if ( iGfx.x > Lib.current.stage.stageWidth || iGfx.x < 0)
				iGfx.speedX *= -1;
		}
		
		for ( cGfx in composedObjArray)
		{
			cGfx.animatedBody.x += cGfx.speedX;
			
			if ( cGfx.animatedBody.x > Lib.current.stage.stageWidth || cGfx.animatedBody.x < 0)
				cGfx.speedX *= -1;
			
		}
		
		tileSheet.update();
	}
	
}