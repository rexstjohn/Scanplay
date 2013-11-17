package Lib.Game 
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.events.WeakMethodClosure;
	import com.scanplay.utils.getRandom;
	/**
	 * ...
	 * @author Rex
	 */
	public class GameController
	{
		public var gameModel:GameModel;
		
		public function GameController(gm:GameModel) 
		{
			gameModel = gm;
		}
		
		public function handleClicks(e:MouseEvent):void
		{
			switch(e.target.name)
			{
				case "BackToMap":
					gameModel.Update("BackToMap");
					break;				
				default:
					if (!gameModel.gameOver)
					{						
						if (e.target.Type != "InventoryItem")
						{
							fireWeapon();
						}						
					}
					break;
			}	
			
			function fireWeapon():void
			{
				//fire the weapon, decrement ammo
				if (gameModel.selectedInventoryItem.ammoLeft > 0)
				{
					gameModel.player.handleClicks(e); 					
				}
			}
			//set the lengths of the ammo bars
		}		
		
		public function handleEnter(e:Event):void
		{
			gameModel.updatePlayerHealth();
			gameModel.updateCreatureStates();
			gameModel.checkProjectileCollissions();
			gameModel.checkCreatureCollissions();
			gameModel.checkCreatureProjectileCollissions();
		}
		
		public function handleMove(e:MouseEvent):void
		{gameModel.player.handleMoves(e); }
		
		public function handleTimer(e:TimerEvent):void
		{
			createWave();				
		}		
		
		//logic for generating waves in a "fun" way
		public function createWave():void		
		{		
			
			var waveSize:int;
			
			switch(gameModel.SpeedSlider.difficulty)
			{
				case "Easy":
					waveSize = 2;
					break;
				case "Normal":
					waveSize = 3;
					break;
				case "Hard":
					waveSize = 5;
					break;
				case "Hardest":
					waveSize = 7;
					break;
			}
			
			//double the count for the last rush
			if (gameModel.ProgressBar.gameStage == "FinalRush")
			{
				waveSize *= 2;
			}
			//pick a random number of zombies to spawn
			for (var g:int = 0; g  < waveSize ; g++)
			{
				//prevent too many zombies frmo being spawned
				if (!((gameModel.creatureCount - 1) < 0))
				{				
					gameModel.createCreature();
				}
			}
			
		}
	}

}