#pragma once
#include <irrlicht.h>
#include "Player.h"
using namespace irr;
using namespace core;
using namespace scene;

class FollowPlayerCamera : public IEventReceiver
{
public:
	FollowPlayerCamera(IrrlichtDevice* device);
	~FollowPlayerCamera();

	/**
	Update the camera's position 
	based on the camera's mode and
	the player's position.
	*/
	void Update();

	bool OnEvent(const SEvent& event);

	void SetCameraMode(s32 mode){this->mode = mode;}
	void SetPlayerToFollow(Player *player){this->player = player;}

	s32	GetCameraMode(){return mode;}
	vector3df GetDistanceFromTarget(){return distanceFromTarget;}
	
	enum POV{
		FIRST_PERSON = 1,
		THIRD_PERSON = 3
	};

private:
	IrrlichtDevice *device;
	ISceneManager *smgr;
	ICameraSceneNode *camera;
	Player *player;
	
	vector3df distanceFromTarget, playerPosition;
	s32 mode;
};