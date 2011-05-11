package com.photo.coloraverager
{
	import com.graphics.Square;
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.filters.ColorMatrixFilter;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	/**
	 * ...
	 * @author ScanPlayGames
	 */
	public class PhotoPixelator
	{
		private static var grid:Array;
		private static var sourceClip:MovieClip;
		private static var sourceBMP:Bitmap;
		
		//image vars
		private static var imageWidth:Number;
		private static var imageHeight:Number;		
		
		//how large the grid and height squares are
		private static var gridWidth:Number = 20;
		private static var gridHeight:Number = 20;
		
		//x and y offsets
		private static var xOffset:Number;
		private static var yOffset:Number;
		
		public static function PixelatePhotoToGrid(_x:Number, _y:Number,b:Bitmap, _parent:Sprite):Array 
		{
			sourceBMP  = b;
			grid   = new Array();
			
			xOffset = _x;
			yOffset = _y;
			
			imageWidth = sourceBMP.width;
			imageHeight = sourceBMP.height;	
			
			var imageWidthSquare:Number = imageWidth / gridWidth;
			var imageWidthHeight:Number = imageHeight / gridHeight;
			
			//populate the grid with empty squares			
			for (var g:int = 0; g < gridWidth; g++)
			{
				grid.push(new Array());
				
				for(var k:int = 0; k < gridHeight; k++)
				{
					grid[g][k] = new PhotoSquare(imageWidthSquare, imageWidthHeight);
					_parent.addChild(grid[g][k]);
				}
			}
			
			Distribute(); //arrange the squares into a grid
			SliceBitmapToGrid(); //slice the source image into the squares
			AverageColors(); //average the colors of all the slices
			
			return grid;			
		}
		
		//slices up the bitmap and copies the corresponding picels to the grid pieces
		protected static function SliceBitmapToGrid():void
		{
			var rows:int;
			var cols:int;
			var rowCount:int = 0;
			var colCount:int = 0;
			var rect:Rectangle = new Rectangle();
			
			for (var g:int = 0; g < gridWidth; g++)
			{				
				for(var k:int = 0; k < gridHeight; k++)
				{					
					if ((rowCount % gridWidth) == 0)
					{
						rowCount = 0;
						colCount++;
					}
					rect.x =       rowCount * grid[g][k].width;
					rect.y =      (colCount * grid[g][k].height) -grid[g][k].height;
					rect.width =   grid[g][k].width;
					rect.height = ( grid[g][k].height);
					rowCount++;
					
					//copy a slice of the bitmap onto the corrosponding square bit
					PhotoSquare(grid[g][k]).bitmap.bitmapData.copyPixels(sourceBMP.bitmapData, rect,new Point(0, 0));
					
				}
			}
		}
		
		//slices up the bitmap and copies the corresponding picels to the grid pieces
		protected static  function AverageColors():void
		{
			
			for (var g:int = 0; g < gridWidth; g++)
			{				
				for(var k:int = 0; k < gridHeight; k++)
				{					
					grid[g][k].AverageColorFill();
				}
			}
		}
		
		//distributes the squares correctly
		protected static  function Distribute():void
		{			
			var rows:int;
			var cols:int;
			var rowCount:int = 0;
			var colCount:int = 0;
			
			for (var g:int = 0; g < gridWidth; g++)
			{
				for(var k:int = 0; k < gridHeight; k++)
				{
					
					if ((rowCount % gridWidth) == 0)
					{
						rowCount = 0;
						colCount++;
					}
					
					grid[g][k].x = xOffset+ ( rowCount * grid[g][k].width);
					grid[g][k].y = yOffset + ((colCount * grid[g][k].height) -grid[g][k].height );
					rowCount++;
				}
			}
		}
		
		//converts an image to grayscale
		protected static  function ConvertToGrayScale(image:DisplayObject):void
		{
			var matrix:Array = [0.3, 0.59, 0.11, 0, 0,
							    0.3, 0.59, 0.11, 0, 0,
							    0.3, 0.59, 0.11, 0, 0,
							    0, 0, 0, 1, 0];
							
			var grayscaleFilter:ColorMatrixFilter = new ColorMatrixFilter(matrix);
			image.filters = [grayscaleFilter];
		}
		
		protected static  function SubDivide():void
		{
			
		}
		
		protected static  function SetColor():void
		{}
		
	}

}