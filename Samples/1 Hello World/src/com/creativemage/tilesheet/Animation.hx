package com.creativemage.tilesheet;
import com.creativemage.tilesheet.EasyTilesheet;
import flash.display.BitmapData;
import openfl.display.DisplayObject;
import openfl.geom.Point;

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
	
	public var frameSizes:Array<Point> = [];
	private var currentIndex:Int = 0;
	
	public var currentWidth(get, never):Float;
	public var currentHeight(get, never):Float;

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
	
	/**
	 * This method will set the animation's current frame to the provided frame index.
	 * @param	frame - 1-based representation of the frame index. Negative values will be used as an offset from the total frame count.
	 */
	public function gotoFrame(frame:Int):Void
	{
		currentIndex = (frame - 1) % frameCount;
		currentFrame = frameIndexes[currentIndex];
	}
	
	// GETTERS AND SETTERS
	function get_currentWidth():Float
	{
		return frameSizes[currentIndex].x;
	}
	
	function get_currentHeight():Float
	{
		return frameSizes[currentIndex].y;
	}
	
}