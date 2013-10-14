package Lib.Game.Creature 
{
	/**
	 * ...
	 * @author ScanPlayGames
	 */
	
	import com.scanplay.utils.getRandom;
	
	import Lib.Game.Creature.Creature;
	
	public class CreatureFactory
	{
		public var creatures:Array;
		
		public function CreatureFactory() 
		{
			creatures = new Array();
			
			var barista:Barista = new Barista();
			var badsanta:BadSanta = new BadSanta();
			var jobs:Jobs = new Jobs();
			var greeter:Greeter = new Greeter();
			var fats:Fats = new Fats();
			var hottopic:HotTopic = new HotTopic();
			var hilton:Hilton = new Hilton();
			
			creatures.push(barista);
			creatures.push(jobs);
			creatures.push(hilton);
			creatures.push(greeter);
			creatures.push(hottopic);
			creatures.push(fats);
			creatures.push(badsanta);
		}
		
		public function getCreatureByName(cName:String):Creature
		{
			var creat:Creature;
			
			for (var g:* in creatures)
			{
				if (creatures[g].creatureName == cName)
				{
					creat = creatures[g];
				}
			}
			return creat;
		}
		
		//gets a random creature within a certain range
		public function getConstrainedRandomCreature(hi:int):Creature
		{
			return getNewCreatureByName(creatures[getRandom(hi, 0)].creatureName);	
		}
		
		
		public function getRandomCreature():Creature
		{
			return getNewCreatureByName(creatures[getRandom(creatures.length, 0)].creatureName);			
		}
		
		public function getNewCreatureByName(cName:String):Creature
		{
			var c:Creature;
			
			switch(cName)
			{
				case "Barista":
						c = new Barista();
						break;
				case "Fats":
						c = new Fats();
						break;
				case "Jobs":
						c = new Jobs();
						break;
				case "HotTopic":
						c = new HotTopic();
						break;
				case "Hilton":
						c = new Hilton();
						break;
				case "BadSanta":
						c = new BadSanta();
						break;
				case "Greeter":
						c = new Greeter();
						break;
			}
			
			c.init();
			return c;
		}
		
	}

}