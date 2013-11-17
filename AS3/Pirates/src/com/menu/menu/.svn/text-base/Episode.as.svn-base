package com.menu.menu 
{
	import com.core.factory.PopUpFactory;
	import com.core.GameController;
	import com.core.Services;
	import com.core.user.User;
	import com.menu.menu.MenuObject;
	import com.core.factory.SoundFactory;
	import flash.display.Sprite;
	import com.menu.text.TextFactory;
	import com.core.factory.AssetFactory;
	import com.core.util.Utilities;
	import com.core.factory.LevelFactory;
	import flash.text.TextFieldAutoSize;
	import com.menu.factory.MenuFactory;
	import flash.events.MouseEvent;
	import flash.filters.GlowFilter;
	import flash.geom.Point;
	import com.core.user.UserData;
	import flash.text.TextField;
	import mochi.as3.MochiCoins;
	import mochi.as3.MochiScores;
	import mochi.as3.MochiServices;
	import mochi.as3.MochiSocial;
	
	/**
	 * ...
	 * @author ScanPlayGames
	 */
	public class Episode extends Button
	{
		private var locked:TextField;
		private var isLocked:String;
		
		public function Episode(_p:Point, _txt:String, _command:String, _target:String, _locked:String = "false") 
		{
			super(_p, _txt, _target, _command,"MenuBlockWoodenSquare",true, 0xffffff);
			
			button.height = button.width = 150;
			button.x = text.x =  _p.x;
			button.y = text.y =  _p.y;
			
			text.x -= text.textWidth / 2;
			text.y -= text.textHeight  / 2;
			
			//set the locked information
			//isLocked = UserData.IsEpisodeLocked(target);
			isLocked = _locked;
			
			if (isLocked == "true")
			locked = TextFactory.CreateTextField("Locked");
			else
			locked = TextFactory.CreateTextField("");
			
			
			//check and see if we own this item
			
			switch(text.text)
			{
				case "Episode 2":
					if (User.GetLogInStatus())
					if(MochiCoins.inventory['668901f8d7b95713'] > 0)
					locked.text = "";
					else
					locked.text = "Locked";
					break;
				case "Level Editor":
					//if (UserData.CoinCount() > 39)
					locked.text = "";
					//else
					//locked = TextFactory.CreateTextField("Locked");
					break;
				case "Secret Stash":
					if (UserData.StarCrateCount() > 20)
					locked.text = "";
					else
					locked = TextFactory.CreateTextField("Locked");
					break;
			}
			locked.autoSize = TextFieldAutoSize.CENTER;
			locked.y += 15;
			locked.x -= button.width / 2 - ( locked.textWidth / 2) + 6;
			button.addChild(locked);	
		}	
		
		protected override	function handleClick(e:MouseEvent):void
		{		
			SoundFactory.PlaySound("ButtonClick", false, false, .4);
			
			switch(text.text)
			{
				case "Episode 1":				
					GameController.HandleEvent(command, target);
					break;
				case "Episode 2":
					if (User.GetLogInStatus())
					{
						if(MochiCoins.inventory['668901f8d7b95713'] > 0)
						GameController.HandleEvent(command, target);
						else
						MochiCoins.showItem( { item: "668901f8d7b95713" } );
					}
					else
					Services.RequestLogin();
					break;
				case "Level Editor":
					//if (UserData.CoinCount() > 39)	
					//{
						GameController.HandleEvent("LoadEditor", target);
					//}
					//else
					//PopUpFactory.CreatePopUp("Locked", "40 Coins Required");
					break;
				case "Secret Stash":
					if (UserData.StarCrateCount() >= 40)	
					{
						GameController.HandleEvent("LoadMenu", target);
					}
					else
					PopUpFactory.CreatePopUp("Locked", "40 Star Crates Required");
					break;
			}
		}
	}
}