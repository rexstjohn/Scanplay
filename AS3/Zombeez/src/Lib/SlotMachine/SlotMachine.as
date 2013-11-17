package Lib.SlotMachine 
{
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.text.TextField;
	import flash.utils.Timer;
	import Lib.GameEvent.GameEvent;
	import Lib.GameObject;
	import Lib.Item.Coin;
	import Lib.Player.Player;
	import com.scanplay.utils.getRandom;
	import mochi.as3.*;
	
	/**
	 * ...
	 * @author ScanPlay Games
	 */
	public class SlotMachine extends GameObject
	{
		public var CoinsLeft:TextField;
		public var PlayNow:SimpleButton;
		public var slotTimer:Timer;
		
		//back to map buttion
		public var CloseSlotMachine:SimpleButton;
		
		//slots
		public var Slot1:MovieClip;
		public var Slot2:MovieClip;
		public var Slot3:MovieClip;
		
		//the player
		public var player:Player;
		
		//slot state
		public var slotsState:String;
		
		public function SlotMachine() 
		{
			super("SlotMachine");
			Slot1.stop();
			Slot2.stop();
			Slot3.stop();
		}
		
		public function init(p:Player):void
		{
			slotsState = "Idle";
			player = p;
			CoinsLeft.text = String(player.Coins);
			slotTimer = new Timer(300);
			player.addEventListener("Update", onPlayerUpdate);			
			addEventListener(MouseEvent.CLICK, onClick);
		}
		
		public function onClick(e:MouseEvent):void
		{
			switch(e.target.name)
			{
				case "PlayNow":
					if (player.Coins >= 100)
					{
						if (slotsState == "Idle")
						{
							slotsState = "Active";
							PlayNow.mouseEnabled = false;
							PlayNow.alpha = .5;
							doSlots();
							player.Coins -= 100;
							player.Update("UpdateHi5Coins");
							sf.playSound("ClickSound");
						}
					}
					else
					{
						sf.playSound("FailSound");
					}
					break;
			}
		}
		
		//slot machine game
		public function doSlots():void
		{						
			//set stop points
			var stop1:int = getRandom(8, 1);
			var stop2:int = getRandom(8, 1);
			var stop3:int = getRandom(8, 1);
			
			Slot1.gotoAndPlay(getRandom(8, 1));
			Slot2.gotoAndPlay(getRandom(8, 1));
			Slot3.gotoAndPlay(getRandom(8, 1));
			
			//play a noise every frame
			addEventListener(Event.ENTER_FRAME, doNoise);
			
			function doNoise():void
			{				
				//sf.playSound("ClickSound");
			}
			
			//create the timer and start it
			slotTimer = new Timer(300);
			slotTimer.addEventListener("timer", doSlotTime);
			slotTimer.start();
			
			//does the timer for the slot machine slots slowing down and stopping
			function doSlotTime(e:TimerEvent):void
			{				
				switch(slotTimer.currentCount)
				{
					case 3:
						Slot1.stop();
						break;
					case 6:
						Slot2.stop();
						break;
					case 8:
						slotsState = "Idle";
						Slot3.stop();
						slotTimer.stop();
						checkIfWinner(); 
						slotTimer.removeEventListener("timer", doSlotTime);
						removeEventListener(Event.ENTER_FRAME, doNoise);
						PlayNow.mouseEnabled = true;
						PlayNow.alpha = 1;
						break;
				}
			}
			
			
			//award coins for various win scenarios
			function checkIfWinner():void
			{
				var winnings:int = 0;
				
				if (Slot1.currentFrame == Slot2.currentFrame)
				{
					winnings = 250;
					player.Coins += winnings;
					doWinAnimation(3);
				}
				
				if (Slot2.currentFrame == Slot3.currentFrame)
				{
					winnings = 250;	
					player.Coins += winnings;
					doWinAnimation(3);				
				}				
				
				if (Slot1.currentFrame == Slot3.currentFrame)
				{
					winnings = 250;	
					player.Coins += winnings;
					doWinAnimation(3);				
				}
				
				if ((Slot1.currentFrame == Slot3.currentFrame) && (Slot1.currentFrame == Slot2.currentFrame))
				{
					winnings = 2000;
					player.Coins += winnings;
					doWinAnimation(10);					
				}
			}
		}
		
		//makes a bunch of coins when you win at slots
		public function doWinAnimation(coinCount:int):void
		{
			var coins:Array = new Array();
			
			for (var g:int = 0; g < coinCount; g++)
			{
				var c:Coin = new Coin();
				c.y = (this.y / 2) + getRandom(50, 1);		
				c.x = (this.x / 2) + getRandom(500, 1);				
				c.onCoinDrop();						
				parent.addChild(c);				
				coins.push(c);
				
				//set the player's winnings
				CoinsLeft.text = String(player.Coins);
				player.Update("UpdateCoins");
				
				c.dispatcher.addEventListener("Update", onCoinUpdate);
				
				//make the coin disappear once it is finished animating
				function onCoinUpdate(e:Event):void
				{
					if (parent.contains(c))
					{
						parent.removeChild(c);
					}
				}
			}
		}
		
		public function reset():void
		{
			Slot1.gotoAndStop(1);
			Slot2.gotoAndStop(1);
			Slot3.gotoAndStop(1);
			slotTimer.stop();
			PlayNow.mouseEnabled = true;
			PlayNow.alpha = 1;
		}
		
		public function onPlayerUpdate(e:GameEvent):void
		{
			trace("SlotMachine::player update::" + e.argument);
			switch(e.argument)
			{
				case "UpdateCoins":
					CoinsLeft.text = String(player.Coins);
					break;
			}
		}
		
	}

}