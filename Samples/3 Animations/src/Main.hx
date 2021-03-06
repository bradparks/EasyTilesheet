package ;

import com.creativemage.libLoader.events.LibraryLoaderEvent;
import com.creativemage.libLoader.LibraryLoader;
import flash.display.Sprite;
import flash.events.Event;
import flash.Lib;
import openfl.display.FPS;
import sample.Sample;

/**
 * ...
 * @author Creative Magic
 */

class Main extends Sprite 
{
	var inited:Bool;

	/* ENTRY POINT */
	
	function resize(e) 
	{
		if (!inited) init();
		// else (resize or orientation change)
	}
	
	function init() 
	{
		if (inited) return;
		inited = true;

		// (your code here)
		
		// this is a loader for the SWF files
		var libLoader:LibraryLoader = new LibraryLoader();
		libLoader.addLibraryToLoadingList("sampleAnimation");
		libLoader.addEventListener( LibraryLoaderEvent.ALL_LIBRARIES_LOADED, onAllLibsLoaded);
		libLoader.load();
	}
	
	private function onAllLibsLoaded(e:LibraryLoaderEvent):Void 
	{
		var sampleInstance:Sample = new Sample();
		Lib.current.stage.addChild(sampleInstance);
		
		Lib.current.stage.addChild ( new FPS( 0, 0, 0xFFFFFF ));
	}

	/* SETUP */

	public function new() 
	{
		super();	
		addEventListener(Event.ADDED_TO_STAGE, added);
	}

	function added(e) 
	{
		removeEventListener(Event.ADDED_TO_STAGE, added);
		stage.addEventListener(Event.RESIZE, resize);
		#if ios
		haxe.Timer.delay(init, 100); // iOS 6
		#else
		init();
		#end
	}
	
	public static function main() 
	{
		// static entry point
		Lib.current.stage.align = flash.display.StageAlign.TOP_LEFT;
		Lib.current.stage.scaleMode = flash.display.StageScaleMode.NO_SCALE;
		Lib.current.addChild(new Main());
	}
}
