class EyeDer extends Enemy
{
	function onLoad()
	{
		health = 100;
		pointValue = 20;
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