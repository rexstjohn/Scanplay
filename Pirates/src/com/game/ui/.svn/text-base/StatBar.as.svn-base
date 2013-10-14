package com.game.ui 
{
	import com.core.factory.AssetFactory;
	import com.core.user.UserData;
	import com.menu.text.TextFactory;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.filters.GlowFilter;
	import flash.text.TextField;
	/**
	 * ...
	 * @author ScanPlayGames
	 * 
	 * A stat counter
	 */
	public class StatBar
	{
		private var text:TextField;
		private var bones:Array;
		private var plusButton:Sprite;
		private var minusButton:Sprite;
		public var count:int = 0;
		
		//text on the buttons
		private var minusText:TextField;
		private var plusText:TextField;
		private var statName:String;
		
		public function StatBar(_text:String, x:Number, y:Number) 
		{			
			text = TextFactory.CreateTextField(_text);
			bones = new Array();
			statName = _text;
			count = UserData.GetStat(statName);
			
			for (var g:int = 0; g < 6; g++)
			{
				bones.push(AssetFactory.GetSprite("TreasureChest"));
				MovieClip(MovieClip(bones[bones.length - 1]).getChildAt(0)).stop();
				Main.m_stage.addChild(bones[g]);
				bones[g].x = x + 200 + (30 * g) + 20;;
				bones[g].y = y + 15;
				bones[g].height = 24;
				bones[g].width = 24;	
				
				if(g >= count)
				bones[g].alpha = .25;
			}			
			
			Main.m_stage.addChild(text);
			
			plusButton = AssetFactory.GetSprite("MenuBlockSquare");
			minusButton = AssetFactory.GetSprite("MenuBlockSquare");			
			
			Main.m_stage.addChild(plusButton); 
			Main.m_stage.addChild(minusButton);			
			
			plusButton.width = minusButton.width = plusButton.height = minusButton.height = 25;
			
			minusButton.x = x + 160;
			plusButton.x = x + 190;
			minusButton.y = y + 14;
			plusButton.y = y + 14;
			plusButton.buttonMode = true;
			minusButton.buttonMode = true;
			
			text.x = x;
			text.y = y;
			
			AssetFactory.AddShadow(plusButton);
			AssetFactory.AddShadow(minusButton);
			
			minusText = TextFactory.CreateTextField("-",145,false,false,0x5c4101);
			plusText = TextFactory.CreateTextField("+", 145,false,false,0x5c4101);
			
			plusButton.addChild(plusText);
			minusButton.addChild(minusText);
			
			minusText.x -= 50;
			minusText.y -= 80;
			
			plusText.x -= 50;
			plusText.y -= 80;
			
			plusButton.addEventListener(MouseEvent.MOUSE_OVER, handleOver);
			minusButton.addEventListener(MouseEvent.MOUSE_OVER, handleOver);
			plusButton.addEventListener(MouseEvent.MOUSE_OUT, handleOut);
			minusButton.addEventListener(MouseEvent.MOUSE_OUT, handleOut);
			plusButton.addEventListener(MouseEvent.CLICK, handleClick);
			minusButton.addEventListener(MouseEvent.CLICK, handleClick);
		}	
		
		public function handleClick(e:MouseEvent):void
		{
			if (e.target == plusButton)
			{
				if(count < 6 && (UpgradeScreen.bonesLeft > 0))
				{
					bones[count].alpha = 1;
					count++;
					UpgradeScreen.bonesLeft--;
					UserData.AllocateBones();
					UpgradeScreen.Update();
					UserData.SetStat(statName, count);
				}
			}
			
			if (e.target == minusButton)
			{
				if(count > 0)
				{
					count--;
					bones[count].alpha = .25;
					UpgradeScreen.bonesLeft++;
					UserData.DeallocateBones();
					UpgradeScreen.Update();
					UserData.SetStat(statName, count);
				}				
			}
		}
		
		public function handleOut(e:MouseEvent):void
		{
			e.target.filters = [];
			AssetFactory.AddShadow(Sprite(e.target));
		}
		
		public function handleOver(e:MouseEvent):void
		{			
			e.target.filters = [new GlowFilter(0xFFFF00, .7, 3, 3, 2, 1)];
		}
		
		public function Show():void
		{
			text.visible = true;
			minusButton.visible = true;
			plusButton.visible = true;
			
			for each(var b:Sprite in bones)
			{
				b.visible = true;
			}
		}
		
		public function destroy():void
		{
			plusButton.removeEventListener(MouseEvent.MOUSE_OVER, handleOver);
			minusButton.removeEventListener(MouseEvent.MOUSE_OVER, handleOver);
			plusButton.removeEventListener(MouseEvent.MOUSE_OUT, handleOut);
			minusButton.removeEventListener(MouseEvent.MOUSE_OUT, handleOut);
			plusButton.removeEventListener(MouseEvent.CLICK, handleClick);
			minusButton.removeEventListener(MouseEvent.CLICK, handleClick);
			
			Main.m_stage.removeChild(plusButton);
			Main.m_stage.removeChild(minusButton);
			Main.m_stage.removeChild(text);
			
			plusButton = null;
			minusButton = null;
			plusText = null;
			minusText = null;
			text = null;
			minusButton = null;
			plusButton = null
			
			for each(var b:Sprite in bones)
			{
				Main.m_stage.removeChild(b);
				b = null;
			}
			
			bones = null;
		}
		
		public function Hide():void
		{
			text.visible = false;
			minusButton.visible = false;
			plusButton.visible = false;
			
			for each(var b:Sprite in bones)
			{
				b.visible = false;
			}
		}
	}
}