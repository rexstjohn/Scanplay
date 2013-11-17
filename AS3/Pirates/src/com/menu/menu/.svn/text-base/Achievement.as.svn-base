package com.menu.menu
{
	import com.core.ObjectPool;
	import com.menu.menu.MenuObject
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.text.TextField;
	import com.core.user.UserData;
	import com.core.factory.AssetFactory;
	import com.menu.text.TextFactory;
	import com.menu.factory.MenuFactory;
	
	/**
	 * ...
	 * @author ScanPlayGames
	 */
	public class Achievement extends MenuObject
	{
		private var back:Sprite;
		private var skullAndBones:Sprite;
		private var text:TextField;
		
		public function Achievement(_p:Point, name:String, type:String) 
		{
			super();
			//back = ObjectPool.GetObjectAs("MenuBlockWoodRectangle");
			skullAndBones = ObjectPool.GetObjectAs("Achievement");
			text = TextFactory.CreateTextField(name, 26,true,false);
			
			//Main.m_sprite.addChild(back);
			Main.m_sprite.addChild(skullAndBones);
			Main.m_sprite.addChild(text);			
			
			skullAndBones.scaleX = skullAndBones.scaleY = .35;
			
			//back.width = 300;
			//back.height = 50;
			
			//back.x = 
			skullAndBones.x = text.x = _p.x;
			//back.y = 
			skullAndBones.y = text.y = _p.y;
			
			//back.x += back.width / 4;
			//back.y += back.height / 2;
			
			text.y += text.textHeight / 4;
			text.x += 20;
			
			skullAndBones.y += skullAndBones.height;
			skullAndBones.x -= skullAndBones.height / 2;
			
			skullAndBones.y -= 10;
			
			if (UserData.GetData()[type] != "Unlocked")
			{
				skullAndBones.alpha = .3;
				text.alpha = .6;
				//back.alpha = .3;
			}
		}
		
		public function destroy():void
		{
			//ObjectPool.ReturnObject(back);
			ObjectPool.ReturnObject(skullAndBones);
		}		
	}
}