package sample;
import com.creativemage.tilesheet.EasyTilesheet;
import src.com.creativemage.tilesheet.utils.BitmapDataLibrary;
import openfl.Assets;
import openfl.display.Sprite;

/**
 * ...
 * @author Alex Kolpakov
 */
class Sample extends Sprite
{
	private var tilesheet:EasyTilesheet;
	

	public function new() 
	{
		super();
		
		BitmapDataLibrary.addClip( Assets.getMovieClip("sample:Sample1"), "sample1" );
		
		
	}
	
}