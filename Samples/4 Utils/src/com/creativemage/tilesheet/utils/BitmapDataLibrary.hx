package src.com.creativemage.tilesheet.utils ;
import com.creativemage.tilesheet.Animation;
import src.com.creativemage.tilesheet.utils.BitmapDataLibrary.ClipSize;
import src.com.creativemage.tilesheet.utils.BitmapDataLibrary.ReferenceFrame;
import openfl.display.BitmapData;
import openfl.display.MovieClip;
import openfl.geom.Point;
import openfl.geom.Rectangle;

/**
 * ...
 * @author Creative Magic
 */

enum ClipSize
{
	Default;
	Width(value:Float);
	Height(value:Float);
	WidthHeight(w:Float, h:Float);
	Scale(value:Float);
}

enum ReferenceFrame
{
	FirstFrame;
	LargestFrame;
	Frame(index:Int);
}

enum RotationPivot
{
	Default;
	Origin;
	Custom(x:Float, y:Float);
}

class BitmapDataLibrary
{
	private static var registeredClips:Array<BitmapDataClip> = [];

	public static function addClip(clip:MovieClip, name:String, size:ClipSize = ClipSize.Default, originFrame:ReferenceFrame = ReferenceFrame.FirstFrame, rotationPivot:RotationPivot = RotationPivot.Origin):BitmapDataClip
	{
		var clipLargestOffset = getClipLargestOffset(clip);
		var clipLargestSize = getClipLargestSize(clip);
		
		var clipEndSize = getClipSize(clip, size, originFrame);
		
		var bc:BitmapDataClip = new BitmapDataClip();
		bc.name = name;
		bc.frames = getFrames(clip, clipSize.x, clipSize.y);
		bc.pivotPoint = getPivotPoint(clip, rotationPivot );
		
		registeredClips.push(bc);
		
		return bc;
	}
	
	public static function addBitmapData( bd:BitmapData, name:String, size:ClipSize = Default, rotationPivot:RotationPivot = Origin )
	{
		
	}
	
	public static function addBitmapDataArray( bdArray:Array<BitmapData>, name:String, size:ClipSize = Default, rotationPivot:RotationPivot = Origin )
	{
		
	}
	
	public static function removeClip(name:String):Bool
	{
		for (c in registeredClips)
		if (c.name == name)
		{
			registeredClips.remove( c );
			return true;
		}
		
		return false;
	}
	
	public static function getClip(name:String):BitmapDataClip
	{
		for ( c in registeredClips)
		if (c.name == name)
		return c;
		return null;
	}
	
	// PRIVATE METHODS
	
	static private function getClipLargestSize(clip:MovieClip):Point
	{
		var size:Rectangle = clip.getBounds(clip);
		
		var sizeX:Float = size.width;
		var sizeY:Float = size.height;
		
		for ( i in 1...clip.totalFrames + 1)
		{
			size = clip.getBounds(clip);
			
			if ( size.width > sizeX)
			sizeX = size.width;
			
			if ( size.height > sizeY)
			sizeY = size.height;
		}
		
		return new Point( sizeX, sizeY );
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
	
	static private function getClipSize(clip:MovieClip, size:ClipSize, originFrame:ReferenceFrame):Point
	{
		var p:Point;
		
		return p;
	}
	
}