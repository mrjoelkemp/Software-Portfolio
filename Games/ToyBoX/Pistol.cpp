#include "Pistol.h"

Pistol::Pistol(irr::IrrlichtDevice *device, ICameraSceneNode *parent) : Weapon(device)
{
	clipSize = 10;
	ammoCount = 10;
	clip = new Bullet*[clipSize];
	bullet = new Bullet(device);

	/*** Set up Mesh ***/
	mesh = smgr->addAnimatedMeshSceneNode(smgr->getMesh("media/meshes/4guns/pistol.3ds"));
	mesh->setMaterialFlag(EMF_LIGHTING, false);
	mesh->setMaterialTexture(0, driver->getTexture("media/meshes/4guns/pistol.jpg"));

	if(parent)
	{
		//Attach the gun to the parent (camera)
		mesh->setParent(parent);
		//Store pointer to the parent
		this->parent = parent;
		//Set the position of the gun in relation to the parent
		mesh->setPosition(vector3df(5,-5,10));
	}

	/*** Set up Crosshair ***/
	//Turn off the mouse cursor
	device->getCursorControl()->setVisible(false);
	//Change the texture of the cursor to the pistol's crosshair
	crosshairTexture = driver->getTexture("media/textures/blackCrosshairSmall.png");
	//Since the cursor hasn't been established yet, get the coordinates of middle screen
	position2d<s32> cursorPos = position2d<s32>(driver->getScreenSize().Width/2, driver->getScreenSize().Height/2);
	//Adjust the position so that the middle of the texture is on the middle screen
	position2d<s32> crossPos = position2d<s32>(cursorPos.X - (crosshairTexture->getSize().Width/2), cursorPos.Y - (crosshairTexture->getSize().Height/2));
	//Add the crosshair
	env->addImage(crosshairTexture, crossPos);

	//TODO: Implement the tracking of bullets and such.

}

void Pistol::Shoot(vector3df camTarget, f32 camFarValue)
{
	line3df line = smgr->getSceneCollisionManager()->getRayFromScreenCoordinates(device->getCursorControl()->getPosition(), parent);	
	line.start = parent->getPosition();
	
	//Create bullet
	bullet->Initialize(line.start, line.end);
}//end Shoot()

void Pistol::Update()
{}

Pistol::~Pistol()
{
	if(clip)
		delete [] clip;
	if(bullet)
		delete bullet;
	printf("Pistol Deleted \n");
}