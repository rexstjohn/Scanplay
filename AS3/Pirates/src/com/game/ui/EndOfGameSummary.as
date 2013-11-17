package com.game.ui 
{
	
	import com.core.*;
	import com.core.factory.*;
	import com.core.user.UserData;
	import com.core.util.*;
	import com.game.blocks.crates.*;
	import com.game.fx.*;
	import com.menu.menu.*;
	import com.menu.text.*;
	import flash.display.*;
	import flash.events.*;
	import flash.geom.*;
	import flash.text.*;
	import mochi.as3.*;
	
	/**
	 * ...
	 * @author ScanPlayGames
	 * 
	 * A summary that appears after the levle letting you know how you did.
	 * 
	 * Three use cases. player wins under shots fired. Player wins and gets the skull. Player loses and has to replay.
	 */
	public class EndOfGameSummary 
	{
		private static var popup:Sprite;
		private static var SkullAndBones:Sprite;
		private static var Score:TextField;
		private static var Message:TextField;
		private static var Title:TextField;
		private static var coin:Sprite;
		private static var treasureEarned:TextField;
		
		//buttons;
		private static var TryAgain:Button;
		private static var NextLevel:Button;
		
		//score
		private static var levelScore:TextField;
		
		//level stats
		private static var levelWon:Boolean;
		
		//bones
		private static var bones:Array; //three bones
		
		public function EndOfGameSummary(_leveWon:Boolean, _score:int, _totalPoints:int, _nonAdjustedScore:int) 
		{
			super();
			levelWon = _leveWon;
			popup = AssetFactory.GetSprite("PopUp");			
			
			//skull and bones
			SkullAndBones = AssetFactory.GetSprite("TreasureChest");
			MovieClip(MovieClip(SkullAndBones).getChildAt(0)).gotoAndStop(13);
			SkullAndBones.y = 310;
			SkullAndBones.x = Main.m_stage.stageWidth / 2;	
			SkullAndBones.scaleX = SkullAndBones.scaleY = 1.3;			
			AssetFactory.AddInnerShadow(SkullAndBones);
			
			//add the stuff to the stage
			Main.m_stage.addChild(popup);		
			Main.m_stage.addChild(SkullAndBones);			
			Camera.SetPanLocked(true);			
			
			//create the buttons
			TryAgain = new Button(new Point(300, 260), "Replay Level",String(GameLevel.levelID), "ReloadLastLevel", "MenuBlockRectangle", false);
			NextLevel = new Button(new Point(400, 260), "Next Level",String( GameLevel.levelID), "LoadNextLevel", "MenuBlockRectangle", false);
			
			TryAgain.hide();
			NextLevel.hide();			
			
			if (levelWon)
			SoundFactory.PlaySound("WinMusic", false, true);
			else
			SoundFactory.PlaySound("LoseMusic", false, true);			
			
			SoundFactory.PlaySound("Sea",true,false, .2);	
			
			/*
			 * 
			 * If the player won, they get a nice message. IF they won
			 * and beat par, they get the message and a skull and bones.
			 */ 
			
			var message:String;
			var title:String;			
			
			
			//set the par details			
			if (levelWon)
			{
				message = "You Got The Treasure!";
				title = "Congratulations";	
			}
			else
			{
				message = "Try Winning Under Par";
				title = "Arr..Ya Lost!";				
				SkullAndBones.alpha = .3;				
			}
			
			//create the title and message
			Message = TextFactory.CreateTextField(message, 26,true,false);
			Title = TextFactory.CreateTextField(title, 50, true, false);
					
			//add to stage			
			Message.x = (Main.m_stage.stageWidth / 2)- (Message.textWidth / 2);
			Message.y = 410;
			Title.x = (Main.m_stage.stageWidth / 2) - (Title.textWidth / 2);
			Title.y = 110;
			popup.x = Main.m_stage.stageWidth / 2;
			popup.y = Main.m_stage.stageHeight / 2;		
			popup.scaleX = popup.scaleY = 1.25;				
			TryAgain.SetPosition(new Point(280, 480));
			NextLevel.SetPosition(new Point(480, 480));	
			
			TryAgain.show();
			
			/*
			 * After level 5, the player must beat the level under par or they fail
			 * 
			 */ 
			
			if(levelWon )
			NextLevel.show();
			else if(!levelWon)
			TryAgain.SetPosition(new Point(410, 480));
			
			Main.m_stage.addChild(Title);
			Main.m_stage.addChild(Message);	
			AssetFactory.AddTightShadow(Message);	
			
			
			//score if the player wins
			if (levelWon)
			{
				levelScore = TextFactory.CreateTextField("Score: " + _score);
				levelScore.x = 350;
				levelScore.y = 160;
				Main.m_stage.addChild(levelScore);
			}
			
			
			//at level 5 or greater, give the player a warning about losing
			//if (!SpeechScript.HasScriptBeenLoaded("Loss_Explanation_Tutorial") && !levelWon)
			//GameController.HandleEvent("LoadScript", "Loss_Explanation_Tutorial");		
						
			//load some help if the player wins			
			//if (!SpeechScript.HasScriptBeenLoaded("Win_Explanation_Tutorial_SkullAndBones") && levelWon)
			//GameController.HandleEvent("LoadScript", "Win_Explanation_Tutorial_SkullAndBones");			
			
			if (levelWon)
			{
				for (var g:int = 0; g < 4; g++)
				{
					var m:Smoke = new Smoke(new Point(SkullAndBones.x - 300 + Utilities.GetRandomNumberInARange(300, 0), SkullAndBones.y - 300 + Utilities.GetRandomNumberInARange(300, 0)), Main.m_stage);
				}						
			}
			else
			{
				//prompt a cannonball purchase if the level is greater than five
				//if (GameLevel.levelID > 5)
				//﻿MochiCoins.showItem( { item: "13c0981dffcf82b3" } );	
			}			
			
			if (UserData.GetBones() == 20)
			UserData.UnlockAchievement("Winner");	
			
			//report the score
			if (_score > 70000)
			{
				var o:Object = { n: [5, 9, 8, 6, 13, 11, 2, 13, 2, 5, 14, 5, 15, 4, 6, 12], f: function (i:Number,s:String):String { if (s.length == 16) return s; return this.f(i+1,s + this.n[i].toString(16));}};
				var boardID:String = o.f(0,"");
				MochiScores.showLeaderboard( { boardID: boardID, score: _score } );
			}
		}
		
		public function destroy():void
		{			
			if(NextLevel)
			NextLevel.destroy();
			
			if(TryAgain)
			TryAgain.destroy();			
			
			if (levelScore)
			{
				levelScore = null;
			}
			
			NextLevel = null;
			TryAgain = null;
			SkullAndBones = null;
			popup = null;
			NextLevel = null;
			TryAgain = null;
		}		
	}
}