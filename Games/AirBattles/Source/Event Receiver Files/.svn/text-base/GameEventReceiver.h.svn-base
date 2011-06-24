#pragma once

#include <iostream>
#include <irrlicht.h>
#include "Player.h"
#include "FollowPlayerCamera.h"

using namespace irr;

class GameEventReceiver : public IEventReceiver
{
public:

	GameEventReceiver(Player* player, FollowPlayerCamera* camera, IrrlichtDevice *device);
	bool OnEvent(const SEvent& event);
	~GameEventReceiver(void);

private:
	IrrlichtDevice *device;

	Player* player;
	FollowPlayerCamera* camera;
};