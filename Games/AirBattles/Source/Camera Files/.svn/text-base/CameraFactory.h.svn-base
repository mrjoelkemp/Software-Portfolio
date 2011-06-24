#pragma once
#include "FollowPlayerCamera.h"

/**
Represents a controller that returns 
a particular type of camera based on 
the passed cameraId.
*/
class CameraFactory
{
	
public:

	/**
	Creates a new camera of the type 
	specified by the cameraId. Returns
	a pointer to the newly created
	camera.
	*/
	Camera* Create(
		s32 cameraId,				/**< The id representing one of the game's cameras.*/
		IrrlichtDevice *device		/**< Pointer to the Irrlicht Device */
		) 
	{
		//Based on the id, return a type of camera.
		switch(cameraId)
		{
			case 1:			//FollowPlayerCamera
				return new FollowPlayerCamera(device); 
		}

		//By default, return a new B25
		return new FollowPlayerCamera(device);;
	}

};