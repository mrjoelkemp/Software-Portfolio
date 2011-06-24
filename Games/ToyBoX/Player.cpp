#include "Player.h"

Player::Player(IrrlichtDevice *device, IAnimatedMeshSceneNode *m) : GameEntity(device)
{
	health = 100;
	armor = 0;
	model = 0;
	fpsCamera = 0;
	weaponManager = 0;
	headsUpGUI = 0;
	collisionAnimator = 0;

	/*** Set up Camera Stuff ***/
	fpsCamera = new FPSCamera(device);

	/*** Set up Player Mesh ***/
	if(m) 
	{
		model = m;
		//Set up the triangle selector for the player mesh model
		ITriangleSelector *selector = smgr->createOctTreeTriangleSelector(model->getMesh(), model);
		if(selector)
		{
			model->setTriangleSelector(selector);
			selector->drop();
		}
	}

	///*** Set up Player Weapons ***/
//	weaponManager = new WeaponManager(device);
	
	/*** Set up Player HUD ***/
	headsUpGUI = new HeadsUpGUI(device);
}

void Player::Update()
{
	if(health == 0) this->Die();

	/*
	if(weaponManager)
		weaponManager->Update();
	if(headsUpGUI)
		headsUpGUI->Update(activeWeapon->GetAmmoCount(), health);
	*/
}

void Player::CreateCollisionRelationships(IMetaTriangleSelector *metaSelector, vector3df gravity)
{
	collisionAnimator = smgr->createCollisionResponseAnimator(
				metaSelector,				//The Collision Pool
				fpsCamera->GetCamera(),		//The Player's Scene Node
				vector3df(25,35,10),		//Ellipsoid Radius
				gravity,					//Gravity
				vector3df(0,30,0),			//Ellipsoid Translation
				0.005f);					//Sliding Value
	
	fpsCamera->GetCamera()->addAnimator(collisionAnimator);
	//collisionAnimator->drop();
}

void Player::SetHUDVisibility(bool value)
{
	if(headsUpGUI) headsUpGUI->SetVisible(value);
}//end SetHUDVisibility()

void Player::SetGravity(vector3df gravityVector)
{
	//Set the new collision vector
	collisionAnimator->setGravity(gravityVector);
	//Remove the outdated response animator
	fpsCamera->GetCamera()->removeAnimator(collisionAnimator);
	//Set the new collision response animator
	fpsCamera->GetCamera()->addAnimator(collisionAnimator);

	//TODO: If player is falling, make descent slower.
	if(collisionAnimator->isFalling())
	{
		ISceneNodeAnimator* anim = smgr->createFlyStraightAnimator(fpsCamera->GetPosition(), vector3df(0,-100, 0), 1000, false);
		fpsCamera->GetCamera()->addAnimator(anim);
		
		anim->drop();

	}

}//end SetGravity()

void Player::Shoot()
{
	//TODO: Implement Bullets & Collision Detection
	
	//You can only shoot if you're in first person mode
//	if(GetActiveCamera() == cameraList[FPS_CAMERA])
		//Tell the active weapon to shoot
//		activeWeapon->Shoot(fpsCamera->GetTarget(), fpsCamera->GetFarValue());

	//Get trajectory from camera
	//vector3df start = camera->GetPosition();
}

void Player::Die()
{}

void Player::DecreaseHealth(s32 damagePoints)
{
	//If there is no armor left
	if(armor == 0)
	{
		//Directly decrease the health points
		health -= damagePoints;
		if (health <= 0)
		{
			//Set health to 0 (if less than 0)
			health = 0;
			//Trigger death sequence
			Die();
		}
	}
	//If the player still has armor points
	else if (armor > 0)
	{
		armor -= damagePoints;
		//If the damage exceeds the armor
		if(armor < 0)
		{
			/*
			Note: 
				The armor should be negative,
				which contains the difference
				that should be decreased from
				the health.
			*/
			health -= armor;
			
			//Reset armor points
			armor = 0;
		}
	}
}//end DecreaseHealth()

void Player::IncreaseHealth(s32 healthIncrease)
{
	health += healthIncrease;
	//Health upper bound
	if(health >= 100)
		health = 100;
}//end IncreaseHealth()

void Player::IncreaseArmor(s32 armorIncrease)
{
	armor += armorIncrease;
	//Armor upper bound
	if(armor >= 100)
		armor = 100;
}//end IncreaseArmor()

bool Player::OnEvent(const SEvent& event)
{
	if ((event.EventType == EET_KEY_INPUT_EVENT && event.KeyInput.Key == KEY_SPACE && event.KeyInput.PressedDown == false) || 
		(event.EventType == EET_MOUSE_INPUT_EVENT && event.MouseInput.Event == EMIE_LMOUSE_LEFT_UP))
	{
		//printf("I'm Supposed to be shooting retard!\n");
		
		//Shoot a bullet
		//Shoot();
		return true;
	}
	else
		//Pass the event off to the camera.
		fpsCamera->GetCamera()->OnEvent(event);

	return false;
}//end OnEvent()

Player::~Player()
{
	//TODO: Fix this memory leak...
	//if(collisionAnimator)
	//	collisionAnimator->drop();

	if(fpsCamera)
		delete fpsCamera;
			
	if(headsUpGUI)
		delete headsUpGUI;
	

		
	printf("Player Deleted \n");
}
