class Player extends MovieClip
{
	var health;
	var score;
	var bullets;
	var speed;
	var playerWidth, playerHeight;
	var bulletTimer;		//Used to give a pause between shots
	
	function onLoad()
	{
		health = 100;
		score = 0;
		bullets = [];
		speed = 7;
		//Vars to keep track of graphic dimensions
		playerWidth = 60;
		playerHeight = 60;
		bulletTimer = 0;
		
		//Create test enemy in middle of the screen
		var stinger = _root.attachMovie("Stinger","Stinger" + _root.getNextHighestDepth(),_root.getNextHighestDepth());
		stinger._x = 50;
		stinger._y = 300;
		
		var eyeder = _root.attachMovie("EyeDer","EyeDer" + _root.getNextHighestDepth(),_root.getNextHighestDepth());
		eyeder._x = 250;
		eyeder._y = 300;
		
		var seenoevil = _root.attachMovie("SeeNoEvil","SeeNoEvil" + _root.getNextHighestDepth(),_root.getNextHighestDepth());
		seenoevil._x = 150;
		seenoevil._y = 200;
	}
	
	function onEnterFrame()
	{
		//Increase counter for bullet timer
		bulletTimer++;
		
		//Check for keyboard input
		checkKey();
		
	}
	
	//Checks if a key has been pressed then handles it.
	function checkKey()
	{
		//Note: width of player graphic is 60 pix
		
		//Move right
		if(Key.isDown(Key.RIGHT) && _x <= 400-playerWidth)
			_x += speed;
		//Move Left
		if(Key.isDown(Key.LEFT) && _x >= 0)
			_x -= speed;
			
		//Move up
		if(Key.isDown(Key.UP) && _y >= 0)
			_y -= speed;
			
		//Move down
		if(Key.isDown(Key.DOWN) && _y <= 600-playerHeight)
			_y += speed;
			
		if(Key.isDown(Key.SPACE))
			shoot();
		
	}
	
	//Shoots an instance of the player's bullet
	function shoot()
	{
		//Bullets fire 1 second apart
		if(bulletTimer >= 8)
		{
			var bullet = _root.attachMovie("PlayerBullet" , "PlayerBullet" + _root.getNextHighestDepth(), _root.getNextHighestDepth());
			//The +11 gives a better X offset
			bullet._x = this._x + 11;
			//PlayerHeight - 10 gives a better feel of the bullet's origin
			bullet._y = this._y - (playerHeight - 10);
			
			bulletTimer = 0;
		}
	}
	
}