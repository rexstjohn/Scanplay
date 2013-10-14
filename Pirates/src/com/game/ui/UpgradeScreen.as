package com.game.ui 
{
	import com.core.factory.AssetFactory;
	import com.core.factory.MessageFactory;
	import com.core.GameController;
	import com.core.GameLevel;
	import com.core.user.UserData;
	import com.game.ship.PirateShip;
	import com.menu.menu.Button;
	import com.menu.menu.SpeechScript;
	import com.menu.text.TextFactory;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.text.TextField;
	/**
	 * ...
	 * @author ScanPlayGames
	 * 
	 * A screen where players can upgrade their cannon power
	 */
	public class UpgradeScreen
	{
		//textfields
		private static var upgrades:Array;
		private static var closeButton:Button;
		private static var popup:Sprite;
		private static var backing:Sprite;
		private static var Title:TextField;
		private static var Message:TextField;
		public static var bonesLeft:int;
		
		public function UpgradeScreen() 
		{
			backing = new Sprite();
			
			backing.graphics.beginFill(0x000000, .5);
			backing.graphics.drawRect(0, 0, 800, 600);
			backing.graphics.endFill();
			backing.mouseChildren = false;
			bonesLeft = UserData.GetBones() - UserData.GetStat("Bones Allocated");
			
			upgrades = new Array();
			popup = AssetFactory.GetSprite("PopUp");
			popup.x = Main.m_stage.stageWidth / 2;
			popup.y = Main.m_stage.stageHeight / 2;		
			popup.scaleX = popup.scaleY = 1.25;		
			
			//the title
			Message = TextFactory.CreateTextField("Total Skull And Bones : " + bonesLeft + " /" + UserData.GetBones());
			Title = TextFactory.CreateTextField("Upgrades", 50, true, false);
			Message.x = (Main.m_stage.stageWidth / 2)- (Message.textWidth / 2);
			Message.y = 160;
			Title.x = (Main.m_stage.stageWidth / 2) - (Title.textWidth / 2);
			Title.y = 110;	
			
			Main.m_stage.addChild(backing);
			Main.m_stage.addChild(popup);
			Main.m_stage.addChild(Message);
			Main.m_stage.addChild(Title);
			
			upgrades.push(new StatBar("Cannon Power", 200, 210));
			upgrades.push(new StatBar("Par Bonus", 200, 250));
			upgrades.push(new StatBar("Bounce", 200, 290));
			upgrades.push(new StatBar("Damage", 200, 330));
			upgrades.push(new StatBar("Shot Size", 200, 370));
			
			closeButton = new Button(new Point(230, 480), "Close", "UpgradeScreen", "CloseUpgradeScreen");
			
			Update();
			
			//pop a message if this is the first time we see the upgrade screen
			if (!SpeechScript.HasScriptBeenLoaded("Upgrade_Explanation_Tutorial"))
			GameController.HandleEvent("LoadScript", "Upgrade_Explanation_Tutorial");				
			
			closeButton.GetButton().addEventListener(MouseEvent.CLICK, handleClick);
		}		
		
		public static function Update():void
		{			
			Main.m_stage.removeChild(Message);
			Message = null;
			Message = TextFactory.CreateTextField("Total Treasure : " + bonesLeft + " /" + UserData.GetBones());
			Main.m_stage.addChild(Message);
			Message.x = (Main.m_stage.stageWidth / 2)- (Message.textWidth / 2);
			Message.y = 160;
		}
		
		public static function handleClick(e:MouseEvent):void
		{
			destroy();
		}
		
		public static function Show():void
		{
			closeButton.show();
			popup.visible = true;
			Title.visible = true;
			Message.visible = true;		
			backing.visible = true;
			
			for each(var b:StatBar in upgrades)
			{
				b.Show();
			}
			
		}
		
		public static function destroy():void
		{
			
			//set the weapon power we selected
			PirateShip.minPower = 10;
			PirateShip.maxPower = 40 + (UserData.GetStat("Cannon Power") * 2.5);
			PirateShip.power = PirateShip.minPower ;
			GameLevel.par += int(UserData.GetStat("Par Bonus"));
			
			closeButton.destroy();
			
			Main.m_stage.removeChild(popup);
			Main.m_stage.removeChild(Title);
			
			if(Main.m_stage.contains(Message))
			Main.m_stage.removeChild(Message);
			
			Main.m_stage.removeChild(backing);
			
			GameLevel.upgradeScrenShowing = false;
			popup = null;
			Title = null;
			Message = null;
			backing = null;
			
			for each(var b:StatBar in upgrades)
			{
				b.destroy();
				b = null;
			}
			
			upgrades = null;
			LevelUI.CreateShotCounter();
		}
	}
}