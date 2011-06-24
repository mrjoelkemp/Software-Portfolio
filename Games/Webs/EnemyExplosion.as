class EnemyExplosion extends MovieClip
{
	var explosionTimer;
	
	function onLoad()
	{
		explosionTimer = 0;
	}
	
	function onEnterFrame()
	{
		explosionTimer++;
		
		if(explosionTimer >= 5)
		{
			explosionTimer = 0;
			this.removeMovieClip();
		}
		//If you've played till completion, die.
		//if(this._currentframe == this._totalframes)
		//	this.removeMovieClip();
	}
}