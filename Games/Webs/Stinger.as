class Stinger extends Enemy
{
	function onLoad()
	{
		pointValue = 10;
		health = 100;
		speed = 5;
		enemyWidth = 60;
		enemyHeight = 60;
	}
	
	function onEnterFrame()
	{
		//Check if you're dead/supposed to explode
		if(isHealthZero(health))
		{
			explode(_x,_y);
			this.removeMovieClip();			
		}
	}
	
	
	
}