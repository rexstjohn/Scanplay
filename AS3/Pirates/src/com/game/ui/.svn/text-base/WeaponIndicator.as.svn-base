package com.game.ui 
{
	
	import com.game.fx.Smoke;
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.text.TextField;
	import com.menu.factory.MenuFactory;
	import com.menu.text.TextFactory;
	import com.core.factory.AssetFactory;
	import com.game.ship.PirateShip;
	import com.core.user.UserData;
	/**
	 * ...
	 * @author ScanPlayGames
	 */
	public class WeaponIndicator 
	{
		private static var AmmoType:Sprite;
		private static var WeaponType:TextField;
		private static var _p:Point;
		private static var hasPowerup:Boolean;
		
		public function WeaponIndicator(p:Point) 
		{
			super();
			_p = p;	
			hasPowerup = false;
			
			//create the "powerup" text
			WeaponType = TextFactory.CreateTextField("Power-Up: ");
			WeaponType.visible = false;
			AssetFactory.AddTightShadow(WeaponType);
			WeaponType.x = _p.x;
			WeaponType.y = _p.y - WeaponType.textHeight + 10;
			//Main.m_stage.addChild(WeaponType);
			
			if (PirateShip.currentWeapon != "Cannonball_Standard")
			ActivatePowerup(PirateShip.currentWeapon);
		}
		
		public static function ActivatePowerup(s:String):void
		{			
			
			if (AmmoType)
			{
				if(Main.m_stage.contains(AmmoType))
				Main.m_stage.removeChild(AmmoType);
				AmmoType = null;
			}
			
			switch(s)
			{
				case "Cannonball_Explosive":
					AmmoType = AssetFactory.GetSprite("ExplosiveShotCrate");
					break;
				case "Cannonball_Triple":
					AmmoType = AssetFactory.GetSprite("TripleShotCrate");
					break;
				case "Cannonball_Rubber":
					AmmoType = AssetFactory.GetSprite("RubberShotCrate");
					break;
			}			
			
			Main.m_stage.addChild(AmmoType);
			
			AmmoType.scaleX = AmmoType.scaleY = .18;
			AmmoType.x = _p.x + WeaponType.textWidth + 30;
			AmmoType.y = _p.y;				
			hasPowerup = true;
			AssetFactory.AddTightShadow(AmmoType);
		}
		
		public static function Hide():void
		{
			if(AmmoType)
			AmmoType.visible = false;	
			
			WeaponType.visible = false;
		}
		
		public static function Show():void
		{
			if(hasPowerup)
			var smoke:Smoke = new Smoke(new Point(AmmoType.x - 30, _p.y + 10), Main.m_stage);
			
			
			if(AmmoType)
			AmmoType.visible = true;		
			
			WeaponType.visible = true;
		}
		
		public static function destroy():void
		{				
			AmmoType = null;
			WeaponType = null;
		}
		
	}

}