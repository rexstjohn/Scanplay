package com.core.factory 
{
	/**
	 * ...
	 * @author ScanPlayGames
	 */
	import com.core.factory.AssetFactory;
	import com.menu.factory.MenuFactory;
	import com.menu.menu.BasicButton;
	import com.menu.menu.Button;
	import com.menu.menu.SpeechScript;
	import com.menu.text.TextFactory;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.text.TextField;
	
	public class ScriptFactory
	{
		public static var currentSpeech:SpeechScript;
		
		public function ScriptFactory() 
		{			
			currentSpeech = new SpeechScript(LoadScriptsFromXML());	
		}		
		
		//load the script xml
		public static function LoadScriptsFromXML():Array
		{		
			var newScriptXML:XML    =  AssetFactory.GetXML("Scripts");		
			var scripts:Array       =  new Array();
	
			//capture all the objects
			var g:int;
			
			for (g = 0; g < newScriptXML.script.length(); g++)
			{
				var scriptObject:Object     = new Object();
				scriptObject["id"]          = String(newScriptXML.script[g].@id);	
				var speeches:Array          = new Array();		
				var l:int;
				var k:int;
				
				//collect all the speech texts into the speeches array as speech objects
				for ( l = 0; l < newScriptXML.script[g].speech.length(); l++)
				{
					var speechObject:Object = new Object();	
					var buttons:Array       = new Array();			
					speechObject.character  = String(newScriptXML.script[g].speech[l].@character);				
					speechObject.title      = String(newScriptXML.script[g].speech[l].title);	
					speechObject.icon       = String(newScriptXML.script[g].speech[l].title.@icon);
					speechObject.text       = String(newScriptXML.script[g].speech[l].text);
					
					for (k = 0; k < newScriptXML.script[g].speech[l].button.length(); k++)
					{
						var button:Object = new Object();
						button.text         = String(newScriptXML.script[g].speech[l].button[k].@text);
						button.command      = String(newScriptXML.script[g].speech[l].button[k].@command);
						button.target       = String(newScriptXML.script[g].speech[l].button[k].@target);
						buttons.push(button);
					}
					//push the buttons to the speech object
					speechObject.buttons = buttons;
					speeches.push(speechObject);		
				}				
				
				scriptObject.speeches = speeches;
				scripts.push(scriptObject);								
			}						
	
			return scripts
		}		
	}
}