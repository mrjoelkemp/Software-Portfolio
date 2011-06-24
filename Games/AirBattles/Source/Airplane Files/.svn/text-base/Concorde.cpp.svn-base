#include "Concorde.h"

Concorde::Concorde(vector3df position, vector3df rotation, IrrlichtDevice *device)
{
	this->device = device;

	ISceneManager *smgr = device->getSceneManager();
	video::IVideoDriver *driver = device->getVideoDriver();

	//Set the airplane attributes
	weight = 100;
	armor = 100;
	health = 100;
	bulletDamage = 6;
	speed = 12;
	
	//Create the Airplane's scene node
	mesh = smgr->addAnimatedMeshSceneNode(smgr->getMesh("../media/meshes/concorde.x"),0, 1, position, rotation);

	//Turn off dynamic lighting
	mesh->setMaterialFlag(video::EMF_LIGHTING, false);
		
	//Set the plane's texture
	mesh->setMaterialTexture(0, driver->getTexture("../media/textures/concordetexture.jpg"));

}

Concorde::~Concorde(void)
{
}
