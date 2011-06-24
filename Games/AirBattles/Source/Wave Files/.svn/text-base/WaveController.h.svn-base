#pragma once
#include "WaveFactory.h"

using namespace irr;
using namespace gui;
using namespace scene;
using namespace core;
/**
Represents a controller for the 
system's waves. Controls rendering 
and proper loading of the waves.
*/
class WaveController
{
public:
	WaveController(void);
	~WaveController(void);
	
	/**
	Renders the passed wave object.
	Each frame, checks if the wave is complete.
	Returns true if the wave is complete, 
	signaling for the loading of another wave.
	*/
	bool Render(Wave* wave);

	/**
	Presents the user with an interface to choose
	their aircraft. Returns an s32 (int) that 
	corresponds to the aircraft selected.
	*/
	s32 ShowPlayerSelectGUI();

private:
	IrrlichtDevice *device;
	ISceneManager *smgr;
	IGUIEnvironment *env;
	IVideoDriver *driver;

	array<Wave*> *waves; /**< List of waves to be rendered */
	Wave *currentWave;
	s32 playerType;	/**< The s32 value of the aircraft chosen by the player */
	Player *player; 
	WaveFactory *waveFactory;
	s32 totalNumWaves; /**< The total number of waves for the game */

	/**
	Handles all initialization in the
	wave controller such as: creating device,
	loading screens, etc.
	*/
	void Initialize();

	/**
	Begin the game by initializing the player,
	rendering the first wave, and checking if
	the wave is complete, thus rendering the next
	wave in the list of waves.	
	*/
	void StartGame();
};
