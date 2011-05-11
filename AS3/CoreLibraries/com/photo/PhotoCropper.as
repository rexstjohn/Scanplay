package com.photo 
{
	import Box2D.Dynamics.Joints.b2RevoluteJointDef;
	import com.buttons.BasicButton;
	import com.controls.input.Slider;
	import com.data.images.ImageScaler;
	import com.graphics.Square;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.ui.Keyboard;
	/**
	 * ...
	 * @author ScanPlayGames
	 * 
	 * Allow the user to crop an image, specifically for cropping someone's head out of an image
	 */
	public class PhotoCropper extends Sprite
	{
		[Embed(source='Library.swf', symbol='FaceEgg')]
		private var art:Class;//the egg mask we use for the face
		
		protected var backing:Square;
		private var sourcePhoto:Bitmap;
		
		//cropping details
		private var selectionRectangle:Square;
		protected var cropRectangle:Rectangle;
		
		//save button
		private var saveButton:BasicButton;
		protected var croppedImage:Bitmap; //the resulting image
		
		//event
		public var d:EventDispatcher;
		
		//ratios
		private var photoRatio:Number;
		private var originalHeight:Number;
		private var originalWidth:Number;
		private var widthShrink:Number;
		private var heightShrink:Number;
		
		//zoom slider
		protected var zoomSlider:Slider;
		
		public function PhotoCropper(_source:Bitmap,_x:Number = 150, _y:Number = 150) 
		{
			//set x and y
			x = _x;
			y = _y;
			
			d = new EventDispatcher();
			
			//create a backing square
			backing = new Square(50, 50, 300, 300, 0x000000);
			backing.alpha = .4;
			addChild(backing);
			backing.x = 0;
			backing.y = 0;
			backing.mouseChildren = false;
			
			//get the source photo, scale it, add it to the sprite
			sourcePhoto         = _source;
			
			//shrink the photo based on it's proportions
			if (sourcePhoto.width >= sourcePhoto.height)
			{
				photoRatio          =  sourcePhoto.height / sourcePhoto.width;
				originalHeight      = sourcePhoto.height;
				originalWidth       = sourcePhoto.width;
				sourcePhoto.width   = 300;
				sourcePhoto.height  = 300 * photoRatio;			

				widthShrink         = originalWidth / 300;
				heightShrink        = originalHeight / sourcePhoto.height;
			}
			else
			{
				photoRatio          =   sourcePhoto.width /sourcePhoto.height;
				originalHeight      = sourcePhoto.height;
				originalWidth       = sourcePhoto.width;
				sourcePhoto.width   = 300 * photoRatio;
				sourcePhoto.height  = 300 ;			

				widthShrink         = originalWidth / sourcePhoto.width;
				heightShrink        = originalHeight / 300;				
			}
			
			addChild(_source);
			backing.height      = sourcePhoto.height;
			sourcePhoto.x       = 0;
			sourcePhoto.y       =0;
			
			//create a button for saving the resulting photo crop
			saveButton = new BasicButton("Save", 100, 50);
			saveButton.mouseChildren  = true;
			saveButton.scaleX = saveButton.scaleY = 3;
			saveButton.x = x + (saveButton.width / 2);
			saveButton.y = y + height + 15;
			Main.sprite.addChild(saveButton);
			
			//create  a face / area selection rectangle
			selectionRectangle = new Square(0, 0, 60, 100);
			selectionRectangle.alpha = .5;
			selectionRectangle.buttonMode = true;
			addChild(selectionRectangle);			
			selectionRectangle.x = x + selectionRectangle.width;
			selectionRectangle.y = y ;
			
			//create the face eff
			var egg:MovieClip = MovieClip(new art());
			egg.width = selectionRectangle.width;
			egg.height = selectionRectangle.height;
			selectionRectangle.addChild(egg);
			selectionRectangle.mask = egg;
			
			//create a zoom slider
			zoomSlider = new Slider(50, 100);
			zoomSlider.Load(this);
			
			selectionRectangle.addEventListener(MouseEvent.MOUSE_DOWN, HandleDown);
			selectionRectangle.addEventListener(MouseEvent.MOUSE_UP, HandleUp);
			selectionRectangle.addEventListener(MouseEvent.MOUSE_MOVE, HandleMove);
			backing.addEventListener(MouseEvent.MOUSE_OUT, HandleOut);
			saveButton.addEventListener(MouseEvent.CLICK, HandleClick);
			
			//scale the image in and out
			Main.GetStage().addEventListener(KeyboardEvent.KEY_DOWN, HandleKeyDown);
			Main.GetStage().addEventListener(KeyboardEvent.KEY_UP, HandleKeyUp);
		}
		
		protected function HandleKeyDown(e:KeyboardEvent):void
		{
			switch(e.keyCode)
			{
				case Keyboard.UP:
					selectionRectangle.scaleX = selectionRectangle.scaleY += .1;
					break;
				case Keyboard.DOWN:
					selectionRectangle.scaleX = selectionRectangle.scaleY -= .1;
					break;				
				default:
					break; 			
			}
		}
		
		protected function HandleKeyUp(e:KeyboardEvent):void
		{			
			switch(e.keyCode)
			{default:break; }
		}
		
		//crop the image, close this control
		protected function HandleClick(e:MouseEvent):void
		{
			croppedImage            = new Bitmap();
			cropRectangle           = new Rectangle(selectionRectangle.x  - (selectionRectangle.x * ( 1-widthShrink)), selectionRectangle.y- (selectionRectangle.y * ( 1-heightShrink)), selectionRectangle.width* ( widthShrink), selectionRectangle.height* (heightShrink));
			croppedImage.bitmapData = new BitmapData(selectionRectangle.width* ( widthShrink), selectionRectangle.height *heightShrink);
			croppedImage.bitmapData.copyPixels(sourcePhoto.bitmapData, cropRectangle, new Point());
			visible                 = false;
			saveButton.visible      = false;
			
			var k:Event             = new Event("PhotoCropped");
			d.dispatchEvent(k);
		}		
		
		public function GetCroppedImage(_scale:Boolean = true):Bitmap
		{
			//scale the image permanently as required
			if(!_scale)
			return croppedImage;
			else
			return ImageScaler.ScaleBitmap(croppedImage, 60, 100);
		}
		
		protected function HandleMove(e:MouseEvent):void
		{
			croppedImage            = new Bitmap();
			cropRectangle           = new Rectangle(selectionRectangle.x  - (selectionRectangle.x * ( 1-widthShrink)), selectionRectangle.y- (selectionRectangle.y * ( 1-heightShrink)), selectionRectangle.width* ( widthShrink), selectionRectangle.height* (heightShrink));
			croppedImage.bitmapData = new BitmapData(selectionRectangle.width* ( widthShrink), selectionRectangle.height *heightShrink);
			croppedImage.bitmapData.copyPixels(sourcePhoto.bitmapData, cropRectangle, new Point());
			
			//set the zoom
			//selectionRectangle.scaleX = selectionRectangle.scaleY = zoomSlider.GetPercentage();
		}
		
		public function Destroy():void
		{			
			selectionRectangle.removeEventListener(MouseEvent.MOUSE_DOWN, HandleDown);
			selectionRectangle.removeEventListener(MouseEvent.MOUSE_UP, HandleUp);
			selectionRectangle.removeEventListener(MouseEvent.MOUSE_MOVE, HandleMove);
			backing.removeEventListener(MouseEvent.MOUSE_OUT, HandleOut);
			saveButton.removeEventListener(MouseEvent.CLICK, HandleClick);
			
			//scale the image in and out
			Main.GetStage().removeEventListener(KeyboardEvent.KEY_DOWN, HandleKeyDown);
			Main.GetStage().removeEventListener(KeyboardEvent.KEY_UP, HandleKeyUp);
			
			saveButton = null;
			selectionRectangle = null;
		}
		
		protected function HandleOut(e:MouseEvent):void
		{
			selectionRectangle.stopDrag();
		}
		
		protected function HandleDown(e:MouseEvent):void
		{
			selectionRectangle.startDrag();
		}
		
		protected function HandleUp(e:MouseEvent):void
		{
			selectionRectangle.stopDrag();
		}
	}

}