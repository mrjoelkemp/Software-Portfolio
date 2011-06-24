#include "FPSCamera.h"

FPSCamera::FPSCamera(irr::IrrlichtDevice *device) : Camera(device)
{
	//Create the key mappings
	CreateKeyMaps();

	//Create the camera
	//camera = smgr->addCameraSceneNodeFPS(0, 75.0f, 250.0f, -1, wasdMap, sizeof(wasdMap), false, 2.5f);
	camera = smgr->addCameraSceneNodeFPS(0, 75.0f, 0.5f);
	camera->setPosition(vector3df(0,0,0));
	
	camera->setFarValue(5000.0f);
	camera->setNearValue(5.0f);

	//Set up triangle selector


	printf("Camera Created\n");
}

void FPSCamera::CreateKeyMaps()
{
	//WASD Configuration
	wasdMap[0].Action = EKA_MOVE_FORWARD;
	wasdMap[0].KeyCode = KEY_KEY_W;

	wasdMap[1].Action = EKA_MOVE_BACKWARD;
	wasdMap[1].KeyCode = KEY_KEY_S;

	wasdMap[2].Action = EKA_STRAFE_LEFT;
	wasdMap[2].KeyCode = KEY_KEY_A;

	wasdMap[3].Action = EKA_STRAFE_RIGHT;
	wasdMap[3].KeyCode = KEY_KEY_D;

	wasdMap[4].Action = EKA_JUMP_UP;
	wasdMap[4].KeyCode = KEY_SPACE;


	//Arrows Configuration
	wasdMap[5].Action = EKA_MOVE_FORWARD;
	wasdMap[5].KeyCode = KEY_UP;
	
	wasdMap[6].Action = EKA_MOVE_BACKWARD;
	wasdMap[6].KeyCode = KEY_DOWN;

	wasdMap[7].Action = EKA_STRAFE_LEFT;
	wasdMap[7].KeyCode = KEY_LEFT;

	wasdMap[8].Action = EKA_STRAFE_RIGHT;
	wasdMap[8].KeyCode = KEY_RIGHT;

	wasdMap[9].Action = EKA_JUMP_UP;
	wasdMap[9].KeyCode = KEY_KEY_J;

}

void FPSCamera::Update()
{
	/*
	//Update position based on target's position
	if(mode == 1)
		camera->setPosition(target->getPosition());
	if(mode == 3)
		camera->setPosition(target->getPosition()-vector3df(0,0,30));

	camera->setTarget(target->getPosition());
*/
}

FPSCamera::~FPSCamera()
{
}