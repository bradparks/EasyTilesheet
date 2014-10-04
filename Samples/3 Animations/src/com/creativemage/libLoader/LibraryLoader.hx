package com.creativemage.libLoader ;
import com.creativemage.libLoader.events.LibraryLoaderEvent;
import openfl.Assets;
import openfl.events.Event;
import openfl.events.EventDispatcher;

/**
 * ...
 * @author Creative Magic
 */
class LibraryLoader extends EventDispatcher
{
	private var libArray:Array<String> = [];
	private var loadedLibCount:Int = 0;

	public function new() 
	{
		super();
	}
	
	public function addLibraryToLoadingList(libName:String):Void
	{
		libArray.push(libName);
	}
	
	public function load():Void
	{
		for (i in 0...libArray.length)
			Assets.loadLibrary(libArray[i], onLibLoaded);
	}
	
	function onLibLoaded(a:AssetLibrary):Void
	{
		var libEvent = new LibraryLoaderEvent(LibraryLoaderEvent.LIBRARY_LOADED);
		libEvent.assetLibrary = a;
		dispatchEvent(libEvent);
		
		loadedLibCount++;
		
		if (loadedLibCount == libArray.length)
			onAllLibsLoaded();
	}
	
	function onAllLibsLoaded():Void
	{
		var libEvent = new LibraryLoaderEvent(LibraryLoaderEvent.ALL_LIBRARIES_LOADED);
		dispatchEvent(libEvent);
	}
	
}