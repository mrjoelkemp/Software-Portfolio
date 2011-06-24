#include "Player.h"

Player::Player(s32 planeId, vector3df position, 
			   vector3df rotation, 
			   IrrlichtDevice *device)
{
	this->device = device;

	//Create an instance of the airplane Factory
	//that will handle creating a specific airplane
	//at runtime.
	AirplaneFactory *factory = new AirplaneFactory();

	//Set the player as the plane based on the planeId
	//airplane = factory->Create(planeId, position, rotation, device);
	airplane = factory->Create(planeId, position, rotation, device);
	
	if(factory)
		delete factory;

	playerPosition = airplane->GetPosition();
	playerRotation = airplane->GetRotation();

	//Set up the limits of rotation for the player
	rotationUpLimit = playerRotation.X + 30.0f;
	rotationDownLimit = playerRotation.X - 30.0f;
	rotationLeftLimit = playerRotation.Z + 25.0f;
	rotationRightLimit = playerRotation.Z - 25.0f;

}

void Player::CreateHUD()
{
	headsUpDisplay = new HUD(device);
}

void Player::Update()
{
	playerPosition = airplane->GetPosition();
	playerRotation = airplane->GetRotation();
	
	//Update player position based on plane speed
	playerPosition.Z += airplane->GetSpeed();

	/* Update player position based on rotation */

	//If rotation is in negative X direction (to the right)
	if(playerRotation.Z >= -45.0f && playerRotation.Z < 0)
		//Keep moving player to the right
		playerPosition.X += -playerRotation.Z / 5.0f;
	
	if(playerRotation.Z <= 45.0f && playerRotation.Z > 0)
		//Keep moving player to the left
		playerPosition.X -= playerRotation.Z / 5.0f;

	if(playerRotation.X >= -45.0f && playerRotation.X < 0)
		//Keep moving player downwards
		playerPosition.Y += -playerRotation.X / 5.0f;		//-playerRotation.Z will make the negative rotation value positive

	if(playerRotation.X <= 45.0f && playerRotation.X > 0)
		//Keep move player upwards
		playerPosition.Y  -= playerRotation.X / 5.0f;

	//Set the new position
	airplane->SetPosition(playerPosition);
}
bool Player::OnEvent(const irr::SEvent &event)
{
	//If the event is from the keyboard -- Modify Player
	if (airplane->GetMeshPointer() != 0 && event.EventType == EET_KEY_INPUT_EVENT)
	{
		//Store pointer to mesh so we can change its position
		IAnimatedMeshSceneNode *mesh = airplane->GetMeshPointer();

		playerPosition = airplane->GetPosition();
		playerRotation = airplane->GetRotation();
		playerSpeed = airplane->GetSpeed();

		switch(event.KeyInput.Key)
		{
			//Move airplane up
			case KEY_KEY_W:
				//If the plane hasn't hit its rotation limit
				if(playerRotation.X < rotationUpLimit)
					//Increase its rotation
					playerRotation.X += 5.0f;

				airplane->SetRotation(playerRotation);
				airplane->SetPosition(playerPosition + vector3df(0,0,+1));
				return true;
			
			//Move airplane down
			case KEY_KEY_S:
				if(playerRotation.X > rotationDownLimit)
					playerRotation.X -= 5.0f;

				airplane->SetRotation(playerRotation);
				airplane->SetPosition(playerPosition + vector3df(0,0,-1));
				return true;
			
			//Move the plane to left
			case KEY_KEY_A:
				if(playerRotation.Z < rotationLeftLimit)
					playerRotation.Z += 5.0f;

				airplane->SetRotation(playerRotation);
				return true;

			//Move plane right
			case KEY_KEY_D:
				if(playerRotation.Z > rotationRightLimit)
					playerRotation.Z -= 5.0f;

				airplane->SetRotation(playerRotation);
				return true;

			//Shoot
			case KEY_SPACE:
				//airplane->Shoot(1);
				return true;
			
			//Accelerate
			case KEY_CONTROL:
				//Player top speed = 5000
				if(playerSpeed <= 5000)
					//Increase player speed
					airplane->SetSpeed(++playerSpeed);
				return true;

			//Decelerate
			case KEY_RSHIFT:
				//Player can decelerate to a full stop
				if(playerSpeed >= 1)
					airplane->SetSpeed(--playerSpeed);
				return true;
			
			//Show pause menu
			case KEY_KEY_P:
				return true;

		}//end switch
	}//end if

	return false;
}//end OnEvent()

Player::~Player(void)
{
	if(headsUpDisplay)
		delete headsUpDisplay;
	if(name)
		delete [] name;
	if(airplane)
		delete airplane;
}