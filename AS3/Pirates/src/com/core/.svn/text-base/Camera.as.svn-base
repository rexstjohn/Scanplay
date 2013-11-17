package com.core 
{
	/**
	 * ...
	 * @author ScanPlay Games
	 */
	
	import com.game.ship.PirateShip;
	import com.physics.blocks.PhysicsObject;
	import com.core.factory.*;
	import com.game.*;
	import flash.display.*;
	import flash.events.*;
	import com.physics.GameWorld;
	import flash.geom.*;
	
	public class Camera 
	{		
		private static var DefaultTarget:PhysicsObject;
		public static var OtherTarget:PhysicsObject;
		
		//red arrow
		private static var redArrow:Sprite;
		
		//stats and vars
		private static var FocusPoint:Point;
		private static var CameraTarget:String;
		private static var speed:Number = 17;
		private static const scalar:Number = .7;
		public static var zoomed:Boolean;
		private static var panLocked:Boolean;
		
		//we use this on weapon splash downs
		public static var stopCamera:Boolean;
		
		//level constraints for panning
		private static const xConstraint:Point = new Point( -1000, 350);
		
		public function Camera():void
		{
			CameraTarget = "none";
			redArrow = AssetFactory.GetSprite("RedArrow");
			zoomed = true;
			panLocked = false;
			stopCamera = false;
			redArrow.rotation = 180;
			redArrow.scaleX = redArrow.scaleY = .5;
			redArrow.visible = false;
			
			
			Main.m_sprite.addEventListener(Event.ENTER_FRAME, handleEnter);			
		}
		
		public static function PanToDefaultTarget():void
		{
			var defaultX:Number = (Main.m_sprite.stage.stageWidth / 2.5) - (DefaultTarget.GetBody().GetPosition().x * GameWorld.pixels_per_meter);
			Main.m_sprite.x +=  speed;	
			Main.m_sprite.y = 100;
			
			if (Main.m_sprite.x >= ((Main.m_sprite.stage.stageWidth / 2.5) - 250))
			{
				SetPanLocked(false);
				FollowDefault();
			}			
		}
		
		public static function PanToDefault():void
		{
			CameraTarget = "PanToDefault";
		}
		
		private static function Pan():void
		{
		}
		
		private static function handleEnter(e:Event):void
		{
			Pan();
					
			switch(CameraTarget)
			{
				case "Default":
					ChaseDefault();
					break;
				case "Other":
					ChaseTarget();
					break;
				case "FocusPoint":
					ChaseFocusPoint();
					break;
				case "PanToDefault":
					PanToDefaultTarget();
					break;
				default:
					break;
			}
		}
		
		public static function GetFocusPoint():Point
		{
			return FocusPoint;
		}
		
		public static function GetOtherTarget():PhysicsObject
		{
			return OtherTarget;
		}
		
		public static function SetNewTarget(b:PhysicsObject, t:String = "Other"):void
		{
			OtherTarget = b;  CameraTarget = t;
		
			if (!Main.m_sprite.contains(redArrow))
			Main.m_sprite.addChild(redArrow);
		}
				
		public static function SetDefaultTarget(b:PhysicsObject):void
		{DefaultTarget = b;  CameraTarget = "Default"; }		
		
		public static function SetFocusPoint(p:Point):void
		{
			FocusPoint = p; CameraTarget = "FocusPoint"; 
			ZoomOut();
		}
		
		public static function ZoomOut():void
		{
			Main.m_sprite.scaleY = Main.m_sprite.scaleX = scalar; 
			zoomed = true;
		}
		
		public static function ResetScale():void
		{			
			Main.m_sprite.scaleX = 1; 
			Main.m_sprite.scaleY = 1;
			zoomed = false;
		}
		
		//I added a timer to this function because it is mainly used after you complete an objective like making a bucket
		//or killing a shark. I wanted there to be a slight delay so you can actually see what is going on with the cannonball
		//before snapping back to the default position
		public static function FollowDefault():void
		{		
			CameraTarget = "Default";					
		}
		
		private static function ChaseFocusPoint():void
		{
			Main.m_sprite.x =  -(FocusPoint.x) + (Main.m_stage.stageWidth * .9);
			Main.m_sprite.y = 100;
		}
		
		private static function ChaseDefault():void
		{						
			Main.m_sprite.x= ((Main.m_stage.stage.stageWidth ) / 2.5) - (DefaultTarget.GetBody().GetPosition().x * GameWorld.pixels_per_meter);
			
			//make sure we can't see past the background
			Main.m_sprite.y = 100;
			Main.m_sprite.x -= 250;
		}
		
		private static function ChaseTarget():void
		{
			if (!stopCamera && OtherTarget.GetBody().IsActive())
			{
				//if the target is in the bounds, follow it, else, snap to the ship
				if (((OtherTarget.GetBody().GetPosition().x * GameWorld.pixels_per_meter) < 2500) && ((OtherTarget.GetBody().GetPosition().x * GameWorld.pixels_per_meter) > -400))
				{
					Main.m_sprite.y = 100;
					//Main.m_sprite.x = (Main.m_stage.stage.stageWidth  / 2) - ((OtherTarget.GetBody().GetPosition().x * GameWorld.pixels_per_meter)  * .7);
					Main.m_sprite.x -= OtherTarget.GetBody().GetLinearVelocity().x / 2;// * GameWorld.pixels_per_meter;
					
					//handle the arrow for if the ball leaves the screen
					if ((OtherTarget.GetBody().GetPosition().y * GameWorld.pixels_per_meter) < -100)
					redArrow.visible = true;
					else
					redArrow.visible = false;
					
					redArrow.x = (OtherTarget.GetBody().GetPosition().x * GameWorld.pixels_per_meter);
					redArrow.y = -Main.m_sprite.y + 30;
				}
				else
				redArrow.visible = false;
			}
		}		
		
		public static function GetPosition():Point
		{
			var r:Point = new Point(0,0);
			
			switch(CameraTarget)
			{
				case "Default":
					r.x = (Main.m_sprite.stage.stageWidth / 2.5) - (DefaultTarget.GetBody().GetPosition().x * GameWorld.pixels_per_meter);
					break;
				case "Other":
					r.x = (Main.m_sprite.stage.stageWidth / 2) - (OtherTarget.GetBody().GetPosition().x * GameWorld.pixels_per_meter);
					break;
			}
			
			return r;
		}
		
		public static function GetTargetPosition():Point
		{
			var r:Point = new Point(0, 0);
			if(OtherTarget)
			r.x = (Main.m_sprite.stage.stageWidth / 2) - (OtherTarget.GetBody().GetPosition().x * GameWorld.pixels_per_meter);
			return r;
		}
		
		public static function SetPanLocked(s:Boolean):void
		{
			panLocked = s;
		}
		
		public static function GetCurrentState():String
		{
			return CameraTarget;
		}
		public static function destroy():void
		{
			ResetScale();
			Main.m_sprite.removeEventListener(Event.ENTER_FRAME, handleEnter);			
		}
	}
}