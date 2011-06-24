#include "HUD.h"

HUD::HUD(IrrlichtDevice *device)
{
	gui::IGUIEnvironment* env = device->getGUIEnvironment();
	video::IVideoDriver* driver = device->getVideoDriver();

	//Add Irrlicht Logo
	env->addImage(driver->getTexture("../media/textures/irrlichtlogo2.png"), core::position2d<s32>(650,10));

	//Add Airbattles Logo
	env->addImage(driver->getTexture("../media/textures/title.png"), core::position2d<s32>(-40,10));

	//Add Health Bar
	env->addImage(driver->getTexture("../media/textures/healthbar.png"), core::position2d<s32>(20,510));

	//Add Ammo Bar
	env->addImage(driver->getTexture("../media/textures/healthbar.png"), core::position2d<s32>(650,510));
}

HUD::~HUD(void)
{
}
