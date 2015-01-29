package src.com.creativemage.tilesheet.utils ;
import openfl.display.BitmapData;
import openfl.display.MovieClip;
import openfl.geom.Matrix;
import openfl.geom.Point;

/**
 * ...
 * @author Creative Magic
 */
class SWFRenderer
{

	public static function render(clip:MovieClip, bgWidth:Int, bgHeight:Int, scale:Float):Array<BitmapData>
	{
		var bdArray:Array<BitmapData> = [];
		
		var clipLargestOffset = getClipLargestOffset(clip);
		
		clip.gotoAndStop(0);
		var matrix:Matrix = new Matrix();
		matrix.translate(clipLargestOffset.x, clipLargestOffset.y);
		matrix.scale( scale );
		
		for ( i in 1...clip.totalFrames + 1 )
		{
			next(clip);
			
			var bd:BitmapData = new BitmapData( bgWidth, bgHeight, true, 0x00000000);
			bd.draw( clip, matrix);
			
			bdArray.push(bd);
		}
		
		return bdArray;
	}
	
	static private function nextFrame(clip:MovieClip):Void 
	{
		var nextFrame:Int = (clip.currentFrame + 1) % clip.totalFrames;
		
		if (nextFrame == 0)
			nextFrame = 1;
		
		clip.gotoAndStop( nextFrame );
		
		for ( i in 0...clip.numChildren)
		{
			var child = clip.getChildAt(i);
			
			if (Type.typeof( child ) == MovieClip)
				next(child);
		}
	}
	
	static private function getClipLargestOffset(clip:MovieClip):Point
	{
		var bounds:Rectangle = clip.getBounds(clip);
		
		var offsetX:Float = bounds.x;
		var offsetY:Float = bounds.y;
		
		
		for ( i in 1...clip.totalFrames + 1)
		{
			bounds = clip.getBounds(clip);
			
			if ( bounds.x < offsetX )
			offsetX = bounds.x;
			
			if ( bounds.y < offsetY )
			offsetY = bounds.y;
		}
		
		return new Point(offsetX, offsetY);
	}
	
	
}