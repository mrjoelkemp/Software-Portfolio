class Background extends MovieClip
{
	function onEnterFrame()
	{
		//Move the background downwards
		_y = _y + 1;
		
		//Bounds checking
		if(_y == 600)
			_y = 0;
	}
}