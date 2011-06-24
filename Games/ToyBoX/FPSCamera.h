//Joel Kemp
//ToyBoX
//Copyright 2008

#pragma once
#include "Camera.h"

/*
Represents the default game camera
that is in the first person perspective.
*/
class FPSCamera : public Camera
{
public:
	FPSCamera(IrrlichtDevice *device);
	~FPSCamera();

	void Update();
	
private:
	/*
	Creates both the WASD and Arrow Key Mappings.
	*/
	void CreateKeyMaps();


	//Keyboard Mappings
	SKeyMap wasdMap[10];
	//SKeyMap arrowMap[10];
};