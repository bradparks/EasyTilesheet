package com.creativemage.tilesheet;
import com.creativemage.tilesheet.EasyTilesheet;
import flash.display.BitmapData;
import openfl.display.DisplayObject;

/**
 * ...
 * @author Alex Kolpakov
 */
class Animation
{
	public var name:String = "";
	
	@:isVar public var frameCount(default, null):Int;
	@:isVar public var currentFrame(default, null):Int;
	
	public var frameIndexes(default, null):Array<Int> = [];
	private var currentIndex:Int = 0;

	public function new(?frameIndexes:Array<Int>) 
	{
		if (frameIndexes != null)
		{
			this.frameIndexes = frameIndexes;
			frameCount = frameIndexes.length;
		}
	}
	
	// PUBLIC METHODS
	public function setFrameIndexes(frameIndexes:Array<Int>):Void
	{
		this.frameIndexes = frameIndexes;
		frameCount = frameIndexes.length;
	}
	
	public function update():Void
	{
		currentIndex = (currentIndex + 1) % frameCount;
		currentFrame = frameIndexes[currentIndex];
	}
	
}