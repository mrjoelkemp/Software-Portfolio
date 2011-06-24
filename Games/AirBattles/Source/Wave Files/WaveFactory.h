#pragma once
#include "Wave.h"
#include "Wave1.h"

/**
Represents a controller that returns 
a particular wave based on 
the passed waveId.
*/
class WaveFactory
{
	
public:

	/**
	Creates a new wave specified 
	by the waveId. Returns
	a pointer to the newly created
	wave.
	*/
	Wave* Create(s32 waveId, /**< The id representing one of the game's waves.*/
		Player *player,
		IrrlichtDevice *device) /**< Pointer to the Irrlicht Device */
	{
		//Based on the id, return the corresponding wave.
		switch(waveId)
		{
			case 1:			//Wave 1
				return new Wave1(player, device);  
		}

		//By default, return wave 1
		return new Wave1(player, device);
	}

};