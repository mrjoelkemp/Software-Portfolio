class SeeNoEvil extends Enemy
{
	function onLoad()
	{
		health = 100;
		pointValue = 50;
		speed = 2;
		enemyWidth = 60;
		enemyHeight = 60;
	}
	
	function onEnterFrame()
	{
		if(isHealthZero(health))
		{
			explode(_x,_y);
			this.removeMovieClip();
		}
	}
}