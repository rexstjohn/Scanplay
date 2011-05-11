package com.photo.coloraverager 
{
	import Box2D.Dynamics.Joints.b2RevoluteJointDef;
	import com.physics.primitives.Block2D;
	import com.physics.World;
	
	/**
	 * ...
	 * @author ScanPlayGames
	 */
	public class PhotoBlock2D extends Block2D
	{
		protected var photoSquare:PhotoSquare;
		
		public function PhotoBlock2D(_photo:PhotoSquare,_x:Number, _y:Number, _height:Number, _width:Number) 
		{
			super(_x, _y, _height, _width);
			photoSquare = _photo;
		}
		
		public override function Update():void
		{		
			x = photoSquare.x = body.GetPosition().x * World.scale;
			y = photoSquare.y = body.GetPosition().y * World.scale;
			rotation  = photoSquare.rotation = body.GetAngle() * (180 / Math.PI);
			
			photoSquare.x -= photoSquare.width / 2;
			photoSquare.y -= photoSquare.height / 2;
		}
	}

}