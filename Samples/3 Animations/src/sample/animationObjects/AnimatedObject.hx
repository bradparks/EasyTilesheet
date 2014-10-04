package sample.animationObjects;
import com.creativemage.tilesheet.AnimatedBody;
import com.creativemage.tilesheet.Animation;

/**
 * ...
 * @author Creative Magic
 */
class AnimatedObject extends AnimatedBody
{
	
	public var speedX(default, null):Float;
	public var speedY(default, null):Float;

	public function new( animationFrameIndexes:Array<Int>) 
	{
		super();
		
		var a:Animation = new Animation(animationFrameIndexes);
		addAnimation(a);
		
		speedX = -1 + Math.random() * 2;
		speedY = -1 + Math.random() * 2;
	}
	
}