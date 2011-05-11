package com.email 
{
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	import flash.net.navigateToURL;
	/**
	 * ...
	 * @author ScanPlayGames
	 * 
	 * This works together with the "Send Email From Flash" PHP to send an email
	 * to someone
	 */
	public class Email
	{		
		public static var postURL:String = "http://web.scanplaygames.com/Prototypes/HangEm/ShareHangin.php";
		
		public static function SendEmail(_title:String = "Email Test", _message:String = "Email", _link:String = null,_senderName:String = "Me", _sender_email:String = "support@scanplaygames.com", _recipient_email:String = "rexstjohn@gmail.com", _recipient_name:String = "Bob"):void
		{ 
			var request:URLRequest = new URLRequest(postURL);
			var variables:URLVariables = new URLVariables();
			
			// these depend on what names the script expects
			variables.recipient_mail   = _recipient_email;
			variables.recipient_name   = _recipient_name;
			variables.sender_subject   = _title;
			variables.sender_message   = _message;
			variables.sender_mail      = _sender_email;
			variables.sender_name      = _senderName;
			
			//other optionals;
			variables.included_link     = _link;

			request.data = variables;
			
			// depends if the script uses POST or GET
			// adjust accordingly
			request.method = URLRequestMethod.POST;

			var urlLoader:URLLoader = new URLLoader();
			urlLoader.load(request);
		}
		
		
		public static function MailTo():void
		{

			 var request:URLRequest = new URLRequest("mailto:rexstjohn@gmail.com"+"?subject=Subject"+"&body= Hello world ");
			  navigateToURL(request, "_blank"); 
			  request.method = URLRequestMethod.POST;
		}
		
	}

}