#include "Naboo.h"

Naboo::Naboo(vector3df position, vector3df rotation, IrrlichtDevice *device)
{
	this->device = device;

	ISceneManager *smgr = device->getSceneManager();
	video::IVideoDriver *driver = device->getVideoDriver();

	//Set the airplane attributes
	weight = 80;
	armor = 100;
	health = 100;
	bulletDamage = 6;
	speed = 15;
	
	//Create the Airplane's scene node
	mesh = smgr->addAnimatedMeshSceneNode(smgr->getMesh("../media/meshes/naboo.x"),0, 1, position, rotation);

	//Turn off dynamic lighting
	mesh->setMaterialFlag(video::EMF_LIGHTING, false);
		
	//Set the plane's texture
	mesh->setMaterialTexture(0, driver->getTexture("../media/textures/nabootexture.jpg"));

}

Naboo::~Naboo(void)
{
}
