package com.giblet.level 
{
	import com.core.ObjectPool;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import com.core.factory.AssetFactory;
	/**
	 * ...
	 * @author ScanPlayGames
	 */
	public class LineObject extends GameObject
	{		
		public var points:Array;
		public var skin:Sprite;
		private var nail:Sprite;
		private var c2:Sprite;
		private var c1:Sprite;
		
		private var platformSpriteID:String;
		private var platformTypeName:String;
		private var name:String;
		
		public function LineObject(p:Array, tool:Object) 
		{
			super(tool["name"]);
			name = tool["name"];
			platformSpriteID = tool["objectSpriteID"];
			platformTypeName = tool.name;
			points = p;
			
			if (String(tool["name"]).search("static") != -1)
			{		
				c1 =   ObjectPool.GetObjectAs("PlatformCorner");
				c2 =   ObjectPool.GetObjectAs("PlatformCorner");
				nail = ObjectPool.GetObjectAs("Nail");
				
				c2.scaleX = c2.scaleY = c1.scaleY = c1.scaleX = .1 
			}
			draw();		
		}
		
		public function destroy():void
		{		
			if (name.search("static") != -1)
			{	
				nail.visible = false;
				c2.visible = false;
				c1.visible = false;
				ObjectPool.ReturnObject(nail);
				ObjectPool.ReturnObject(c1);
				ObjectPool.ReturnObject(c2);			
			}
			skin.visible = false;
			ObjectPool.ReturnObject(skin);
		}
		
		public function draw():void
		{
			
			var dx:Number = (points[0].x) - (points[1].x);
			var dy:Number = (points[0].y) - (points[1].y);
			var _length:Number = Math.sqrt(dx * dx +dy * dy);
			var angle:Number = Math.atan2(dy, dx) * ( 180 / Math.PI);
			
			//now make it pretty
			skin = ObjectPool.GetObjectAs(platformSpriteID);
			skin.width =  (_length ) + 5;
			skin.height = 10;
			skin.mouseEnabled = true;
			Main.m_sprite.addChild(skin);
		
			skin.x = (points[0].x);
			skin.y = (points[0].y);
			
			skin.rotation = angle;
			var radAngle:Number = (Math.PI / 180) * angle;
			
			skin.x -= Math.cos(radAngle) * _length / 2;			
			skin.y -= Math.sin(radAngle)  * _length / 2;			
			
			if (name.search("static") != -1)
			{				
				nail.x = (skin.x );
				nail.y = (skin.y );
				
				c1.x = points[0].x;
				c1.y = points[0].y;
				c2.x = points[1].x;
				c2.y = points[1].y;
				
				Main.m_sprite.addChild(c1);
				Main.m_sprite.addChild(c2);
				Main.m_sprite.addChild(nail);
			}
			
			skin.name = "platformskin";
			
		}
	}

}