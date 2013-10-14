package com.game.ui 
{
	
	import com.menu.menu.BasicButton;
	import flash.display.Sprite;
	import com.menu.factory.MenuFactory;
	import com.core.user.UserData;
	import com.menu.text.TextFactory;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.text.TextField;
	import com.menu.factory.MenuFactory;
	import com.core.factory.AssetFactory;
	
	/**
	 * ...
	 * @author ScanPlayGames
	 */
	public class StoreItem 
	{
		private  var storeID:String;
		private  var price:TextField;
		public  var graphic:Sprite;
		public   var buyButton:BasicButton;
		private  var name:TextField;
		private  var description:TextField;
		public var state:String;
		
		public function StoreItem(_p:Point, _sprite:String, _price:int, _description:String, _name:String, _storeID:String) 
		{
			super();
			state = "idle";
			storeID = _storeID;
			graphic = AssetFactory.GetSprite(_sprite);
			buyButton = new BasicButton(_p, "Buy", 40, 100);
			name = TextFactory.CreateTextField(_name);
			description = TextFactory.CreateTextField(_description);
			price = TextFactory.CreateTextField(String("Cost: " +_price));
			
			graphic.x = price.x = description.x = name.x = _p.x;
				
			Main.m_stage.addChild(graphic);
			Main.m_stage.addChild(name);
			Main.m_stage.addChild(description);
			Main.m_stage.addChild(price);
			
			graphic.scaleX = graphic.scaleY = .6;
			name.x -= name.textWidth / 2;
			price.x -= price.textWidth / 2;
			description.x -= description.textWidth / 2;
			graphic.y = _p.y;
			name.y = _p.y - graphic.height;
			description.y = _p.y + name.textHeight + 18;
			price.y = _p.y + name.textHeight + 20 + description.textHeight;
			buyButton.SetPosition(new Point(_p.x, _p.y + name.textHeight + 45 + description.textHeight + price.textHeight));
		
			
			buyButton.button.addEventListener(MouseEvent.CLICK, handleClick);
		}
		
		public function deactivate():void
		{
			graphic.alpha = .4;
			price.alpha = 0;
			name.alpha = .4;
			description.alpha = .4;
			buyButton.hide();
		}
		
		public function activate():void
		{
			graphic.alpha = 1;
			price.alpha = 1;
			name.alpha = 1;
			description.alpha = 1;
			buyButton.hide();			
		}
		
		private function handleClick(e:MouseEvent):void
		{
			state = "selected";
			UserData.BuyPowerUp(storeID);
		}
		
		public function destroy():void
		{		
			buyButton.destroy();
		}
	}

}