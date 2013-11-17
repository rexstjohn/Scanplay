package com.giblet.level 
{
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.text.TextField;
	import com.menu.factory.MenuFactory;
	import com.menu.text.TextFactory;
	import com.core.factory.AssetFactory;
	import com.core.factory.MessageFactory;
	/**
	 * ...
	 * @author ScanPlayGames
	 */
	public class ToolTip
	{
		private var tip:TextField;
		private var backing:Sprite;
		private var p:Point;
		
		public function ToolTip(s:String) 
		{
			tip = TextFactory.CreateTextField(s);
			backing = new Sprite();
			backing.graphics.lineStyle(2);
			backing.graphics.beginFill(0x000000, .33);
			backing.graphics.drawRect(0, 0, 800, 45);
			Main.m_stage.addChild(backing);			
			Main.m_stage.addChild(tip);
			tip.x =20;
			tip.y = 80;
			backing.x = 0;
			backing.y = 70;
			p = new Point(20, 80);
		}
		
		public function destroy():void
		{
			Main.m_stage.removeChild(backing);
			Main.m_stage.removeChild(tip);
		}
		
		public function Set(s:String):void		
		{
			if(Main.m_stage.contains(tip))
			Main.m_stage.removeChild(tip);
			
			tip = TextFactory.CreateTextField(s);
			Main.m_stage.addChild(tip);
			tip.x = p.x;
			tip.y = p.y;
		}		
	}
}