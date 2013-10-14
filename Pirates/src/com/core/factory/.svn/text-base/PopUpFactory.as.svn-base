package com.core.factory 
{
	import com.game.ui.AchievementPop;
	import com.game.ui.PopUp;
	/**
	 * ...
	 * @author ScanPlayGames
	 */
	public class PopUpFactory
	{
		private static var popUps:Array;
		
		public function PopUpFactory() 
		{
			popUps = new Array();
		}
		
		public static function CreatePopUp(title:String, message:String):void
		{
			var p:PopUp = new PopUp(title, message);
		}
		
		public static function CreateAchievementPop(title:String, message:String):void
		{
			var p:AchievementPop = new AchievementPop("Achievement", title, message);			
		}
		
	}

}