package com.creativemage.tilesheet;
import openfl.errors.Error;
import openfl.display.Sprite;

/**
 * ...
 * @author Alex Kolpakov
 */
class AnimatedBody extends Sprite
{
	public var index(get, never):Int;
	public var scale(get, set):Float;
	
	private var animationArray:Array<Animation> = [];
	private var currentAnimation:Animation;
	
	@:isVar public var isPaused(default, null):Bool = false;
	
	public function new() 
	{
		super();
	}
	
	// PUBLIC METHODS
	public function pause():Void
	{
		isPaused = true;
	}
	
	public function play():Void
	{
		isPaused = false;
	}
	
	public function update():Void
	{
		if (isPaused == true)
			return;
			
		currentAnimation.update();
	}
	
	public function setAnimation(aniID:Int):Void
	{
		if (aniID >= animationArray.length || aniID < 0)
		{
			throw new Error("the animation is out of bounds");
			return;
		}
		currentAnimation = animationArray[aniID];
	}
	
	public function setAnimationByName(aniName:String):Void
	{
		for (ani in animationArray)
		if (ani.name == aniName)
		{
			currentAnimation = ani;
			return;
		}
		throw new Error("the animation with this name does not exist");
	}
	
	public function addAnimation(animation:Animation):Bool
	{
		for (a in animationArray)
		if (a == animation)
		return false;
		
		animationArray.push(animation);
		
		currentAnimation = animationArray[0];
		return true;
	}
	
	public function removeAnimation(animation:Animation):Bool
	{
		var removeSuccessful:Bool = animationArray.remove(animation);
		
		if (animationArray.length < 1)
			currentAnimation = null;
		return animationArray.remove(animation);
	}
	
	public function removeAnimationByName(animation:String):Bool
	{
		for (ani in animationArray)
		if (ani.name == animation)
		return animationArray.remove(ani);
		
		throw new Error("the animation with this name does not exist");
		return false;
	}
	
	// GETTERS AND SETTERS
	function get_frameCount():Int
	{
		if (currentAnimation == null)
			return 0;
			
		return currentAnimation.frameCount;
	}
	
	function get_index():Int
	{
		if (currentAnimation == null)
			return 0;
		
		return currentAnimation.currentFrame;
	}
	
	function get_scale():Float 
	{
		return scaleX;
	}
	
	function set_scale(value:Float):Float 
	{
		return scaleX = scaleY = value;
	}
	
}