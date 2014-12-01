package com.creativemage.libLoader.events ;
import openfl.Assets.AssetLibrary;
import openfl.events.Event;

/**
 * ...
 * @author Creative Magic
 */
class LibraryLoaderEvent extends Event
{
	public static var LIBRARY_LOADED:String = "libraryLoaded";
	public static var ALL_LIBRARIES_LOADED:String = "allLoaded";
	
	public var assetLibrary:AssetLibrary;

	public function new(type:String, bubbles:Bool = false, cancelable:Bool = false) 
	{
		super(type, bubbles, cancelable);
	}
	
}