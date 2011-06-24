#pragma once
#include "B25.h"
#include "Naboo.h"
#include "F14.h"
#include "Concorde.h"
#include "Airplane.h"

/**
Represents a controller that returns 
a particular type of airplane based on 
the passed planeId.
*/
class AirplaneFactory
{
	
public:

	/**
	Creates a new airplane of the type 
	specified by the planeId. Returns
	a pointer to the newly created
	airplane.
	*/
	Airplane* Create(s32 planeId, /**< The id representing one of the game's airplanes.*/
		vector3df position, /**< The initial position for the new airplane */
		vector3df rotation, /**< The initial rotation for the new airplace */
		IrrlichtDevice *device) /**< Pointer to the Irrlicht Device */
	{
		//Based on the id, return a type of airplane.
		switch(planeId)
		{
			case 1:			//B25
				return new B25(position, rotation, device); 
			case 2:			//F14
				return new F14(position, rotation, device); 
			case 3:			//Naboo
				return new Naboo(position, rotation, device); 
			case 4:			//Concorde
				return new Concorde(position, rotation, device); 
		}

		//By default, return a new B25
		return new B25(position, rotation, device);;
	}

};