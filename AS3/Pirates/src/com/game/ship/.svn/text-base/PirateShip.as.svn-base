package com.game.ship 
{
	import Box2D.Dynamics.*;
	import com.core.util.Utilities;
	import com.menu.menu.SpeechScript;
	import com.physics.blocks.PhysicsObject;
	import com.core.*;
	import com.core.factory.*;
	import com.core.user.*;
	import com.game.*;
	import com.game.*;
	import com.game.fx.*;
	import com.game.ship.weapon.*;
	import com.game.ui.*;
	import com.physics.GameWorld;
	import flash.display.*;
	import com.core.factory.SoundFactory;
	import flash.events.*;
	import flash.geom.*;
	import flash.utils.*;
	import mochi.as3.MochiCoins;
	/**
	 * ...
	 * @author ScanPlay Games
	 */
	public class PirateShip extends PhysicsObject
	{
		//bits of the ship
		public static var hull:Hull;		
		private var smoke:Smoke;
		
		//the current cannon weapon
		public static var pirate:Sprite;
		public static var currentWeapon:String;
		
		//cannon vars		
		public static var power:Number    = 10;
		private static var speed:Number   = .008;
		public static var maxPower:Number = 40;
		public static var minPower:Number = 10;
		
		//state variables
		private static var state:String;
		public static var clickState:String;
		public static var tutorialRunning:Boolean;
		
		//cannon position and other cannon stuff
		public static  var guide:CannonGuide;		
		public static var lastShot:Weapon; //store the last shot fired
		
		//movie clip for the ship
		private static var cannonMC:Sprite;
		private static var cannonGlobalPos:Point;
		private static var cannonBlock:Sprite;
		public static var cannonReady:Boolean; //for locking the cannon between shots and preventing multiclicks accidentally
		public static var shootingLocked:Boolean; //for locking the cannon when ammo is done
		
		//set the angle of the cannon
		private var cannonLoc:Point;
		private static var waterPool:Sprite;
		
		//tracks whether or not a powerup has been used
		private static var powerupUsed:Boolean;
		
		//dont even ask
		private static var level12Skip:Boolean;
		
		public function PirateShip(_p:Point) 
		{
			super();
			//set the vars
			state = "idle";
			cannonReady = false;
			level12Skip = false;
			clickState = "focuspoint";
			currentWeapon = UserData.GetCurrentWeapon();			
			shootingLocked = false;
			powerupUsed = false;
			
			//create the ship
			guide = new CannonGuide();
			hull = new Hull(50, 20);
			
			var bodyDef:b2BodyDef = new b2BodyDef();
			bodyDef.type = b2Body.b2_dynamicBody;			
			bodyDef.position.Set(_p.x / GameWorld.pixels_per_meter,( _p.y + 50) / GameWorld.pixels_per_meter);
			body = GameWorld.m_world.CreateBody(bodyDef);
			
			//add the objects
			body = GameWorld.m_world.CreateBody(bodyDef);
			body.CreateFixture2(hull.polyShape, 1);
			
			Water.AddFloatingBody(body);
			
			//create the graphics			
			if(UserData.CoinCount() < 21)
			skin = AssetFactory.GetSprite("PirateShip");
			else
			skin = AssetFactory.GetSprite("BlackShip");
				
			cannonMC = AssetFactory.GetSprite("CannonBarrel");
			waterPool = AssetFactory.GetSprite("WaterPool");
			cannonBlock = AssetFactory.GetSprite("CannonBlock");			
			
			//disable mouse
			skin.mouseEnabled = false;
			cannonMC.mouseEnabled = false;
			waterPool.mouseEnabled = false;
			cannonBlock.mouseEnabled = false;
			skin.mouseChildren = false;
			cannonMC.mouseChildren = false;
			waterPool.mouseChildren = false;
			cannonBlock.mouseChildren = false;
			
			skin.scaleX = .2;
			skin.scaleY = .2;
			skin.addChild(cannonMC);
			cannonMC.x += 80;
			cannonMC.y += 170;
			
			waterPool.scaleX = waterPool.scaleY = skin.scaleX;
			skin.addChild(cannonBlock);
			skin.x = cannonBlock.x;
			skin.y = cannonBlock.y;			
			cannonBlock.x = cannonMC.x;
			cannonBlock.y = cannonMC.y + 15;
			
			Main.m_sprite.addChild(waterPool);
			Main.m_sprite.addChild(skin);
			
			//make sure everything is in place before the camera sees it...
			UpdatePosition();
			skin.y +=  ((skin.height) / 2) - GameLevel.GridSize;
			
			UpdatePosition();	
			if(tutorialRunning) AimCannon();
			
			//create the pirate
			if (Settings.pirateGender == "Female")
			{
				if(UserData.CoinCount() < 9)
				pirate = AssetFactory.GetSprite("FemalePirate");
				else
				pirate = AssetFactory.GetSprite("BlackFemalePirate");
				
				pirate.scaleX = pirate.scaleY = .65;
				pirate.scaleX = -.65;
				skin.addChild(pirate);
				pirate.x = -150;
				skin.setChildIndex(pirate, 0);
			}
			else
			{
				pirate = AssetFactory.GetSprite("MalePirate");
				pirate.scaleX = pirate.scaleY = .47;
				skin.addChild(pirate);
				pirate.x = -130;
				skin.setChildIndex(pirate, 0);				
			}
								
			pirate.mouseEnabled = false;
			
			//listeners
			Main.m_sprite.addEventListener(Event.ENTER_FRAME, Update);
			Main.m_sprite.addEventListener(MouseEvent.MOUSE_DOWN, handleDown);
			Main.m_sprite.addEventListener(MouseEvent.MOUSE_UP, handleUp);
			Main.m_stage.addEventListener(Event.ACTIVATE, handleActivate);
			Main.m_stage.addEventListener(Event.DEACTIVATE, handleActivate);
			Main.m_stage.addEventListener(Event.MOUSE_LEAVE, handleActivate);
		}
		
		private function handleActivate(e:* = null):void
		{
			if (clickState == "focuspoint")
			{							
				Camera.PanToDefault();								
				MessageFactory.HideAll();												
				LevelUI.ShowUI();
				cannonReady = true;
				clickState = "idle";	
				//Handle Tutorials Here
				LoadTutorials();
			}
			else clickState = "idle";
			
			power = minPower;
			cannonReady = true;
			shootingLocked = false;
			guide.wipeGuide();
		}
	
		//grant the player use of a powerup this level
		private function CheckPowerups():void
		{
			//give the player an explosive cannonball powerup this level
			if (User.GetLogInStatus())
			{
				if (MochiCoins.inventory["Cannonball_Explosive"] > 0 && (!powerupUsed))
				{
					powerupUsed = true;
					MochiCoins.inventory["Cannonball_Explosive"]--;
					currentWeapon = "Cannonball_Explosive";
					WeaponIndicator.ActivatePowerup("Cannonball_Explosive");
				}
			}
		}
		
		protected override function Update(e:Event):void
		{
			if (GameLevel.isStarted() && !tutorialRunning)
			{
				//update the position
				UpdatePosition();	
				AimCannon();
							
				//check to see if the player has bought a powerup
				CheckPowerups();
				
				//make sure the pool is always the same angle opposite the ship
				waterPool.rotation = -body.GetAngle() * (180 / Math.PI);
				
				if (clickState == "charging" && cannonReady) ChargeCannon();
				
				/*
				if ((clickState == "backtoship") && (clickState != "focuspoint"))
				LevelUI.backToShip.visible = true;
				else
				LevelUI.backToShip.visible = false;		*/		
				
				//check to see if the current cannon ball we are following has been lost, reset
				//the camera if it has						
				if ((lastShot) && lastShot.GetState() == "asleep")
				GameController.HandleEvent("BackToShip");
				
				if (clickState == "panningback" && Camera.GetCurrentState() == "Default")
				clickState = "idle";
			}			
			
			//auto start the level on levels 1-2
			if (GameLevel.levelID <= 2 && !level12Skip)
			{				
				level12Skip = true;
				Camera.PanToDefault();								
				MessageFactory.HideAll();												
				LevelUI.ShowUI();
				//LevelUI.parText.visible = false;
				cannonReady = true;
				clickState = "idle";
			}
		}
		
		private function handleDown(e:MouseEvent):void
		{
			if (GameLevel.isStarted())
			{
				switch(clickState)
				{
					case "idle":
						if (cannonReady)
						{
							Camera.SetPanLocked(false);
							clickState = "charging";	
						}
						break;
					case "focuspoint":
						if (GameLevel.isStarted() && !GameLevel.upgradeScrenShowing)
						{										
							//Camera.ResetScale();
							Camera.PanToDefault();								
							MessageFactory.HideAll();												
							LevelUI.ShowUI();
							cannonReady = true;
							clickState = "panningback";	
							LoadTutorials();
						}
						break;
					case "backtoship":
						GameController.HandleEvent("PanBackFromShot");
						break;
					case "panningback":
						GameController.HandleEvent("SnapCameraToShip");
						break;
				}
			}
		}
		
		//a function that loads tutorials at the right times
		private function LoadTutorials():void
		{			
			if (!SpeechScript.HasScriptBeenLoaded("Level_ " + GameLevel.levelID + "_Tutorial") && GameLevel.gameType == "Adventure")
			{				
				tutorialRunning = true;
				Camera.SetPanLocked(true);
							
				switch(GameLevel.levelID)
				{	
					case 6:
					case 7:
					case 8:
					case 9:
					case 10:
					case 11:
					case 12:
					case 13:
					case 14:
					case 15:
					case 16:
					case 17:
					case 18:
					case 19:
					case 5:
					case 20:
						Camera.SetPanLocked(false);
						PirateShip.tutorialRunning = false;
						break;
					default:
						if (!SpeechScript.HasScriptBeenLoaded("Level_" + GameLevel.levelID + "_Tutorial"))
						GameController.HandleEvent("LoadScript", "Level_" + GameLevel.levelID + "_Tutorial");
						else
						{
							Camera.SetPanLocked(false);
							PirateShip.tutorialRunning = false;							
						}
						break;
				}
				
				//HACK AWFUL BAD EVIL HACK
				if (GameLevel.levelID > 40)
				{
					Camera.SetPanLocked(false);
					PirateShip.tutorialRunning = false;		
					
				}
			}			
		}
		
		private function handleUp(e:MouseEvent):void
		{			
			switch(clickState)
			{
				case "charging":		
					fireCannon();
					break;
			}
		}
		
		public override function handleCollission(object:PhysicsObject, f:Number):void
		{		
		}
		
		public function AimCannon():void
		{
			cannonLoc = new Point(skin.x, skin.y);
			cannonLoc.x += 20;
			cannonLoc.y += 35;
			var dx:Number = Main.m_sprite.mouseX - cannonLoc.x;
			var dy:Number = Main.m_sprite.mouseY - cannonLoc.y;
			var cAngle:Number = -Math.atan2(dy, dx) * (180 / Math.PI);
			
			if (cAngle > 90)
			cAngle = 90;
			
			if (cAngle < 0)
			cAngle = 0;
			
			if (cAngle < 90 && cAngle > 0)
			{
				cannonMC.rotation = -cAngle + 18;
				guide.SetPosition(cannonLoc);
				guide.UpdateRotation(cAngle);
			}
			
		}
		
		
		/*
		 * POSITION UPDATERS
		 * 
		 * 
		 */
		
		 //for sticking the cannon to the ship
		//setting the aiming values for the cannon		
		private function UpdatePosition():void
		{			
			//Update the position of the Sprite for the ship
			skin.x  = (body.GetPosition().x * GameWorld.pixels_per_meter) - (skin.width / 2) + 100 ;
			skin.y =  (body.GetPosition().y * GameWorld.pixels_per_meter) - (skin.height / 2) ;
			skin.rotation = (body.GetAngle() * (180 / Math.PI));			
			
			waterPool.x = skin.x;
			waterPool.y = skin.y;
		}
		
		/*
		 * CHARGE THE CANNON
		 * 
		 */ 
		
		private  function ChargeCannon():void
		{					
			if (!shootingLocked && cannonReady)
			{		
				//force the camera to follow the ship during charging
				Camera.FollowDefault();
				//set the charge on the cannon
				if( power < maxPower)
				power += .7; 

				//animated the guide based on cannon charge
				guide.Charge(power, maxPower);
			}
		}
		
		//different cannon firing modes...
		private var cb:Weapon;
		
		private function fireCannon():void
		{				
			if (!shootingLocked && !tutorialRunning)
			{			
				Camera.SetPanLocked(true);
				PowerBar.SetFireLine();
				
				if (Camera.stopCamera)				
				Camera.stopCamera = false;
				
				var shotAngle:Number = -guide.angle;
				
				GameLevel.shotsFired++;
				SoundFactory.PlaySound("CannonBlast_1");
						
				switch(currentWeapon)
				{
					case "Cannonball_Rubber":	
						cb = new RubberShot(cannonLoc, shotAngle, power); 
						break;
					case "Cannonball_Explosive":	
						cb = new ExplosiveShot(cannonLoc, shotAngle, power); 
						break;							
					case "Cannonball_Triple":								
						var cb1:CannonBall = new CannonBall(cannonLoc, shotAngle + 15, power, false); 
						cb = new CannonBall(cannonLoc, shotAngle, power); 
						var cb3:CannonBall = new CannonBall(cannonLoc, shotAngle - 15, power,false); 						
						break;
					case "Cannonball_Standard":
						//15 % chance of an explosive shot
						if (Utilities.GetRandomNumberInARange(100, 0) < 15 && ((UserData.CoinCount() > 9) && (UserData.CoinCount() < 21)))
						{							
							cb = new ExplosiveShot(cannonLoc, shotAngle, power); 
						}
						//do a dice roll to see if we randomly fire an explosive cannonball
						else if(Utilities.GetRandomNumberInARange(100, 0) < 40 && ((UserData.CoinCount() >= 21) &&(UserData.CoinCount() < 31)))
						{
							cb = new ExplosiveShot(cannonLoc, shotAngle, power); 
						}
						else if (Utilities.GetRandomNumberInARange(100, 0) < 60 && (UserData.CoinCount() >= 31))
						{
							cb = new ExplosiveShot(cannonLoc, shotAngle, power); 
							
							//make it a triple shot randomly
							if (Utilities.GetRandomNumberInARange(100, 0) < 30)
							{
								var cb4:ExplosiveShot = new ExplosiveShot(cannonLoc, shotAngle + 15, power); 								
								var cb5:ExplosiveShot = new ExplosiveShot(cannonLoc, shotAngle - 15, power); 		
							}
						}
						else if ((UserData.CoinCount() == 50))
						{
							cb = new ExplosiveShot(cannonLoc, shotAngle, power); 
							var cb6:ExplosiveShot = new ExplosiveShot(cannonLoc, shotAngle + 15, power); 								
							var cb7:ExplosiveShot = new ExplosiveShot(cannonLoc, shotAngle - 15, power); 							
						}
						else
						cb = new CannonBall(cannonLoc, shotAngle, power); 
						break;
				}
				
				//wipe the last shot and keep the result
				if(lastShot)
				lastShot.ClearGuide();
				
				smoke = new Smoke(cannonLoc);
				
				//set the targeting
				lastShot = cb;						
				Camera.SetNewTarget(lastShot);
				
				power = minPower;				
				body.ApplyTorque( -20);
				
				guide.wipeGuide();
				clickState = "backtoship";
				ShotCounter.RemoveShot();
				//make sure there is a pause between the next shot
				cannonReady = true;
			}
		}
		
		public override function Destroy(_noScore:Boolean = false):void
		{
			Main.m_sprite.removeEventListener(Event.ENTER_FRAME, Update);
			Main.m_sprite.removeEventListener(MouseEvent.MOUSE_DOWN, handleDown);
			Main.m_sprite.removeEventListener(MouseEvent.MOUSE_UP, handleUp);
			Main.m_stage.removeEventListener(Event.ACTIVATE, handleActivate);
			Main.m_stage.removeEventListener(Event.DEACTIVATE, handleActivate);
			Main.m_stage.removeEventListener(Event.MOUSE_LEAVE, handleActivate);
			
			AssetFactory.DestroySprite(skin);
			AssetFactory.DestroySprite(cannonMC);
			AssetFactory.DestroySprite(waterPool);
			skin = null;
			cannonMC = null;
			guide = null;
			state = "idle";
			clickState = "focuspoint";
		}		
	}
}