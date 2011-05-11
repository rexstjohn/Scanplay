package Actionscript
{
	import mx.core.UIComponent;
	
	public class RoundedMaskGenerator
	{
		//some consts
		private static const ROUNDEDCORNER_TOP:String = "top";
		private static const ROUNDEDCORNER_BOTTOM:String = "bottom";
		private static const ROUNDEDCORNER_LEFT:String = "left";
		private static const ROUNDEDCORNER_RIGHT:String = "right";
		private static const ROUNDEDCORNER_TOPLEFT:String = "topLeft";
		private static const ROUNDEDCORNER_BOTTOMLEFT:String = "bottomLeft";
		private static const ROUNDEDCORNER_TOPRIGHT:String = "topRight";
		private static const ROUNDEDCORNER_BOTTOMRIGHT:String = "bottomRight";
		
		//apply a basic rounded corner effect to all sides
		public static function applyRoundedCornerMask(_target:UIComponent,_rad:int=8, _width:Number=0,_height:Number=0, _x:int = 0, _y:int = 0):void
		{
			var roundedMask:UIComponent= new UIComponent();
			_target.addChild(roundedMask);
			roundedMask.graphics.clear();
			roundedMask.graphics.beginFill(0x000000);
			roundedMask.graphics.drawRoundRectComplex(_x, _y, (_width==0)?_target.width:_width, (_height==0)? _target.height:_height, _rad,_rad, _rad,_rad);
			roundedMask.graphics.endFill();
			roundedMask.mouseEnabled= false;
			_target.mask = roundedMask;
		}
		
		//applies rounded corners only to the specified side of a component (left, right, top,bottom)
		public static function applyRoundedCornersToSide(_target:UIComponent,_side:String = ROUNDEDCORNER_TOP,_rad:int=8, _width:Number=0,_height:Number=0):void
		{
			var roundedMask:UIComponent= new UIComponent();
			_target.addChild(roundedMask);
			roundedMask.graphics.clear();
			roundedMask.graphics.beginFill(0x000000);
			roundedMask.mouseEnabled= false;
			
			switch(_side)
			{
				case ROUNDEDCORNER_BOTTOM:
					roundedMask.graphics.drawRoundRectComplex(0, 0, (_width==0)?_target.width:_width, (_height==0)? _target.height:_height, 0,0, _rad,_rad);
					break;
				case ROUNDEDCORNER_LEFT:
					roundedMask.graphics.drawRoundRectComplex(0, 0, (_width==0)?_target.width:_width, (_height==0)? _target.height:_height, _rad,0,_rad,0);
					break;
				case ROUNDEDCORNER_RIGHT:
					roundedMask.graphics.drawRoundRectComplex(0, 0, (_width==0)?_target.width:_width, (_height==0)? _target.height:_height, 0,_rad, 0,_rad);
					break;
				default:
					//defaults to top
					roundedMask.graphics.drawRoundRectComplex(0, 0, (_width==0)?_target.width:_width, (_height==0)? _target.height:_height, _rad,_rad, 0,0);
					break;
			}
			
			roundedMask.graphics.endFill();
			_target.mask = roundedMask;
		}
		
		//apply rounded corner effect to only one corner
		public static function applyRoundedCornersToCorner(_target:UIComponent,_corner:String = ROUNDEDCORNER_TOPLEFT,_rad:int=8, _width:Number=0,_height:Number=0):void
		{
			var roundedMask:UIComponent= new UIComponent();
			_target.addChild(roundedMask);
			roundedMask.graphics.clear();
			roundedMask.mouseEnabled= false;
			roundedMask.graphics.beginFill(0x000000);
			
			switch(_corner)
			{
				case ROUNDEDCORNER_TOPRIGHT:
					roundedMask.graphics.drawRoundRectComplex(0, 0, (_width==0)?_target.width:_width, (_height==0)? _target.height:_height, 0,_rad, 0,0);
					break;
				case ROUNDEDCORNER_BOTTOMLEFT:
					roundedMask.graphics.drawRoundRectComplex(0, 0, (_width==0)?_target.width:_width, (_height==0)? _target.height:_height, 0,0,_rad,0);
					break;
				case ROUNDEDCORNER_BOTTOMRIGHT:
					roundedMask.graphics.drawRoundRectComplex(0, 0, (_width==0)?_target.width:_width, (_height==0)? _target.height:_height, 0,0, 0,_rad);
					break;
				default:
					//defaults to upper left
					roundedMask.graphics.drawRoundRectComplex(0, 0, (_width==0)?_target.width:_width, (_height==0)? _target.height:_height,_rad,0, 0,0);
					break;
			}
			
			roundedMask.graphics.endFill();
			_target.mask = roundedMask;
		}
	}
}