package ui 
{
	import flash.display.GradientType;
	import flash.display.Graphics;
	import flash.display.SpreadMethod;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Matrix;
	import objects.RedditPost;
	import physics.Block2D;
	import physics.Explosion;
	import physics.PhysicsWorld;
	
	/**
	 * ...
	 * @author ScanPlayGames
	 */
	public class RedditPost2D extends Block2D
	{
		
		private var post:RedditPost;
		private var details:PostDetails;
		
		public function RedditPost2D(_post:RedditPost, _x:Number, _y:Number, _width:Number = 50, _height:Number = 50) 
		{
			super(_x, _y, _width, _height);
			
			post = _post;
			//create the details overlay
			details = new PostDetails(this, _post);
		
			if ((post.GetNumber() % 2) == 0)
			{
				graphics.beginFill(0xCEE3F8, 1);
				graphics.lineStyle(2, 0x5F99CF);
				graphics.drawRect( -120, - (95 / 2),20000, 120);
				graphics.endFill();			
			}
			
			SetPercentage(post.GetUpVotes(), post.GetDownVotes());
			
			Main.GetSprite().addChild(details);
		}
		public function HandleOver(e:MouseEvent):void
		{
			details.Show();
		}
		
		public function HandleOut(e:MouseEvent):void
		{
			details.Hide();
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
				matr.createGradientBox(( 100), (100), -90 * ( Math.PI / 180), 0, 0 );
			//SpreadMethod will define how the gradient is spread. Note!!! Flash uses CONSTANTS to represent String literals
			var sprMethod:String = SpreadMethod.PAD;
			//Start the Gradietn and pass our variables to it
		
			//Save typing + increase performance through local reference to a Graphics object
			var g:Graphics = graphics;
				g.beginGradientFill( fType, colors, alphas, ratios, matr, sprMethod );
				g.drawRect( 60, -40, 30, 100);
				
			
		}
		
		public function Explode():void
		{
			details.visible = false;
			visible = false;
			PhysicsWorld.DestroyObject(this);
			//var a:Explosion = new Explosion(500,100);
		}
		
		public function ApplyTexture(texture:Sprite):void
		{
			addChild(texture);
		}
		
		public override function Update():void
		{			
			x = details.x = GetBodyX();
			y = details.y = GetBodyY();
			rotation = body.GetAngle() * ( 180 / Math.PI);
			
			details.x = -150;
			details.y -= 60;
			Main.GetSprite().setChildIndex(details, Main.GetSprite().numChildren - 1)
		}
	}

}