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
	 * An email that comes stamped with a guid
	 */
	public class ChallengeEmail 
	{		
		
		public static var postURL:String = "http://web.scanplaygames.com/Prototypes/HangEm/ShareHangin.php";
		
		//sends an email stamped with a guid
		public static function SendChallengeEmail(_guid:String, _title:String = "Email Test", _message:String = "Email", _link:String = "Scanplaygames.com",_senderName:String = "Me", _sender_email:String = "support@scanplaygames.com", _recipient_email:String = "rexstjohn@gmail.com", _recipient_name:String = "Bob"):void
		{ 
			var request:URLRequest = new URLRequest(postURL);
			var variables:URLVariables = new URLVariables();
			
			// these depend on what names the script expects
			variables.recipient_email  = _recipient_email;
			variables.recipient_name   = _recipient_name;
			variables.sender_subject   = _title;
			variables.sender_message   = _message;
			variables.sender_email     = _sender_email;
			variables.sender_name      = _senderName;
			variables.included_link    = _link;
			variables.challenge_guid   = _guid;

			//stamp the session
			request.data = variables;
			
			// depends if the script uses POST or GET
			// adjust accordingly
			request.method = URLRequestMethod.POST;

			var urlLoader:URLLoader = new URLLoader();
			urlLoader.load(request);
		}
	}

}