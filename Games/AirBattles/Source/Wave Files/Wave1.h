#pragma once
#include "Wave.h"
#include "AridTerrain.h"
#include "Sunset.h"
#include "FollowPlayerCamera.h"


/**
Represents the first level of the game.
*/
class Wave1 :
	public Wave
{
public:
	Wave1(Player *player, IrrlichtDevice *device);
	~Wave1(void);

	void Update();
	void ShowLoadingScreen();
	void ShowWaveNumber();

private:
	void CreateCollisionRelations();
	
	/**
	Creates the event receiver that will
	capture the player's keyboard actions.
	*/
	void CreateEventReceiver();

	AridTerrain *terrain;
	Sunset *skybox;
	FollowPlayerCamera *camera;
};
