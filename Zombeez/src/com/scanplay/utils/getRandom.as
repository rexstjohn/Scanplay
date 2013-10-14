package com.scanplay.utils 
{	
	public function getRandom(high:int, low:int):Number
	{
		return (Math.floor(Math.random() * (high - low)) + low);
	}
}