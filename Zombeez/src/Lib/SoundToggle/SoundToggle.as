package Lib.SoundToggle 
{
	import flash.events.MouseEvent;
	import flash.media.SoundTransform;
	import flash.media.SoundMixer;
	import Lib.GameEvent.GameEvent;
	import Lib.GameObject;
	
	/**
	 * ...
	 * @author Rex
	 */
	public class SoundToggle extends GameObject
	{		
		public var soundIsOn:Boolean = true;
		public var soundTrans:SoundTransform;
		
		public function SoundToggle() 
		{
			super("SoundToggle");
			soundTrans =new SoundTransform();
			addEventListener(MouseEvent.CLICK, onClick);
			stop();
		}
		
		public function onClick(e:MouseEvent):void
		{
			if (soundIsOn)
			{
					trace("SoundToggle::Sound Is Off");
					soundIsOn = false;
					soundTrans.volume = 0;
					sf.playSound("ClickSound");
					gotoAndStop("off");
			}
			else
			{			
					trace("SoundToggle::Sound Is On");
					soundIsOn = true;
					soundTrans.volume = 1;
					sf.playSound("ClickSound");
					gotoAndStop("on");
			}
			
			SoundMixer.soundTransform = soundTrans;			
		}
		
	}

}