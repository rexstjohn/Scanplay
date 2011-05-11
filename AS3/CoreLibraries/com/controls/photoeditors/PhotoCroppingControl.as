package com.controls.photoeditors
{
	import com.buttons.BasicButton;
	import com.photo.PhotoCropper;
	import com.text.BasicText;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
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
	public class PhotoCroppingControl extends EventDispatcher
	{
		
		protected var uploadMessage:BasicText ;
		protected var fileNameDisplay:BasicText ;
		protected var browseButton:BasicButton;	
		protected var photoCropper:PhotoCropper;
		
		//the photo we have loaded
		protected var croppedPhoto:Bitmap;
		
		//stuff we use for loading
		protected var imageTypes:FileFilter;
		protected var textTypes:FileFilter;
		protected var allTypes:Array;
		
		//instructions
		protected var instructions:BasicText;
		
		public function PhotoCroppingControl() 
		{
			//create the basic accompanying objects
			fileNameDisplay = new BasicText("", 100, 50);			
			browseButton = new BasicButton("Choose Photo", 200, 100); 
			instructions = new BasicText("Drag the rectangle onto your subject's face",100, 30);
		
			//add to the stage
			Main.sprite.addChild(fileNameDisplay);
			Main.sprite.addChild(browseButton);	
			Main.sprite.addChild(instructions);
			
			browseButton.visible = false;
			fileNameDisplay.visible = false;
			instructions.visible = false;
			
			// First thing is to set the flashing upload message clip to invisible 
			// Set the URL for the PHP uploader script
			// Assign the image types Filter
			imageTypes = new FileFilter("Images (*.jpg, *.jpeg, *.gif, *.png)", "*.jpg; *.jpeg; *.gif; *.png");
			// Assign the document types filter
			textTypes = new FileFilter("Text Files (*.txt, *.rtf)", "*.txt; *.rtf");
			// Add both filter types to an array
			allTypes = new Array(imageTypes, textTypes);
			// Set the FileReference name
		}
		
		public function Reset():void
		{
			
		}
		
		public function Load():void
		{
			browseButton.visible    = true;
			fileNameDisplay.visible = true;
			
			var fileRef:FileReference = new FileReference();
			
			// Add event listeners for its various fileRef functions below
			fileRef.addEventListener(Event.SELECT, LoadFileReference);
			fileRef.addEventListener(Event.CANCEL, CancelAction);
			
			// Add event listeners for your 2 buttons
			browseButton.addEventListener(MouseEvent.CLICK, LoadBrowser);

			// Function that fires off when the user presses "browse for a file"
			function LoadBrowser(event:MouseEvent):void 
			{
				browseButton.removeEventListener(MouseEvent.CLICK, LoadBrowser);
				fileRef.browse(allTypes);
			}

			// Function that fires off when File is selected from PC and Browse dialogue box closes
			function LoadFileReference(event:Event):void 
			{
				browseButton.removeEventListener(MouseEvent.CLICK, LoadBrowser);
				fileRef.removeEventListener(Event.SELECT, LoadFileReference);
				fileNameDisplay.text = "" + fileRef.name;
				fileRef.addEventListener(Event.COMPLETE, onFileLoadComplete);
				fileRef.load();
			}
			
			function CancelAction(e:Event):void
			{
				browseButton.removeEventListener(MouseEvent.CLICK, LoadBrowser);
				dispatchEvent(new Event(Event.CANCEL));
				fileRef.removeEventListener(Event.SELECT, LoadFileReference);
				Destroy();			
			}
			
			function onFileLoadComplete(e:Event):void
			{								
				instructions.visible = true;
				fileRef.removeEventListener(Event.COMPLETE, onFileLoadComplete);
			    browseButton.visible = false;
				
				var data:ByteArray = fileRef.data;
				var loader:Loader = new Loader();
				loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onImageLoadComplete);
				loader.loadBytes(data);
				
				//load the image from the file reference we have been given
				function onImageLoadComplete(e:Event):void
				{
					loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, onImageLoadComplete);
					var newPhoto:Bitmap = new Bitmap((e.target.content).bitmapData);
					
					photoCropper = new PhotoCropper(newPhoto);
					Main.sprite.addChild(photoCropper);
					fileRef = null;
					photoCropper.d.addEventListener("PhotoCropped", OnPhotoCropped);
				}				
			}
			
		}
		
		public function Destroy():void
		{			
			photoCropper.Destroy();
			photoCropper = null;
			browseButton.visible = false;
			fileNameDisplay.visible = false;
			instructions.visible = false;
		}		
		
		public function OnPhotoCropped(e:Event):void
		{
			instructions.visible = false;
			photoCropper.d.removeEventListener("PhotoCropped", OnPhotoCropped);
			croppedPhoto = photoCropper.GetCroppedImage();
			
			browseButton.visible = false;
			fileNameDisplay.visible = false;
			
			var k:Event = new Event(Event.COMPLETE);
			//d.dispatchEvent(k);
			dispatchEvent(k);
		}
		
		public function GetImage():Bitmap
		{
			return croppedPhoto;
		}		
	}
}