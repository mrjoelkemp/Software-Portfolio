#pragma once
#include <irrlicht.h>
using namespace irr;

/**
Represents the game's base camera
model. All of the game's additional
cameras will inherit this base and be
controlled by the CameraFactory class.
*/
class Camera
{
public:
	Camera();
	~Camera();

	virtual void Update();

	enum POV{
		FIRST_PERSON = 1,
		THIRD_PERSON = 3
	};
private:
	IrrlichtDevice *device;
	ISceneManager *smgr;
	ICameraSceneNode *camera;

};