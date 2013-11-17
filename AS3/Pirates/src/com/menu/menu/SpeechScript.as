package com.menu.menu 
{
	import com.core.GameController;
	import com.core.ObjectPool;
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.text.TextField;
	import com.menu.text.TextFactory;
	import com.core.factory.AssetFactory;
	
	/**
	 * ...
	 * @author ScanPlayGames
	 */
	public class SpeechScript
	{
		private static var scripts:Array;
		private static var character:Sprite;
		private static var bubble:Sprite;
		private static var icon:Sprite;
		private static var text:TextField;
		private static var title:TextField;
		private static var currentSpeechIndex:int;
		private static var currentScriptIndex:int;
		private static var buttons:Array;
		private static var tutorialMC:Sprite;
		
		//load all the speech objects from this particular speech into an array
		public function SpeechScript(_scripts:Array) 
		{
			scripts = _scripts;
			
			for each(var g:Object in scripts)
			{
				g.HasBeenLoaded = false;
			}
		}
		
		public static function LoadSpeechByIndex(scriptIndex:int = 0, speechIndex:int = 0):void
		{			
			
			var data:Object    = scripts[scriptIndex].speeches[speechIndex];
			currentScriptIndex = scriptIndex;
			currentSpeechIndex = speechIndex;
			
			//load the character
			character       = ObjectPool.GetObjectAs(data.character);
			bubble          = ObjectPool.GetObjectAs("SpeechBubble");
			title           = TextFactory.CreateTextField(data.title, 40, false, false, 0x900202);
			text            = TextFactory.CreateTextField(data.text, 25,false, false, 0x900202);
			text.wordWrap         = true;
			text.width            = 430;
			
			//add shit to the stage
			tutorialMC      = new Sprite();
			tutorialMC.graphics.beginFill(0x000000, .5);
			tutorialMC.graphics.drawRect( -1000, -1000, 4000, 4000);
			tutorialMC.graphics.endFill();
			icon            = ObjectPool.GetObjectAs(data.icon);
			Main.m_stage.addChild(tutorialMC);
			tutorialMC.addChild(bubble);				
			tutorialMC.addChild(text);
			tutorialMC.addChild(character);
			tutorialMC.addChild(title);
			tutorialMC.addChild(icon);
			
			//load the buttons
			buttons = new Array();
			
			for each(var b:Object in data.buttons)
			{
				var l:Button = new Button(new Point(325 , 265), b.text, b.target, b.command, "MenuBlockRectangle", false);
				buttons.push(l);
			}
			for each(var k:Button in buttons)
			{
				if(buttons.indexOf(k)-1 > -1)
				k.SetPosition(new Point((buttons[buttons.indexOf(k)-1].GetButton().x + (buttons[buttons.indexOf(k)].GetButton().width/2 ) + (buttons[buttons.indexOf(k)-1].GetButton().width / 2) + 20), 265));
			}
			
			character.x           = 150;
			character.y           = 400;
			character.height      = 250;
			
			//this is a hack I had to introduce just for the fucking walrus
			if (data.character == "Walrus")
			character.height = 190; 
			
			character.scaleX      = character.scaleY;			
			text.x                = 250;
			text.y                = 130;
			title.y               = 70;
			title.x               = 280;
			bubble.x              = 440;
			bubble.y              = 170;
			bubble.scaleY         = 1.4;
			bubble.height         = 300;
			bubble.width          = 600;
			icon.height           = 50;
			icon.scaleX = icon.scaleY;
			title.x += icon.width / 2;
			//icon.width            = 50;
			icon.x                = 260;
			icon.y                = 90;
			
			if (data.icon == "Cannon" || data.icon == "PowerBar")
			icon.x += 30;
			

		}
		
		public static function LoadScript(s:String):void
		{
			for each(var g:Object in scripts)
			{
				if (g.id == s)
				{		
					g.HasBeenLoaded = true;
					LoadSpeechByIndex(scripts.indexOf(g),0);	
					break;
				}
			}
		}
		public static function Destroy():void
		{
			while (tutorialMC.numChildren > 0)
			tutorialMC.removeChildAt(0);
			
			while(buttons.length > 0)
			{
				buttons[0].hide();
				buttons[0].destroy();
				buttons[0] = null;
				buttons.splice(0, 1);
			}
			ObjectPool.ReturnObject(character);
			ObjectPool.ReturnObject(bubble);
			ObjectPool.ReturnObject(icon);
			
			icon = null;
			buttons = null;
			character.visible = false;
			text.visible = false;
			bubble.visible = false;
			title.visible = false;
			tutorialMC.graphics.clear();
			character = null;
			bubble = null;
			text = null;
			title = null;
		}
		
		public static function LoadLastSpeech():void
		{
			if (currentSpeechIndex > -1 )
			{
				Destroy();				
				LoadSpeechByIndex(currentScriptIndex, currentSpeechIndex -1);
			}
		}	
		
		public static function HasScriptBeenLoaded(name:String):Boolean
		{
			var has:Boolean = false;
			
			for each(var k:Object in scripts)
			{
				if (name == k.id && k.HasBeenLoaded)
				{
					has = true;
				}				
			}
			
			return has;
		}
		
		public static function LoadNextSpeech():void
		{
			if (currentSpeechIndex < (scripts[currentScriptIndex].speeches.length - 1))
			{
				Destroy();
				LoadSpeechByIndex(currentScriptIndex, currentSpeechIndex +1);
			}
			else
			GameController.HandleEvent("CloseSpeech");
		}		
	}
}