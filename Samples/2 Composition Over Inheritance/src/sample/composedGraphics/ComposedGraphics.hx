package sample.composedGraphics;
import com.creativemage.tilesheet.AnimatedBody;
import com.creativemage.tilesheet.Animation;

/**
 * ...
 * @author Creative Magic
 * 
 * In this example the class does not extending any class. Instead the AnimatedBody is an object in this class.
 */
class ComposedGraphics
{
	public var animatedBody(default, null):AnimatedBody;
	
	public var speedX:Float;

	public function new() 
	{
		var animation:Animation = new Animation([1]);
		
		animatedBody = new AnimatedBody();
		animatedBody.addAnimation(animation);
		
		speedX = Math.random() * 5;
	}
	
}