package Lib.Weapon 
{
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import Lib.GameObject;
	import Lib.Item.InventoryItem;
	import Lib.Item.Item;
	
	/**
	 * ...
	 * @author ScanPlay Games
	 */
	public class Weapon extends GameObject
	{
		public var weaponItem:InventoryItem; //item that this weapon inherits from
		public var weaponName:String;
		public var isEquipped:Boolean = false;
		public var projectiles:Array;
		public var ammoLeft:int;
		
		public function Weapon() 
		{
			super("Weapon");
			projectiles = new Array();
			stop();
		}
		
		public function handleClicks(e:MouseEvent):void 
		{ }
		
		public function aimWeapon(targetX:int, targetY:int):void 
		{
			
		}
		
		public function globalizeCoordinates(targetX:int, targetY:int):Point
		{
			var p:Point = new Point(targetX, targetY);
			p = parent.localToGlobal(p);
			
			var p2:Point = new Point(p.x, p.y);
			p2 = parent.parent.localToGlobal(p2);
			
			return p2;
		}
		
		public function equip():void
		{
			visible = true;
			isEquipped = true;
		}
		
		public function unEquip():void
		{
			visible = false;
			isEquipped = false;
		}
		
	}

}