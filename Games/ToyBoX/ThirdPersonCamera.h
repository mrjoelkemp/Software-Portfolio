//Joel Kemp
//ToyBoX
//Copyright 2008

#pragma once
#include "Camera.h"

class ThirdPersonCamera : public Camera
{
public:
	ThirdPersonCamera(IrrlichtDevice *device) : Camera(device)
	{
		smgr->addCameraSceneNode();

	}

private:

};