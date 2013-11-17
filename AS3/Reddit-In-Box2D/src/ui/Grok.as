package ui 
{
	import flash.display.GradientType;
	import flash.display.Graphics;
	import flash.display.SpreadMethod;
	import flash.events.MouseEvent;
	import flash.geom.Matrix;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import objects.RedditPost;
	import physics.Circle2D;
	
	/**
	 * ...
	 * @author ScanPlayGames
	 */
	public class Grok extends Circle2D
	{
		private var post:RedditPost;
		protected var tag:TextField;
		protected var radius:Number;
		
		public function Grok(_post:RedditPost, _x:Number, _y:Number, _radius:Number = 10) 
		{
			super(_x, _y, _radius);
			post = _post;
			radius = _radius;
			tag = new TextField();
			tag.text = String(post.GetNumber());
			tag.autoSize = TextFieldAutoSize.CENTER;
			Main.GetStage().addChild(tag);
			tag.mouseEnabled = false
			tag.scaleX = tag.scaleY = 5;
			buttonMode = true;
			tag.visible = false;
			
			SetPercentage(post.GetUpVotes(), post.GetDownVotes());
			
			addEventListener(MouseEvent.MOUSE_OVER, HandleOver);
			addEventListener(MouseEvent.MOUSE_OUT, HandleOut);			
		}
		public function SetPercentage(_upVotes:int, _downVotes:int):void
		{
			
			var pUpVotes:Number   = _upVotes / ( _upVotes + _downVotes);
			var pDownVotes:Number = _downVotes / ( _upVotes + _downVotes);
					
			//Type of Gradient we will be using
			var fType:String = GradientType.LINEAR;
			//Colors of our gradient in the form of an array
			var colors:Array = [ 0x4D79A6,0xFB4502];
			//Store the Alpha Values in the form of an array
			var alphas:Array = [ 1, 1 ];
			//Array of color distribution ratios.  
			//The value defines percentage of the width where the color is sampled at 100%
			var ratios:Array = [255 * pUpVotes, 255 * pDownVotes];
			//Create a Matrix instance and assign the Gradient Box
			var matr:Matrix = new Matrix();
				matr.createGradientBox(( radius), (radius), -90 * ( Math.PI / 180), 0, 0 );
			//SpreadMethod will define how the gradient is spread. Note!!! Flash uses CONSTANTS to represent String literals
			var sprMethod:String = SpreadMethod.PAD;
			//Start the Gradietn and pass our variables to it
		
			//Save typing + increase performance through local reference to a Graphics object
			var g:Graphics = graphics;
				g.beginGradientFill( fType, colors, alphas, ratios, matr, sprMethod );
				g.drawCircle(0,0, post.GetScore() / 30);		
		}
		
		private function HandleOver(e:*):void
		{
			Main.GetStage().setChildIndex(tag, Main.GetStage().numChildren - 1)
			tag.visible = true;
			tag.x = x;
			tag.y = y;
		}
		
		private function HandleOut(e:*):void
		{
			tag.visible = false;
		}
		
	}

}