package Lib.GameInterface 
{
	import flash.display.*;
	import flash.events.*;
	import flash.text.TextField;
	import Lib.GameEvent.*;
	import Lib.GameInterface.GameInterface;
	import Lib.Level.Level;
	import Lib.Player.Player;
	import Lib.SlotMachine.SlotMachine;
	import Lib.Sound.SoundFactory;
	import Lib.SoundToggle.SoundToggle;
    import flash.net.*;
	
	/**
	 * ...
	 * @author Rex
	 */
	public class Map extends GameInterface
	{
		public var levels:Array;
		
		public var Level1:Level;
		public var Level2:Level;
		public var Level3:Level;
		public var Level4:Level;
		public var Level5:Level;
		public var Level6:Level;
		public var Level7:Level;
		public var Level8:Level;
		public var Level9:Level;
		public var Level10:Level;
		public var Level11:Level;
		
		public var CoinsLeft:TextField;
		
		//interactive objects
		public var saveGame:SimpleButton;
		public var achievements:SimpleButton;
		public var toggleSound:SoundToggle;
		public var erniesWeaponShop:SimpleButton;
		public var LevelProgress:MovieClip;
		public var instructions:SimpleButton;
		public var LoadSlotMachine:SimpleButton;
		public var LoadCredits:SimpleButton;		
		public var TakeSurvey:SimpleButton;
		public var PointArrow:MovieClip;
		
		//the slot machine
		public var Slots:SlotMachine;
		
		//ernie's guide
		public var ErnieGuide:MovieClip;
		
		//credits
		public var Credits:MovieClip;
		
		public function Map()
		{
			super(); 
		}
		
		public function init(p:Player):void
		{
			p:Player;
			player = p;
			Name = "Map";
			
			ErnieGuide.stop();
			Credits.stop();
			
			Slots.visible = false;
			Credits.visible = false;
			
			levels = new Array();
			CoinsLeft.text = String(player.Coins);
			
			//create the levels
			Level1.init(15, "SnarBux", 0);
			Level2.init(25, "SnarBux", 1);
			Level3.init(30, "SnarBux", 2);
			Level4.init(35, "Restroom", 2);
			Level5.init(40, "Restroom", 3);
			Level6.init(44, "Restroom", 3);
			Level7.init(44, "MallBridge", 4);
			Level8.init(48, "MallBridge", 4);
			Level9.init(48, "MallBridge", 5);
			Level10.init(50, "Sewer1", 6);
			Level11.init(55, "Sewer2", 7);
			
			//push to the array
			levels.push(Level1);
			levels.push(Level2);
			levels.push(Level3);
			levels.push(Level4);
			levels.push(Level5);
			levels.push(Level6);
			levels.push(Level7);
			levels.push(Level8);
			levels.push(Level9);
			levels.push(Level10);
			levels.push(Level11);
			
			//add event listeners
			for (var g:int = 0; g < levels.length; g++)
			{
				levels[g].d.addEventListener("Update", handleLevelLoad);
				
				if (player.LevelsBeaten >= levels[g].levelNumber)
				{
					levels[g].visible = true;
				}
				else
				{
					levels[g].visible = false;
				}
			}
			
			addEventListener(MouseEvent.CLICK, onClick);
			LevelProgress.addEventListener(Event.ENTER_FRAME, onEnter);
			player.d.addEventListener("Update", onPlayerUpdate);
		}
		
		public function onPlayerUpdate(e:GameEvent):void
		{
			trace("Map::PlayerUpdate::" + e.argument);
			CoinsLeft.text = String(player.Coins);
			
			switch(e.argument)
			{
				case "LevelBeaten":
					PointArrow.visible = false;
					if (player.LevelsBeaten <= 11)
					{
						unlockLevel(player.LevelsBeaten);
						LevelProgress.play();
						LevelProgress.gotoAndPlay(1);
					}
					break;
				case "UpdateHi5Coins":
					Slots.CoinsLeft.text = String(player.Coins);
					break;
				case "LoadGame":
					//make the start arrow invisible
					PointArrow.visible = false;
				
					//load the level progress and maps
					for (var g:* in levels)
					{
						if (levels[g].levelNumber <= (player.LevelsBeaten + 1))
						{							
							unlockLevel(g);
						}
						
						if (levels[g].levelNumber > (player.LevelsBeaten + 1))
						{
							lockLevel(g);
						}
						
						if ((player.LevelsBeaten >= 10))
						{
							unlockLevel(11);
						}
						else
						{
							lockLevel(11);
						}
					}
					LevelProgress.play();
					LevelProgress.gotoAndPlay(1);
					break;
			}
		}
		
		public function lockLevel(levelNum:int):void
		{
			for (var g:* in levels)
			{
				if (levels[g].levelNumber == levelNum)
				{
					levels[g].visible = false;
					levels[g].gotoAndStop(1);
				}
			}
		}
		
		public function unlockLevel(levelNum:int):void
		{
			for (var g:* in levels)
			{
				if (levels[g].levelNumber == levelNum)
				{
					levels[g].visible = true;
					levels[g].gotoAndPlay(1);
				}
			}
		}
		
		public function onEnter(e:Event):void
		{
			if ((LevelProgress.currentLabel ==  "Level" + (player.LevelsBeaten )))
			{
				LevelProgress.stop();				
			}
			
			if (LevelProgress.currentFrame == LevelProgress.totalFrames)
			{
				LevelProgress.stop();
			}
		}
		
		public function onClick(e:MouseEvent):void
		{
			trace(e.target.name);
			switch(e.target.name)
			{
				case "erniesWeaponShop":
					sf.playSound("ClickSound");
					Update("LoadErnies");
					break;
				case "achievements":
					sf.playSound("ClickSound");
					Update("LoadAchievements")
					break;
				case "saveGame":
					sf.playSound("ClickSound");
					Update("LoadSaveGame")
					break;
				case "instructions":
					sf.playSound("ClickSound");
					Update("LoadInstructions");
					break;
				case "ExitChat":
					sf.playSound("ClickSound");
					ErnieGuide.visible = false;
					break;
				case "NextButton":
					sf.playSound("ClickSound");
					ErnieGuide.gotoAndStop(ErnieGuide.currentFrame + 1);
					break;
				case "LoadSlotMachine":
					sf.playSound("ClickSound");
					Slots.visible = true;
					Slots.init(player);
					break;
				case "CloseSlotMachine":
					sf.playSound("ClickSound");
					Slots.visible = false;
					Slots.reset();
					break;
				case "LoadCredits":
					sf.playSound("ClickSound");
					//sf.playSound("ProjectorSound");
					Credits.gotoAndPlay(1);
					Credits.visible = true;
					break;
				case "CloseCredits":
					sf.playSound("ClickSound");
					Credits.visible = false;
					Credits.gotoAndStop(1);
					break;
				case "TakeSurvey":					
					navigateToURL(new URLRequest("http://spreadsheets.google.com/viewform?hl=en&formkey=dEJLZHFLR0xlZW9JTmpNMTBHYWwtbFE6MA"));
					break;
				default:
					break;
			}
		}
		
		public function handleLevelLoad(e:LevelEvent):void
		{
			player.currentLevel = e.level;
			sf.playSound("ClickSound");
			Update("LoadLevel");
		}		
	}

}