package com.data.images 
{
	import Box2D.Dynamics.Joints.b2RevoluteJointDef;
	import com.data.images.encoders.JPGEncoder;
	import flash.display.Bitmap;
	import flash.errors.IOError;
	import flash.events.DataEvent;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.FileReference;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.net.URLRequestHeader;
	import flash.net.URLRequestMethod;
	import flash.utils.ByteArray;
	/**
	 * ...
	 * @author ScanPlayGames
	 * 
	 * Upload an image to a database
	 */
	public class ImageUploader
	{
		
		public static function UploadImage(_image:Bitmap, _imageName:String = "image", _url:String="http://web.scanplaygames.com/Prototypes/HangEm/UploadImage.php"):void
		{			
			// create a new JPEG byte array with the adobe JPEGEncoder Class;
			var byteArray : ByteArray = new JPGEncoder( m_imageQuality ).encode( _image.bitmapData );
			
			// create and store the image name;
			var m_finalImage:String = _imageName;
			var m_imageExtension:String = ".jpg";
			var m_outputPath:String = "images/";		
			var m_imageQuality : Number = 30;	
			
			// set up the request & headers for the image upload;
			var urlRequest : URLRequest = new URLRequest();
			urlRequest.url = _url + '?path=' + m_outputPath;
			urlRequest.contentType = 'multipart/form-data; boundary=' + UploadPostHelper.getBoundary();
			urlRequest.method = URLRequestMethod.POST;
			urlRequest.data = UploadPostHelper.getPostData( _imageName + '.jpg', byteArray );
			urlRequest.requestHeaders.push( new URLRequestHeader( 'Cache-Control', 'no-cache' ) );

			// create the image loader & send the image to the server;
			var urlLoader : URLLoader = new URLLoader();
			urlLoader.dataFormat = URLLoaderDataFormat.BINARY;		
			urlLoader.addEventListener(ProgressEvent.PROGRESS, OnProgress);
			urlLoader.addEventListener(Event.COMPLETE, OnComplete);
			urlLoader.load( urlRequest );
			
			function OnProgress( event:ProgressEvent ):void 
			{
				 var percent:Number = Math.round( event.bytesLoaded / event.bytesTotal * 100 );
				 trace("progress:: " +percent);
			}
			
			function OnComplete(e:Event):void
			{
				trace("image loaded");
			}
		}	
		
		private static function onImageCreationError ( e : * ) : void 
		{
			trace( 'error : ' + e );
		}
		
		
		private static function onImageCreated ( e : Event ) : void 
		{
			trace( 'image created : ' + e );
		} 
	}
}