package com.core.util 
{
	import Box2D.Common.Math.b2Vec2;
	import com.physics.blocks.PhysicsObject;
	import com.physics.blocks.Polygon2D;
	import com.core.*;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import com.game.GameObject;
	import flash.utils.getQualifiedClassName;
	import com.physics.GameWorld;
	import flash.events.*;
	/**
	 * ...
	 * @author ScanPlay Games
	 */
	public class Utilities
	{
		
		public static function CenterObject(o:DisplayObject):void
		{
			o.x += o.width / 2;
			o.y += o.height / 2;
		}
		
		
		public static function perspectiveDistort(target:Sprite, centerX:Number, yPosition:Number, frameWidth:Number, frameHeight:Number ):void
        {
            /*     grab the transformation matrix from our content. Remember that the transformation is copy on read...meaning that when
            *    you ask for the matrix, you're getting a copy. Which means any changes we make will only have an effect if we assign
            *    the matrix back to the transform when we're done.
            */
			
            var m:Matrix = target.transform.matrix;
			var _verticalShear:Number = 5;
			var _horizontalScale:Number = 5;
			var horizontalScale:Number = 1;
			var _verticalShearEffect:Number = 1;
			var _mask:Sprite = new Sprite();
			
            /*    set the shear and horizontal scale to get the basic 3D effect
            */    
            m.b = _verticalShear;
            m.a = _horizontalScale;
            /*     position the content.  we want it centered horizontally. vertically, we want it to look as though it's at yPosition, but 
            *    with 3D perspective.  So we need to offset by the effect of the shearing.
            */
            m.tx = centerX - frameWidth/2 * _horizontalScale;
            m.ty = yPosition - _verticalShearEffect;

            /* make sure our changes actually affect it! */
            target.transform.matrix = m;
            
            /*     shearing is only half the faux 3d effect. We also need to turn our content into a trapezoid, to make it look like it's 
            *    receeding into the distance. To do that, we'll draw a trapezoid into our mask shape, which will clip the content.
            */
            
            // first clear out any previous graphics.
            _mask.graphics.clear();
            // now begin a fill. It actually doesn't matter what kind of fill we use here, since masks are not visible on screen. But
            // we do need _some_ fill.            
            _mask.graphics.beginFill(0,0);
            // and draw our trapezoid
           // drawPerspectiveFrame(_mask.graphics,centerX,yPosition,frameWidth, frameHeight);
            _mask.graphics.endFill();
        }
		
		public static function IsInside(a:Polygon2D, b:PhysicsObject):Boolean
		{
			var centroid:Point = a.GetPosition();
			var farthestDistance:Number = 0;
			var isContained:Boolean  = false;
			
			for each(var v:b2Vec2 in a.vertices)
			{
				//find the farthest point between the vertices and the polygon's centroid
				if (GetDistanceInPixels2(centroid, new Point(v.x,v.y)) >= farthestDistance)
				{
					farthestDistance = GetDistanceInPixels2(centroid, new Point(v.x,v.y));
				}
			}
			
			//next, see if the distance between b and a is less than the smallest distance
			if ( GetDistanceInPixels2(centroid, b.GetPosition()) <= farthestDistance)
			{
				isContained = true;
			}
			
			return isContained;
				
		}
		
		public static function GetCentroid(vertices:Array):Point
		{
			var centroid:Point = new Point(0,0);
			var signedArea:Number = 0.0;
			var x0:Number = 0.0; // Current vertex X
			var y0:Number = 0.0; // Current vertex Y
			var x1:Number = 0.0; // Next vertex X
			var y1:Number = 0.0; // Next vertex Y
			var a:Number = 0.0;  // Partial signed area

			// For all vertices except last
			var  i:int = 0;
			
			for (i=0; i < vertices.length - 1; i++)
			{
				x0 = vertices[i].x;
				y0 = vertices[i].y;
				x1 = vertices[i+1].x;
				y1 = vertices[i+1].y;
				a = x0*y1 - x1*y0;
				signedArea += a;
				centroid.x += (x0 + x1)*a;
				centroid.y += (y0 + y1)*a;
			}

			// Do last vertex
			x0 = vertices[i].x;
			y0 = vertices[i].y;
			x1 = vertices[0].x;
			y1 = vertices[0].y;
			a = x0*y1 - x1*y0;
			signedArea += a;
			centroid.x += (x0 + x1)*a;
			centroid.y += (y0 + y1)*a;

			signedArea *= 0.5;
			centroid.x /= (6*signedArea);
			centroid.y /= (6*signedArea);
			
			return centroid;
		}
			
		public static function GetRandomNumberInARange(high:Number, low:Number):Number
		{
			return Math.floor((Math.random() * (high - low)) + low);
		}
		
		public static function GetDistanceInPixels(objectA:PhysicsObject, objectB:PhysicsObject):Number
		{			
			var dy:Number = objectA.GetPosition().y - objectB.GetPosition().y;
			var dx:Number = objectA.GetPosition().x - objectB.GetPosition().x;
			var distance:Number = Math.sqrt(dx * dx + dy * dy);
			return distance;			
		}
		
		//for getting the distance between two points
		public static function GetDistanceInPixels2(p1:Point, p2:Point):Number
		{			
			var dy:Number = p1.y - p2.y;
			var dx:Number = p1.x - p2.x;
			var distance:Number = Math.sqrt(dx * dx + dy * dy);
			return distance;			
		}
		
		//for getting the distance between two points
		public static function GetAngleInRadians(p1:Point, p2:Point):Number
		{			
			var dy:Number = p1.y - p2.y;
			var dx:Number = p1.x - p2.x;
			var angle:Number = -Math.atan2(dy,dx);
			return angle;			
		}
	}

}