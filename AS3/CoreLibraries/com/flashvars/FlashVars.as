package com.flashvars 
{
	import flash.display.LoaderInfo;
	import flash.display.Sprite;
	import flash.display.Stage;
	/**
	 * ...
	 * @author ScanPlayGames
	 */
	public class FlashVars
	{		
		public static function GetFlashVars(_parent:Sprite):Object
		{
			return LoaderInfo(_parent.root.loaderInfo).parameters;
		}		
	}
}