package ;
import com.creativemage.tilesheet.AnimatedBody;
import com.creativemage.tilesheet.Animation;
import com.creativemage.tilesheet.EasyTilesheet;
import flash.events.Event;
import openfl.Assets;
import openfl.display.Sprite;
import openfl.events.MouseEvent;
import openfl.events.TimerEvent;
import openfl.Lib;
import openfl.utils.Timer;

/**
 * ...
 * @author Creative Magic
 */
class Sample extends Sprite
{
	private var tileSheet:EasyTilesheet;
	private var animatebObjectArray:Array<AnimatedBody> = [];
	private var timer:Timer;
	
	private var textureIndex:Int;

	public function new() 
	{
		super();
		
		makeTileSheet();
		createAnimatedObjects();
		
		setTimer();
		start();
		
		addEventListener(MouseEvent.CLICK, onMouseClick);
	}
	
	/***
	 * The EasyTilesheet class will store the textures and is responsible
	 * for updating the AnimatedBody's animation and rendering on the screen.
	 * Please note - you cannot add textures to the tilesheet after running the init() function.
	 */
	function makeTileSheet() 
	{
		tileSheet = new EasyTilesheet( this.graphics ); // provide the Graphics instance where the images will be rendered to.
		textureIndex = tileSheet.addTextureToAtlas( Assets.getBitmapData("img/logo.png") ); // This method adds the textures and returns the ID of that texture.
		tileSheet.init(); // this method bakes the textures into one single BitmapData
		
	}
	
	/***
	 * Animation objects are references to the BitmapData indexes that will be rendered by the Tilesheet.
	 * AnimationBody can hold many animations. This is useful to switch animations on run-time. Animations bodies are extending Sprites
	 * that allows you to simply change the x,y,alpha and scale parameters and let Tilesheet do the rendering.
	 */
	function createAnimatedObjects() 
	{
		var ani = new Animation([ textureIndex ]); // create as many animations as you need. For this example there's only one animation object with a single frame.
		
		for (i in 0...100)
		{
			var aniBody:AnimatedBody = new AnimatedBody();
			
			aniBody.x = Math.random() * Lib.current.stage.stageWidth;
			aniBody.y = Math.random() * Lib.current.stage.stageHeight;
			
			aniBody.addAnimation( ani ); // you need to add atleast 1 animation to the animation body
			
			tileSheet.addAnimationBody(aniBody); // do not addChild the animation, instead add it to the tilesheet.
			
			animatebObjectArray.push(aniBody);
		}
	}
	
	function setTimer() 
	{
		timer = new Timer(33);
		timer.addEventListener( TimerEvent.TIMER, tick);
	}
	
	function start() 
	{
		timer.start();
	}
	
	// EVENT HANDLERS
	
	private function onMouseClick(e:MouseEvent):Void 
	{
		tileSheet.setNewAtlas( Assets.getBitmapData("img/replacement.png") );
	}
	
	private function tick(e:Event):Void 
	{
		for (aniBody in animatebObjectArray)
		{
			aniBody.x += .23;
			aniBody.y += Math.cos( aniBody.x ) * .3;
			
			if (aniBody.x > Lib.current.stage.stageWidth)
				aniBody.x = -100;
		}
		
		tileSheet.update();
	}
	
}