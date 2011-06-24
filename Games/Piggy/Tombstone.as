class Tombstone extends MovieClip
{
	var timer;
	function onLoad()
	{
		timer = 0;
	}
	
	function onEnterFrame()
	{
		timer++;
		if(timer >= 150)
			this.removeMovieClip();
	}
}