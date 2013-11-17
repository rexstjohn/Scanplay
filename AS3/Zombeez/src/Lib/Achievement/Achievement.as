package Lib.Achievement 
{
	import flash.display.SimpleButton;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import Lib.GameEvent.AchievementEvent;
	import Lib.GameObject;
	import mochi.as3.*;
	
	/**
	 * ...
	 * @author Rex
	 */
	public class Achievement extends GameObject
	{
		public var Kills:int;
		public var CoinReward:int;
		
		//textfields
		public var Reward:TextField;
		public var Title:TextField;
		public var Message:TextField;
		public var KillsNeeded:TextField;
		
		public function Achievement() 
		{
			super("Achievement");
		}
		
		public function init(killsNeeded:int, reward:int):void 
		{			
			Name = name;			
			Kills = killsNeeded;
			CoinReward = reward;
			
			buttonMode = true;
			mouseChildren = false;		
			
			KillsNeeded.text = String(killsNeeded);			
			Title.text = Name;			
			Message.text = "Locked";
			Reward.text = String(reward);
			
			alpha = .5;
			gotoAndStop(Name + "Frame");
			
			addEventListener(MouseEvent.CLICK, onClick);
			addEventListener(MouseEvent.MOUSE_OVER, onOver);
			addEventListener(MouseEvent.MOUSE_OUT, onOut);
		}		
		
		public function onClick(e:MouseEvent):void
		{
			trace("Achievement::" + Name + "::Click");
			Update("UnlockAchievement");				
		}	
		
		public function onUnlockAchievementSuccess():void
		{
			sf.playSound("CoinSound");
			alpha = 1;
			mouseEnabled = false;
			Message.text = "Unlocked!";
			sf.playSound("CoinSound");
			removeEventListener(MouseEvent.CLICK, onClick);
			removeEventListener(MouseEvent.MOUSE_OVER, onOver);
			removeEventListener(MouseEvent.MOUSE_OUT, onOut);
			mochi.as3.MochiEvents.trackEvent('AchievementUnlocked'); //track a game completion
		}	
		
		public function onUnlockAchievementFailure():void
		{			
			Message.text = "Not Enough Kills!";
			sf.playSound("FailSound");			
		}	
		
		public function onOver(e:MouseEvent):void
		{
			Message.text = "Click To Unlock";
			glowRed();
			alpha = 1;
		}
		
		public function onOut(e:MouseEvent):void
		{
			Message.text = "Locked";
			filters = [];
			alpha = .5;
		}
		
		public function Update(c:String):void
		{
			var g:AchievementEvent = new AchievementEvent(c, this);
			d.dispatchEvent(g);
		}
	}

}