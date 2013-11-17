package ui 
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import objects.RedditPost;
	import physics.Explosion;
	
	/**
	 * ...
	 * @author ScanPlayGames
	 */
	public class PostDetails extends Sprite
	{
		private var post:RedditPost;
		
		//title text
		private var title:TextField;
		private var format:TextFormat;
		
		//
		private var number:TextField;
		private var votes:TextField;
		private var submitted:TextField;
		
		//thumbnail
		[Embed(source='../noimage.png')]
		private var thumbnail:Class;
		
		private var upArrow:Arrow;
		private var downArrow:Arrow;
		
		private var parentPost:RedditPost2D;
		
		public function PostDetails(_parent:RedditPost2D, _post:RedditPost) 
		{
			parentPost = _parent;
			post = _post;
			title = new TextField();
			votes = new TextField();
			number = new TextField();
			submitted = new TextField();
			
			format = new TextFormat("Arial", 33, 0x346699, false, false, false, _post.GetLink(), "_blank", "left");
			
			//create the title
			title.text = post.GetTitle();
			title.wordWrap = true;
			title.width = 1800;
			//title.mouseEnabled = false;
			//title.
			title.autoSize = TextFieldAutoSize.LEFT;
			title.setTextFormat(format);
			title.y += 20;
			
			//create the number
			format = new TextFormat("Arial", 35, 0xC6C6C6,false,false,false);
			number.text = String(post.GetNumber());
			number.mouseEnabled = false;
			number.autoSize = TextFieldAutoSize.LEFT;
			number.setTextFormat(format);
			number.x -= 190;
			number.y += 47;
			
			//create the votes
			format = new TextFormat("Arial", 30, 0xC6C6C6);
			votes.text = String( post.GetScore());
			votes.mouseEnabled = false;
			votes.autoSize = TextFieldAutoSize.CENTER;
			votes.setTextFormat(format);
			votes.x -= 145;
			votes.y += 45;
			//votes.x += (votes.textWidth / 2);
			
			//submittted
			format = new TextFormat("Arial",20, 0x888);
			submitted.text = "Submitted by " +String(post.GetAuthor()) + " to " + post.GetSubreddit();
			submitted.mouseEnabled = false;
			submitted.y += 99;
			submitted.autoSize = TextFieldAutoSize.LEFT;
			submitted.setTextFormat(format);
			
			addChild(title);
			addChild(number);
			addChild(votes);
			addChild(submitted);
			
			//create the arrows
			upArrow = new Arrow();
			downArrow  = new Arrow();
			addChild(upArrow);
			addChild(downArrow);
			upArrow.scaleX = upArrow.scaleY = downArrow.scaleX = downArrow.scaleY = .4;
			
			upArrow.x -= 100; 
			downArrow.x -= 100;
			downArrow.y += 100;
			upArrow.y += 35;
			downArrow.rotation += 180;
			
			if (post.GetThumbnail())
			{
				var p:Bitmap;
				
				if (post.GetThumbnail() == "/static/noimage.png")
				{p = Bitmap(new thumbnail())}
				else
				{p = post.GetThumbnailImage();	}			
				
				
				if (p)
				{
					addChild(p);
					title.x += 120;
					p.height = p.width = 100;
					p.x += 10;
					p.width = 100;
					p.y += 18;
					submitted.x += 140;
				}

			}
			
			downArrow.addEventListener(MouseEvent.CLICK, HandleClick);
			upArrow.addEventListener(MouseEvent.CLICK, HandleClick);
		}
		
		public function HandleClick(e:MouseEvent):void
		{
			trace("click");
			trace(e.target);
			if (e.target == downArrow.arrowMovie)
			{
				downArrow.SetColor("Blue");
				upArrow.SetColor("Idle");
				parentPost.Explode();
			}
			
			if (e.target == upArrow.arrowMovie)
			{
				downArrow.SetColor("Idle");
				upArrow.SetColor("Red");
				format = new TextFormat("Arial", 30, 0xC6C6C6);
				votes.text = String( post.GetScore() + 1);
				votes.mouseEnabled = false;
				votes.autoSize = TextFieldAutoSize.CENTER;
				votes.setTextFormat(format);
			}
		}
		
		public function Show():void
		{
			visible = true;
		}
		
		public function Hide():void
		{
			visible = false;
		}
	}

}