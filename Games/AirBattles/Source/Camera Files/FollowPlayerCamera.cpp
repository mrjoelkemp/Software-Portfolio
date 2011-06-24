#include "FollowPlayerCamera.h"

FollowPlayerCamera::FollowPlayerCamera(IrrlichtDevice *device)
{
	this->device = device;
	this->smgr = device->getSceneManager();

	//Add a default camera scene node to the scene manager.
	camera = smgr->addCameraSceneNode();
	
	//Set the camera's default Point of View to third person.
	mode = 3;
	
	//Set the camera's initial distance away from the player.
	distanceFromTarget = vector3df(0,0,-150);

	//Set the camera's initial position; target's position plus a defined negative distance.
	//camera->setPosition(player->GetPosition() + distanceFromTarget);
	camera->setPosition(vector3df(0,0,0));
	camera->setFarValue(120000.0f);
	camera->setTarget(vector3df(0,0,100));

	//Set the camera's name for reference, if needed.
	camera->setName("FollowPlayerCamera");
}

void FollowPlayerCamera::Update()
{
	//Get the current player position
	if(player)
		playerPosition = player->GetPosition();

	//Check the camera mode and set its position accordingly.
	switch(mode)
	{
		case 1:		//first person
			camera->setPosition(playerPosition);
			break;
		case 3:		//third person
			camera->setPosition(playerPosition + distanceFromTarget);
			break;

	}//end switch

	//Set the camera's view target -- units outward
	camera->setTarget(camera->getPosition() + vector3df(0,0,100));

}//end Update()

bool FollowPlayerCamera::OnEvent(const SEvent& event)
{
	if (camera != 0 && event.EventType == EET_KEY_INPUT_EVENT)
	{
		switch(event.KeyInput.Key)
		{
			//Switch camera mode to 1st person
			case KEY_KEY_1:
				mode = FIRST_PERSON;
				return true;
			//Switch camera mode to 3rd person
			case KEY_KEY_3:
				mode = THIRD_PERSON;
				return true;
		}
	}

	return false;

}//end OnEvent()


FollowPlayerCamera::~FollowPlayerCamera()
{
}
