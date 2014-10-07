package com.creativemage.tilesheet;
import com.creativemage.tilesheet.AnimatedBody;
import flash.display.BitmapData;
import openfl.display.Bitmap;
import openfl.display.Graphics;
import openfl.display.Tilesheet;
import openfl.errors.Error;
import openfl.geom.Matrix;
import openfl.geom.Point;
import openfl.geom.Rectangle;
import openfl.Lib;

/**
 * ...
 * @author Alex Kolpakov
 */

class EasyTilesheet
{
	private var inited:Bool = false;
	
	private var tileSheet:Tilesheet;
	
	private var drawOptions:Int = Tilesheet.TILE_SCALE | Tilesheet.TILE_ROTATION | Tilesheet.TILE_ALPHA;
	private var animations:Array<AnimatedBody> = [];
	private var drawList:Array<Float> = [];
	private var graphicsRef:Graphics;
	
	private var currentIndex:Int = 0;
	private var currentAnimation:AnimatedBody;
	
	private var bitmapDataAtlas:BitmapData;
	private var textureArray:Array<BitmapData> = [];
	private var tileRectArray:Array<Rectangle> = [];

	public function new(targetGraphicsObject:Graphics) 
	{
		graphicsRef = targetGraphicsObject;
	}
	// PRIVATE METHODS
	
	function provideBodyWithTextureSizes(item:AnimatedBody) 
	{
		if (item.animationArray == null || item.animationArray.length < 1)
		{
			throw new Error("Animation body has no animations registered");
			return;
		}
		
		for (ani in item.animationArray)
		{
			if (ani.frameCount == 0)
			{
				throw new Error("Animation has no frames added");
				continue;
			}
			
			for ( i in 0...ani.frameCount)
			{
				var frameIndex = ani.frameIndexes[i];
				var frameSizes = getTextureSize(frameIndex);
				
				
				if (item.width < frameSizes.x)
					item.width = frameSizes.x;
					
				if (item.height < frameSizes.y)
					item.height = frameSizes.y;
			}
		}
	}
	
	function getTextureSize(textureIndex:Int):Point
	{
		var targetTexture = textureArray[textureIndex];
		return new Point( targetTexture.width, targetTexture.height );
	}
	
	function renderAtlas() 
	{
		var atlasWidth:Int = 0;
		var atlasHeight:Int = 0;
		
		for (texture in textureArray)
		{
			if (texture.width > atlasWidth)
				atlasWidth = texture.width;
				
			atlasHeight += texture.height;
		}
		
		bitmapDataAtlas = new BitmapData(atlasWidth, atlasHeight, true, 0x00000000);
		
		var destPoint = new Point();
		var currentHeight:Int = 0;
		for (texture in textureArray)
		{
			destPoint.y = currentHeight;
			bitmapDataAtlas.copyPixels(texture, texture.rect, destPoint);
			
			currentHeight += texture.height;
			
			var rect:Rectangle = new Rectangle(destPoint.x, destPoint.y, texture.width, texture.height);
			tileRectArray.push(rect);
		}
	}
	
	function addTileRectangles() 
	{
		for (rect in tileRectArray)
			tileSheet.addTileRect(rect);
	}
	
	// PUBLIC METHODS
	
	public function init():Void
	{
		if (inited == true)
			return;
		inited = true;
		
		renderAtlas();
		tileSheet = new Tilesheet(bitmapDataAtlas);
		addTileRectangles();
		
		// no need to keep the rectangles or separated textures in memory anymore
		tileRectArray = null; 
		textureArray = null;
	}
	
	public function addAnimationBody(item:AnimatedBody):Void
	{
		// check if exists
		for (ani in animations)
		if (ani == item)
			return;
			
		provideBodyWithTextureSizes(item);
		
		animations.push(item);
	}
	
	public function removeAnimationBody(item:AnimatedBody):Void
	{
		animations.remove(item);
	}
	
	public function addTextureToAtlas(texture:BitmapData):Int
	{
		if (inited == true)
		{
			throw new Error("Cannot add textures after init()");
			return -1;
		}
		
		textureArray.push(texture);
		
		return textureArray.length - 1;
	}
	
	public function addTextureArrayToAtlas(textures:Array<BitmapData>):Array<Int>
	{
		if (inited == true)
		{
			throw new Error("Cannot add textures after init()");
			return [-1];
		}
		
		var indexArray:Array<Int> = [];
		
		for ( i in 0...textures.length)
		{
			textureArray.push(textures[i]);
			indexArray.push(textureArray.length - 1);
		}
		
		return indexArray;
	}
	
	public function clearAtlas():Void
	{
		bitmapDataAtlas = new BitmapData(0, 0);
	}
	
	public function update():Void
	{
		for (i in 0...animations.length)
		{
			currentAnimation = animations[i];
			currentAnimation.update();
			
			currentIndex = i * 6;
			
			drawList[currentIndex]     = currentAnimation.x;
			drawList[currentIndex + 1] = currentAnimation.y;
			drawList[currentIndex + 2] = currentAnimation.index;
			drawList[currentIndex + 3] = currentAnimation.scale;
			drawList[currentIndex + 4] = currentAnimation.rotation;
			drawList[currentIndex + 5] = currentAnimation.alpha;
		}
		
		graphicsRef.clear();
    	tileSheet.drawTiles(graphicsRef, drawList, true, drawOptions);
	}
	
	// GETTERS AND SETTERS
	public function getAtlasWidth():Int
	{
		if (bitmapDataAtlas == null)
			return 0;
		return Std.int(bitmapDataAtlas.width);
	}
	
	public function getAtlasHeight():Int
	{
		if (bitmapDataAtlas == null)
			return 0;
		return bitmapDataAtlas.height;
	}
	
}