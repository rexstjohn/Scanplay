package Lib.GameInterface 
{
	import flash.display.MorphShape;
	import flash.display.SimpleButton;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import Lib.GameEvent.*;
	import Lib.GameInterface.GameInterface;
	import Lib.Player.Player;
	import Lib.Achievement.Achievement;
	import Lib.GameObject;
	
	/**
	 * ...
	 * @author Rex
	 */
	public class Achievements extends GameInterface
	{
		public var achievements:Array;
		
		public var Hunter:Achievement;
		public var Killer:Achievement;
		public var Slayer:Achievement;
		public var Fiend:Achievement;
		public var GodLike:Achievement;
		
		public var CoinsLeft:TextField;
		public var TotalKills:TextField;
		public var BackToMap:SimpleButton;
		
		public function Achievements()
		{
			super(); 
			Name = "Achievements";		
		}
		
		public function init(p:Player):void 
		{
			player = p;	
			
			achievements = new Array();
			CoinsLeft.text = String(player.Coins);
			TotalKills.text = String(player.Kills);
			
			Hunter.init(150, 500);
			Killer.init(300, 1000);
			Slayer.init(600, 1500);
			Fiend.init(1000, 2000);
			GodLike.init(1500, 5000);
			
			//push to array
			achievements.push(Hunter);
			achievements.push(Killer);
			achievements.push(Slayer);
			achievements.push(Fiend);
			achievements.push(GodLike);
			
			//add the event listeners
			for (var a:int = 0; a < achievements.length; a++)
			{
				//add event listeners
				achievements[a].d.addEventListener("Update", handleAchievementUnlock);		
			}			
			
			addEventListener(MouseEvent.CLICK, onClick);
			player.d.addEventListener("Update", onPlayerUpdate);
		}
		
		public function onPlayerUpdate(e:GameEvent):void
		{
			CoinsLeft.text = String(player.Coins);
			TotalKills.text = String(player.Kills);
			
			switch(e.argument)
			{
				case "LoadGame":
					setAchievements();
					break;
			}
			
			function setAchievements():void
			{
				trace("Achievements::Setting Achievements After Load");
				for (var g:int = 0; g < achievements.length; g++)
				{
					for (var p:int = 0; p < player.achievements.length; p++)
					{
						if (achievements[g].Name == player.achievements[p])
						{
							player.achievements[p] = achievements[g];
							achievements[g].onUnlockAchievementSuccess();
						}
					}
				}
			}
		}
		
		public function onClick(e:MouseEvent):void
		{
			trace(e.target.name);
			sf.playSound("ClickSound");
			
			switch(e.target.name)
			{
				case "BackToMap":
					Update("LoadMap");
					break;
			}
		}
		public function handleAchievementUnlock(e:AchievementEvent):void
		{
			trace("handling unlock");
			e.achievement.alpha = 1;
			if (player.Kills >= e.achievement.Kills)
			{
				player.achievements.push(e.achievement);
				player.Coins += e.achievement.CoinReward;
				player.Update(null);
				e.achievement.onUnlockAchievementSuccess();
				Update("AutoSave"); //autosave the game
			}
			else
			{
				e.achievement.onUnlockAchievementFailure();
			}
		}		
	}
}