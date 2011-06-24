#include "Sunset.h"

Sunset::Sunset(IrrlichtDevice *device)
{
	video::IVideoDriver* driver = device->getVideoDriver();
	scene::ISceneManager* smgr = device->getSceneManager();

	driver->setTextureCreationFlag(video::ETCF_CREATE_MIP_MAPS, false);

	smgr->addSkyBoxSceneNode(
		driver->getTexture("../media/textures/up.jpg"),
		driver->getTexture("../media/textures/dn.jpg"),
		driver->getTexture("../media/textures/lt.jpg"),
		driver->getTexture("../media/textures/rt.jpg"),
		driver->getTexture("../media/textures/ft.jpg"),
		driver->getTexture("../media/textures/bk.jpg"));

	driver->setTextureCreationFlag(video::ETCF_CREATE_MIP_MAPS, true);

}

Sunset::~Sunset(void)
{
}
