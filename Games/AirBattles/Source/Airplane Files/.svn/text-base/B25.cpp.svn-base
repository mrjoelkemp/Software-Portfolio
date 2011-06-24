#include "B25.h"

B25::B25(vector3df position, vector3df rotation, IrrlichtDevice *device)
{
	this->device = device;

	ISceneManager *smgr = device->getSceneManager();
	video::IVideoDriver *driver = device->getVideoDriver();

	//Set the airplane attributes
	weight = 150;
	armor = 100;
	health = 100;
	bulletDamage = 10;
	speed = 5;
	
	//Create the Airplane's scene node
	mesh = smgr->addAnimatedMeshSceneNode(smgr->getMesh("../media/meshes/fighter1.3ds"),0, 1, position, rotation);

	//Turn off dynamic lighting
	mesh->setMaterialFlag(video::EMF_LIGHTING, false);
		
	//Set the plane's texture
	mesh->setMaterialTexture(0, driver->getTexture("../media/textures/fighter/idolknight.jpg"));
}

B25::~B25()
{
}