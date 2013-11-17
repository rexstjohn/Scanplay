package com.core 
{
	import com.core.factory.AssetFactory;
	import com.core.factory.ScriptFactory;
	import com.core.user.UserData;
	import com.game.fx.WaveSplash;
	import com.game.ship.PirateShip;
	import com.game.ui.HowToPlay;
	import com.core.factory.SoundFactory;
	import com.game.ui.InGameMenu;
	import com.game.ui.LevelUI;
	import com.game.ui.UpgradeMenu;
	import com.menu.factory.MenuFactory;
	import com.menu.menu.SpeechScript;
	import flash.display.SpreadMethod;
	import flash.display.Sprite;
	import mochi.as3.MochiAd;
	import com.core.factory.LevelFactory;
	import com.giblet.LevelEditor;
	import flash.display.MovieClip;
	import mochi.as3.MochiEvents;
	import mochi.as3.*;
	/**
	 * ...
	 * @author ScanPlayGames
	 */
	public class GameController
	{
		//we only allow the user to get a free stream gift once
		private static var gifted:Boolean = false;
		
		public static function HandleEvent(command:String, target:* = null):void
		{
			trace("Button::" + command + " target::" + target);			
				
			switch(command)
			{
				case "ShowInterLevelInterstitial":
					Main.ClearStage();
					Main.ClearSprite();
					ShowInterLevelInterstitial(target);
					break;
				case "ReloadLastLevel":
					SoundFactory.PlaySound("InGameMusic",true,true);	
					SoundFactory.PlaySound("Sea",true,false, .2);	
					ObjectPool.CleanPool();
					GameLevel.destroy();
					Main.ClearStage();
					Main.ClearSprite();
					ObjectPool.RunGC();
					LevelFactory.LoadLevel(GameLevel.levelID);
					break;
				case "LoadNextLevel":	
					MochiEvents.trackEvent('Level Beaten');
					SoundFactory.PlaySound("InGameMusic",true,true);	
					SoundFactory.PlaySound("Sea",true,false, .2);	
					GameLevel.destroy();
					Main.ClearStage();
					Main.ClearSprite();		
					ObjectPool.CleanPool();
					ObjectPool.RunGC();		
					var next:int = GameLevel.levelID + 1;
					//load the end of game story if the player just beat episode 24
					switch(next)
					{
						case 21:
							MochiEvents.trackEvent('Episode 1 Finished');
							GameController.HandleEvent("LoadStoryFromGame", "episode_1_victory_1"); ﻿
							//MochiCoins.showItem({item: "668901f8d7b95713"});
							break;
						case 41:
							MochiEvents.trackEvent('Episode 2 Finished');
							GameController.HandleEvent("LoadStoryFromGame", "episode_2_victory_1");
							break;
						case 51:
							GameController.HandleEvent("LoadStoryFromGame", "episode_2_victory_1");
							break;
						case 10:
						case 19:
							Services.ShowInterLevelAd();
						case 3:
						case 16:
							GameController.HandleEvent("RequestFriendGift");
						default:
							MochiEvents.trackEvent("Level Completed", GameLevel.levelID);
							LoadNext(next);
							break;
					}
					break;
				case "LoadLevelFromMenu":
					//runs the gc, clears the background and makes  a  new menu
					SoundFactory.PlaySound("InGameMusic",true,true);	
					SoundFactory.PlaySound("Sea",true,false, .2);	
					Main.ClearStage();
					Main.ClearSprite();
					ObjectPool.RunGC();		
					LevelFactory.LoadLevel(target, true);
					break;
				case "LoadStore":
					Services.ShowStore();
					break;
				case "LoadStoryFromGame":
					//this one occurs when we exit a game into a story
					SoundFactory.PlaySound("InGameMusic",true,true);	
					SoundFactory.PlaySound("Sea",true,false, .2);	
				//	Main.ClearStage();
					Main.ClearSprite();
					ObjectPool.RunGC();
					trace("loading story..." + target);
					MenuFactory.LoadStory(target, true);		
					break;
				case "LoadStory":
					//stories are really just special forms of menus
					//where we want to make a note that a player has seen this already
					//so they won't be forced to see it again
					Main.ClearStage();
					Main.ClearSprite();
					ObjectPool.RunGC();
					trace("loading story.." + target);
					MenuFactory.LoadStory(target);						
					break;
				case "RunGC":
					ObjectPool.RunGC();
					break;
				case "LoadScript":
					SpeechScript.LoadScript(target);
					break;
				case "GameStart":
					MochiEvents.trackEvent('Game Started');
					MenuFactory.LoadMenu(target, true);
					SoundFactory.PlaySound("InGameMusic",true, true);	
					SoundFactory.PlaySound("Sea",true,false, .2);	
					break;
				case "LoadLevel":	
					Main.ClearStage();	
					Main.ClearSprite();
					ObjectPool.CleanPool();
					ObjectPool.RunGC();
					LevelFactory.LoadLevel(target);				
					break;
				case "LoadCustomLevel":
					SoundFactory.PlaySound("InGameMusic",true,true);	
					SoundFactory.PlaySound("Sea",true,false, .2);	
					LevelFactory.LoadCustomLevel();
					break;
				case "LoadMenu":
					Main.ClearStage();
					Main.ClearSprite();
					ObjectPool.RunGC();
					MenuFactory.LoadMenu(target);	
					break;
				case "LoadEditor":
					MochiEvents.trackEvent('Level Editor Loaded');
					MenuFactory.DestroyMenu(); //otherwise, the menu lurks with all its event listeners still firing in the background
					MenuFactory.DestroyMenuBackground(); //make sure this fucking thing is dead as a door nail. Bastard.
					Main.ClearStage();
					Main.ClearSprite();
					ObjectPool.RunGC();
					MenuFactory.destroy();
					LevelEditor.LoadEditor();
					break;
				case "ToggleSound":
					Settings.Mute();
					break;
				case "RequestFriendGift":	
					MochiEvents.trackEvent('Friend Gift Requested');
					//ask the user to post to stream in exchange for a gift
					MochiSocial.inviteFriends( {
						message: 'Come Play Get The Treasure - Ya Get A Free In-Game Item! YARRR',
						item: "13c0981dffcf82b3"
					} );
					UserData.UnlockAchievement("FriendlyPirate");
					break;
				case "FanPageAdd":		
					MochiEvents.trackEvent('Stream Post Requested');				
					MochiSocial.postToStream( {
						message: "Come Play Get The Treasure!"
					} );
					break;
				case "PostAchievementToStream":					
					MochiSocial.postToStream( {
						message: String("Arrr - I Unlocked An Achievement in 'Get The Treasure':" + target)
					} );
					break;
				case "LoadCustomLevel":
					MochiEvents.trackEvent('Custom Level Loaded');	
					MenuFactory.DestroyMenu(); //otherwise, the menu lurks with all its event listeners still firing in the background
					MenuFactory.DestroyMenuBackground(); //make sure this fucking thing is dead as a door nail. Bastard.
					Main.ClearStage();
					Main.ClearSprite();
					ObjectPool.RunGC();
					LevelFactory.LoadCustomLevel();
					break;
				case "ExitFromGameToMenu":
					SoundFactory.PlaySound("InGameMusic",true, true);	
					SoundFactory.PlaySound("Sea",true,false, .2);	
					ObjectPool.CleanPool();
					GameLevel.destroy();
					GameLevel.background.destroy();
					UserData.SetCurrentWeapon("Cannonball_Standard");
					Main.ClearStage();
					Main.ClearSprite();
					ObjectPool.RunGC();
					MenuFactory.LoadMenu(("main"), true);
					break;
				case "DestroyInGameMenu":
					InGameMenu.destroy();
					LevelUI.ShowUI();
					break;
				case "LoadMenuFromEditor":
					Main.ClearStage();
					Main.ClearSprite();
					ObjectPool.RunGC();				
					MenuFactory.LoadMenu("main", true);	
					break;
				case "SnapCameraToShip":
					Camera.SetPanLocked(false);
					Camera.FollowDefault();
					PirateShip.clickState = "idle";
					break;
				case "PanBackFromShot":
					Camera.SetPanLocked(false);
					Camera.PanToDefault();
					PirateShip.clickState = "panningback";
					break;					
				case "LoadNextSpeech":
					SpeechScript.LoadNextSpeech();
					break;
				case "LoadLastSpeech":
					SpeechScript.LoadLastSpeech();
					break;
				case "CloseSpeech":
					Camera.SetPanLocked(false);
					PirateShip.tutorialRunning = false;
					SpeechScript.Destroy();
					break;
				case "FlashLostFocus":
					//have to reset the ship when flash loses focus
					PirateShip.clickState = "idle";
					PirateShip.cannonReady = true;
					break;
				case "CloseUpgradeScreen":
					break;
			}
		}
					
		private static function LoadNext(next:int):void
		{
			LevelFactory.LoadLevel(next);						
		}
		
		private static function ShowInterLevelInterstitial(levelID:int):void
		{
			MochiAd.showInterLevelAd( { id:Services.Game_ID, clip:Main.ad_clip, ad_finished:destroyAnyContinue} );
			
			function destroyAnyContinue(e:* = null):void
			{
				LevelFactory.LoadLevel(levelID);
			}
		}
	}
}