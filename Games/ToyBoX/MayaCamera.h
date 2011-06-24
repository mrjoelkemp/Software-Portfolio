//Joel Kemp
//ToyBoX
//Copyright 2008

#pragma once
#include "Camera.h"

class MayaCamera : public Camera
{
public:
	MayaCamera(IrrlichtDevice *device) : Camera(device)
	{
		//Create camera
		smgr->addCameraSceneNodeMaya(0, 75.0f, 100.0f, 500.0f);

		//Create triangle selector
		//ITriangleSelector *selector = smgr->createOctTreeTriangleSelector();

	}

private:

};