#include "GameEventReceiver.h"

GameEventReceiver::GameEventReceiver(Player* player, FollowPlayerCamera* camera, IrrlichtDevice* device)
{
	this->player = player;		
	this->camera = camera;
	this->device = device;
}

bool GameEventReceiver::OnEvent(const SEvent& event)
{
	//If the event is from the keyboard
	if (event.EventType == EET_KEY_INPUT_EVENT)
	{
		//Take care of events not related to players or cameras
		switch(event.KeyInput.Key)
		{
			//Exit the game
			case KEY_ESCAPE:
				device->closeDevice();
				return true;

		}//end switch
		
		//If event isn't for the game's event receiver,
		// pass to players and cameras to handle.
		
		//If the player doesn't handle the event
		if(!player->OnEvent(event))
			//Pass to the camera to handle.
			camera->OnEvent(event);

	}//end if

	return false;
}//end OnEvent()

GameEventReceiver::~GameEventReceiver(void)
{
}