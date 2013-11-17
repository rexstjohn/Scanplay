package ui 
{
	import flash.display.Sprite;
	import physics.Block2D;
	import physics.Rope2D;
	/**
	 * ...
	 * @author ScanPlayGames
	 */
	public class LogoBlock extends Block2D
	{
		[Embed(source = '../Loader.swf', symbol = 'RedditB2d')]
		private var logo:Class;		
		
		private var chain:Rope2D;
		
		public function LogoBlock(_x:Number, _y:Number) 
		{
			super(_x, _y, 100, 100);
			var l:Sprite = Sprite(new logo());
			addChild(l);
			l.rotation -= 180;
			l.y += 20;
			l.scaleX = l.scaleY = .5;
			
			chain = new Rope2D(_x, -100, 15, 10, 20);
			chain.AddAnchorBody(body);
		}
		
		public override function Update():void
		{			
			x =GetBodyX();
			y =GetBodyY();
			rotation = body.GetAngle() * ( 180 / Math.PI);
			
		}
	}

}