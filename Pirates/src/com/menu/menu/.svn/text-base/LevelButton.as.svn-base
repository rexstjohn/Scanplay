package com.menu.menu 
{
	import com.core.factory.*;
	import com.core.GameController;
	import com.game.blocks.crates.powerups.StarCrate;
	import com.menu.factory.MenuFactory;
	import com.core.user.*;
	import com.game.*;
	import com.game.ui.*;
	import flash.display.*;
	import flash.events.*;
	import com.menu.text.TextFactory;
	import flash.filters.*;
	import com.core.factory.SoundFactory;
	import flash.geom.*;
	import flash.text.*;
	import mochi.as3.*;
	
	/**
	 * ...
	 * @author ScanPlayGames
	 */
	public class LevelButton extends MenuObject
	{
		public var button:Sprite;
		private var text:TextField;
		private var skullAndBones:Sprite;
		private var starCrate:Sprite;
		private var coin:Sprite;
		
		//button vars
		private var target:String;
		private var command:String;
		private var state:String;
		
		//level stats
		private var locked:Boolean;
		private var underPar:Boolean;
		private var levelID:int = 0;
		
		public function LevelButton(_p:Point,_txt:String,_target:String, _command:String, lid:int,_width:Number =50, _height:Number = 50) 
		{
			super();			
			
			//store the vals
			levelID = lid;
			command = _command;
			target = _target;
			
			underPar = false;
			locked = true;
			state = "idle";
			
			button = AssetFactory.GetSprite("MenuBlockWoodenSquare");
			skullAndBones = AssetFactory.GetSprite("TreasureChest");	
			MovieClip(MovieClip(skullAndBones).getChildAt(0)).gotoAndStop(10);
			skullAndBones.mouseChildren = true;
			skullAndBones.scaleX = skullAndBones.scaleY = .15;
			
			Main.m_sprite.addChild(button);
			text = TextFactory.CreateTextField(String(_txt));
			
			//create the level button
			button.x = text.x = _p.x;
			button.y = text.y = _p.y;		
			button.buttonMode = true;				
			button.scaleX = button.scaleY = .6;			
			TextFactory.AddShadow(button);
			
			Main.m_sprite.addChild(text);
			
			//create the coin and starcrate
			coin = AssetFactory.GetSprite("Coin");
			starCrate = AssetFactory.GetSprite("StarCrate");
			
			//we have to force level 21 and 41 to automatically be unlocked
			if(lid > UserData.LevelsUnlocked() && (lid != 21) && (lid != 41))
			{
				//set the button as greyed out
				button.alpha = .4
				
				//purge the old text
				if (Main.m_sprite.contains(text))
				Main.m_sprite.removeChild(text);
				
				//create the text
				text = TextFactory.CreateTextField("Locked",20);
				Main.m_sprite.addChild(text);
				locked = true;
				text.x = button.x - (text.textWidth / 2) + (button.width / 2);
				text.y = button.y - (text.textHeight / 2) + (button.height / 2);
				text.x -= button.width / 4;
				text.y -= button.width / 4;
			}
			else
			{
				locked = false;
				
				//purge the old text
				if (Main.m_sprite.contains(text))
				Main.m_sprite.removeChild(text);
				
				//if the player has a skull and bones, show it
				if (UserData.IsLevelSkullAndBones(levelID))
				{
					Main.m_sprite.addChild(skullAndBones);
					skullAndBones.x = button.x;
					skullAndBones.y = button.y;
					skullAndBones.x += (skullAndBones.width );
					skullAndBones.y += (skullAndBones.height );
				}
				
				//add the star crate
				if ((UserData.GetStarCratesCollected()[levelID - 1]) == true)
				{
					button.addChild(starCrate);
					starCrate.scaleX = starCrate.scaleY = .2
					starCrate.x += 45;
					starCrate.y -= 5;
				}
				
				//add the coin
				if ((UserData.GetCoinsCollected()[levelID - 1]) == true)
				{
					button.addChild(coin);
					coin.scaleX = coin.scaleY = .2
					coin.x += 45;
					coin.y -= 55;
				}
				
				//create the text
				text = TextFactory.CreateTextField(String(_txt));
				Main.m_sprite.addChild(text);
				text.x = button.x;
				text.y = button.y;
				text.x -= button.width / 2 - 10;
				text.y -= button.width / 2;
			}
			
			button.addEventListener(MouseEvent.CLICK, handleClick);
			button.addEventListener(MouseEvent.MOUSE_OVER, handleOver);
			button.addEventListener(MouseEvent.MOUSE_OUT, handleOut);
		}
		
		public function SetPosition(_p:Point):void
		{
			button.x = text.x = _p.x;
			button.y = text.y = _p.y;	
			
			text.x -= button.width / 4;
			text.y -= button.width / 4;
			
			//if the player has a skull and bones, show it
			if (UserData.IsLevelSkullAndBones(levelID))
			{
				skullAndBones.x = button.x;
				skullAndBones.y = button.y;
				skullAndBones.x += (skullAndBones.width );
				skullAndBones.y += (skullAndBones.height );
			}
		}
		
		private function handleOut(e:MouseEvent):void
		{
			//button.filters = [];
			//button.y -= 10;
			//text.y -= 10;
			//skullAndBones.y -= 10;
			AssetFactory.AddShadow(button);	
		}
		
		private function handleOver(e:MouseEvent):void
		{
			//button.y += 10;
			//text.y +=10;
			//skullAndBones.y += 10;
			//SoundFactory.PlaySound("ButtonClick");
			button.filters = [new GlowFilter(0xFFFF00, .7, 3, 3, 2, 1)];
		}
		
		public function destroy():void
		{			
			button.removeEventListener(MouseEvent.CLICK, handleClick);
			button.removeEventListener(MouseEvent.MOUSE_OVER, handleClick);
			button.removeEventListener(MouseEvent.MOUSE_OUT, handleOut);
			button.visible = false;
			text.visible = false;
			skullAndBones.visible = false;
			button = null;
			text = null;
			skullAndBones = null;
		}
		
		private function handleClick(e:MouseEvent ):void
		{		
			//SoundFactory.PlaySound("ButtonClick");
			
			SoundFactory.PlaySound("ButtonClick", false,false,.4);
			if(state == "idle")
			{
				if (!locked)
				GameController.HandleEvent("LoadLevelFromMenu", levelID);
			}		
		}
	}

}