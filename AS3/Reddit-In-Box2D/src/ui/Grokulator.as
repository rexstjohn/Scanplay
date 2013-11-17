package ui 
{
	import flash.text.TextField;
	import objects.RedditPost;
	import physics.Block2D;
	import physics.StaticBlock2D;
	/**
	 * ...
	 * @author ScanPlayGames
	 * 
	 * Shows posts by their value and voting level
	 */
	public class Grokulator
	{
		private static var left:StaticBlock2D;
		private static var right:StaticBlock2D;
		private static var bottom:StaticBlock2D;
		private static var top:StaticBlock2D;
		
		private static var groks:Array;
		
		private static var grokText:TextField;
		
		public function Grokulator() 
		{			
			groks = new Array();
			
			left = new StaticBlock2D(900, 800, 10, 500);
		    right = new StaticBlock2D(1400, 800, 10, 500);
			top = new StaticBlock2D(1150, 554, 500, 10);
			bottom =  new StaticBlock2D(1150, 1045, 500, 10);
			
			Main.GetStage().addChild(left);
			Main.GetStage().addChild(right);
			Main.GetStage().addChild(bottom);
			Main.GetStage().addChild(top);
			
			grokText = new TextField();
			grokText.text = "Grokulator";
			//Main.GetStage().addChild(grokText);
			grokText.x = 1200;
			grokText.y = 700;
			grokText.scaleX = grokText.scaleY  = 3;
		}
		
		public static function AddGrok(_post:RedditPost):void
		{
			groks.push(new Grok(_post,1200, 700, _post.GetScore() / 30));
			Main.GetStage().addChild(groks[groks.length -1]);
		}
		
		public static function Update():void
		{			
			Main.GetStage().setChildIndex(left, Main.GetSprite().numChildren - 1)
			Main.GetStage().setChildIndex(bottom, Main.GetSprite().numChildren - 1)
			Main.GetStage().setChildIndex(right, Main.GetSprite().numChildren - 1)	
			Main.GetStage().setChildIndex(top, Main.GetSprite().numChildren - 1)			
		}
	}

}