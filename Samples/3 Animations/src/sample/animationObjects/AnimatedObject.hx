package sample.animationObjects;
import com.creativemage.tilesheet.AnimatedBody;
import com.creativemage.tilesheet.Animation;

/**
 * ...
 * @author Creative Magic
 */
class AnimatedObject extends AnimatedBody
{
	
	public var speedX:Float;
	public var speedY(default, null):Float;

	public function new( animationFrameIndexes:Array<Int>) 
	{
		super();
		
		var a:Animation = new Animation(animationFrameIndexes);
		addAnimation(a);
		
		speedX = -10 + Math.random() * 20;
		speedY = -1 + Math.random() * 2;
	}
	
}