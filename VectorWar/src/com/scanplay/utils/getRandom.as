package com.scanplay.utils 
{	
	public function getRandom(high:Number, low:Number):Number
	{
		return (Math.floor(Math.random() * (high - low)) + low);
	}
}