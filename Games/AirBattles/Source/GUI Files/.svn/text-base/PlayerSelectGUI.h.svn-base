#pragma once
#include <irrlicht.h>
using namespace irr;
using namespace gui;

/**
Represents the player selection interface
that allows a player to select their
aircraft.
*/
class PlayerSelectGUI : public IEventReceiver
{

public:
	PlayerSelectGUI(IrrlichtDevice *device);
	~PlayerSelectGUI(void);
	bool Render();
	bool OnEvent(const SEvent &event);

private:
	IrrlichtDevice *device;
};