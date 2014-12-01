package com.creativemage.tilesheet;
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
	private var textureDataArray:Array<TextureData> = [];
	private var textureSizeArray:Array<Point> = [];

	public function new(targetGraphicsObject:Graphics) 
	{
		graphicsRef = targetGraphicsObject;
	}
	// PRIVATE METHODS
	
	function provideBodyWithTextureSizes(item:AnimatedBody) 
	{
		for (animation in item.animationArray)
		{
			for ( i in 0...animation.frameCount)
			{
				var textureIndex = animation.frameIndexes[i];
				var textureSize = textureSizeArray[textureIndex];
				
				animation.frameSizes.push( textureSize );
			}
		}
	}
	
	function renderAtlas() 
	{
		var atlasWidth:Int = 0;
		var atlasHeight:Int = 0;
		
		for (textureData in textureDataArray)
		{
			if (textureData.texture.width > atlasWidth)
				atlasWidth = textureData.texture.width;
				
			atlasHeight += textureData.texture.height;
		}
		
		bitmapDataAtlas = new BitmapData(atlasWidth, atlasHeight, true, 0x00000000);
		
		var destPoint = new Point();
		var currentHeight:Int = 0;
		for (textureData in textureDataArray)
		{
			destPoint.y = currentHeight;
			bitmapDataAtlas.copyPixels(textureData.texture, textureData.texture.rect, destPoint);
			
			currentHeight += textureData.texture.height;
			
			var rect:Rectangle = new Rectangle(destPoint.x, destPoint.y, textureData.texture.width, textureData.texture.height);
			textureData.rect = rect;
		}
	}
	
	function addTileRectangles() 
	{
		for (textureData in textureDataArray)
			tileSheet.addTileRect(textureData.rect, textureData.rotationPoint);
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
		
		// no need to keep the separated textures in memory anymore
		for ( t in textureDataArray)
			t.texture.dispose();
		textureDataArray = null;
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
	
	public function addTextureToAtlas(texture:BitmapData, ?centerPoint:Point):Int
	{
		if (inited == true)
		{
			throw new Error("Cannot add textures after init()");
			return -1;
		}
		
		var textureData = new TextureData();
		textureData.texture = texture;
		textureData.rotationPoint = centerPoint;
		
		textureDataArray.push(textureData);
		textureSizeArray.push ( new Point( texture.width, texture.height ) );
		
		return textureDataArray.length - 1;
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

private class TextureData
{
	public var texture:BitmapData;
	public var rotationPoint:Point;
	public var rect:Rectangle;
	
	public function new()
	{
		
	}
}