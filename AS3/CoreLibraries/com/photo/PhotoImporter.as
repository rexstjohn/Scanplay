package com.photo 
{
	import com.buttons.BasicButton;
	import com.text.BasicText;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	import flash.events.ProgressEvent;
	import flash.net.FileFilter;
	import flash.net.FileReference;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	import flash.text.TextField;
	import flash.utils.ByteArray;
	/**
	 * ...
	 * @author ScanPlayGames
	 * 
	 * Allow the user to browse and import an image into flash from their desktop
	 * 
	 * This does not upload it
	 */
	public class PhotoImporter extends EventDispatcher
	{
		protected var uploadMessage:BasicText ;
		protected var fileNameDisplay:BasicText ;
		protected var browseButton:BasicButton;	
		protected var photoMC:MovieClip;
		protected var photoBMP:Bitmap;
		protected var parentSprite:Sprite;
		
		public function PhotoImporter(_parent:Sprite, _x:Number, _y:Number) 
		{
			parentSprite = _parent;
			fileNameDisplay = new BasicText("", 100, 50);			
			browseButton = new BasicButton("Choose Photo", _x, _y); 
			
			parentSprite.addChild(fileNameDisplay);
			parentSprite.addChild(browseButton);	
			
			// First thing is to set the flashing upload message clip to invisible 
			// Set the URL for the PHP uploader script
			// Assign the image types Filter
			var imageTypes:FileFilter = new FileFilter("Images (*.jpg, *.jpeg, *.gif, *.png)", "*.jpg; *.jpeg; *.gif; *.png");
			// Assign the document types filter
			var textTypes:FileFilter = new FileFilter("Text Files (*.txt, *.rtf)", "*.txt; *.rtf");
			// Add both filter types to an array
			var allTypes:Array = new Array(imageTypes, textTypes);
			// Set the FileReference name
			var fileRef:FileReference = new FileReference();
			
			// Add event listeners for its various fileRef functions below
			fileRef.addEventListener(Event.SELECT, LoadFileReference);
			
			// Add event listeners for your 2 buttons
			browseButton.addEventListener(MouseEvent.CLICK, LoadBrowser);

			// Function that fires off when the user presses "browse for a file"
			function LoadBrowser(event:MouseEvent):void 
			{
				fileRef.browse(allTypes);
			}

			// Function that fires off when File is selected from PC and Browse dialogue box closes
			function LoadFileReference(event:Event):void 
			{
				fileNameDisplay.text = "" + fileRef.name;
				fileRef.addEventListener(Event.COMPLETE, onFileLoadComplete);
				fileRef.load();
			}
			
			function onFileLoadComplete(e:Event):void
			{				
				var data:ByteArray = fileRef.data;
				var loader:Loader = new Loader();
				loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onImageLoadComplete);
				loader.loadBytes(data);
				
				//load the image from the file reference we have been given
				function onImageLoadComplete(e:Event):void
				{
					loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, onImageLoadComplete);
					photoBMP = new Bitmap((e.target.content).bitmapData);
					fileRef = null;
					dispatchEvent(new Event(Event.COMPLETE));
				}				
			}
		}
		
		public function GetPhoto():Bitmap
		{
			return photoBMP;
		}
		
	}

}