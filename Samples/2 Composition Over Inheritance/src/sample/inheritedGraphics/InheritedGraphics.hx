package sample.inheritedGraphics;
import com.creativemage.tilesheet.AnimatedBody;
import com.creativemage.tilesheet.Animation;

/**
 * ...
 * @author Creative Magic
 * 
 * In this example the class extends AnimatedBody. This is how you would usually handle Sprites.
 * Problem is if you want to separate the objects as much as possible and possibly share AnimatedBody objects among classes.
 */
class InheritedGraphics extends AnimatedBody
{
	public var speedX:Float;

	public function new() 
	{
		super();
		
		var ani:Animation = new Animation([0]);
		addAnimation(ani);
		
		speedX = Math.random() * 5;
	}
	
}