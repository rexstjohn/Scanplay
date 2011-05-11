package com.photo 
{
	import com.buttons.BasicButton;
	import flash.display.SimpleButton;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.ProgressEvent;
	import flash.net.FileFilter;
	import flash.net.FileReference;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	import flash.text.TextField;
	
	/**
	 * ...
	 * @author ScanPlayGames
	 * 
	 * Upload a photo to an URL
	 */
	public class PhotoUploader
	{
		
		protected var uploadMsg:TextField = new TextField();
		protected var fileDisplay_txt:TextField = new TextField();
		protected var browse_btn:BasicButton = new BasicButton("Browse", 100, 100);
		protected var upload_btn:BasicButton = new BasicButton("Upload", 200, 100);
		
		public function PhotoUploader() 
		{
			uploadMsg.text = "Loaded";			
			fileDisplay_txt.text = "uploaded";
			
			Main.sprite.addChild(uploadMsg);
			Main.sprite.addChild(fileDisplay_txt);
			Main.sprite.addChild(browse_btn);
			Main.sprite.addChild(upload_btn);	
			
			//buttons
					
			
			// First thing is to set the flashing upload message clip to invisible 
			// Set the URL for the PHP uploader script
			var URLrequest:URLRequest = new URLRequest("http://www.[yoursite.com].com/uploader_script.php");
			// Assign the image types Filter
			var imageTypes:FileFilter = new FileFilter("Images (*.jpg, *.jpeg, *.gif, *.png)", "*.jpg; *.jpeg; *.gif; *.png");
			// Assign the document types filter
			var textTypes:FileFilter = new FileFilter("Text Files (*.txt, *.rtf)", "*.txt; *.rtf");
			// Add both filter types to an array
			var allTypes:Array = new Array(imageTypes, textTypes);
			// Set the FileReference name
			var fileRef:FileReference = new FileReference();
			
			// Add event listeners for its various fileRef functions below
			fileRef.addEventListener(Event.SELECT, syncVariables);
			fileRef.addEventListener(Event.COMPLETE, completeHandler);
			fileRef.addEventListener(ProgressEvent.PROGRESS, progressHandler);
			
			// Add event listeners for your 2 buttons
			browse_btn.addEventListener(MouseEvent.CLICK, browseBox);
			upload_btn.addEventListener(MouseEvent.CLICK, uploadVars);

			// Function that fires off when the user presses "browse for a file"
			function browseBox(event:MouseEvent):void 
			{
				fileRef.browse(allTypes);
			}
			// Function that fires off when the user presses the "upload it now" btn
			function uploadVars(event:MouseEvent):void 
			{
				uploadMsg.visible = true;
				fileRef.upload(URLrequest);
				upload_btn.visible = false;
			}
			// Function that fires off when File is selected from PC and Browse dialogue box closes
			function syncVariables(event:Event):void 
			{
				fileDisplay_txt.text = "" + fileRef.name;
			//	blocker.visible = false;
				upload_btn.visible = true;
				//progressBar.width = 2;
				var variables:URLVariables = new URLVariables();
				variables.todayDate = new Date();
				variables.Name = "Dude"; // This could be an input field variable like in my contact form tutorial : )
				variables.Email = "someDude@someEmail.com"; // This one the same
				URLrequest.method = URLRequestMethod.POST;
				URLrequest.data = variables;
			}
			// Function that fires off when upload is complete
			function completeHandler(event:Event):void 
			{
				uploadMsg.visible = false;
				//blocker.visible = true;
				//status_txt.text = fileRef.name + " has been uploaded.";
				fileDisplay_txt.text = "";
			}
			// Function that fires off when the upload progress begins
			function progressHandler(event:ProgressEvent):void 
			{
				// we want our progress bar to be 200 pixels wide when done growing so we use 200*
				// Set any width using that number, and the bar will be limited to that when done growing
				//progressBar.width = Math.ceil(200*(event.bytesLoaded/event.bytesTotal));
			}
		}
		
	}

}