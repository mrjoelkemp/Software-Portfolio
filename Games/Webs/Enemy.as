class Enemy extends MovieClip
{
	var health;
	var speed;
	var enemyWidth, enemyHeight;
	var pointValue;
	
	//Simulate an enemy's death at the position passed in.
	static function explode(xPos,yPos)
	{
		var explosion = _root.attachMovie("EnemyExplosion","EnemyExplosion" + _root.getNextHighestDepth(),_root.getNextHighestDepth());
		explosion._x = xPos;
		explosion._y = yPos;
	}
	
	//Check if the enemy's health is 0; if so, then explode.
	static function isHealthZero(healthVal)
	{
		if(healthVal <= 0)
			return true;
		else return false;
	}
	
	//Update the enemy's health points
	function updateHealth(v)
	{
		health += v;
	}
}