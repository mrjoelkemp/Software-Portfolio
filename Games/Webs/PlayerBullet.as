class PlayerBullet extends MovieClip
{
	var speed;
	var isActive;
	var bulletWidth, bulletHeight;
	var damage;
	
	function onLoad()
	{
		speed = 10;
		damage = 10;
		//isActive = false;
		bulletWidth = 40;
		bulletHeight = 40;
		//this._visible = false;
	}
	
	function onEnterFrame()
	{
		//Travel upwards
		_y -= speed;
		
		//If bullet goes past the top screen bound
		if(_y < -bulletHeight)
			removeBullet();
					
		//Do collision checking with known enemies
		if(this.hitTest(_root.Stinger0))
		{
			_root.Stinger0.updateHealth(-damage);
			removeBullet();
		}
		else if(this.hitTest(_root.EyeDer1))
		{
			_root.EyeDer1.updateHealth(-damage);
			removeBullet();
		}
		else if(this.hitTest(_root.SeeNoEvil2))
		{
			_root.SeeNoEvil2.updateHealth(-damage);
			removeBullet();
		}
	}
	
	
	function removeBullet()
	{
		this.removeMovieClip();
	}
}