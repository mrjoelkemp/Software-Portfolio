#include "Bullet.h"

Bullet::Bullet(IrrlichtDevice *device) : GameEntity(device)
{
	//Set bullet attributes
	speed = 1.0f;
	damage = 1;
}

void Bullet::Initialize(vector3df startPosition, vector3df endPosition)
{
	//Create the bullet
	mesh = smgr->addBillboardSceneNode(0, dimension2d<f32>(25,25), startPosition);
	
	//Turn off dynamic lighting
	mesh->setMaterialFlag(EMF_LIGHTING, false);
	//Apply the bullet texture to billboard
	mesh->setMaterialTexture(0, device->getVideoDriver()->getTexture("media/textures/fireball.jpg"));
	mesh->setMaterialType(EMT_TRANSPARENT_ADD_COLOR);

	//Create a line and vector representing the trajectory
	line3d<f32> line(startPosition, endPosition);
	trajectory = line;

	//Get the length of the trajectory
	f32 length = (endPosition - startPosition).getLength();
	u32 time = (u32)(length / speed);

	//Set bullet flight path
	ISceneNodeAnimator *animator = smgr->createFlyStraightAnimator(startPosition, endPosition, time);
	mesh->addAnimator(animator);
	animator = 0;
	//Delete the bullet if it lives for too long
	animator = smgr->createDeleteAnimator(time);
	mesh->addAnimator(animator);
	animator->drop();
}

void Bullet::Update()
{}//end Update()

Bullet::~Bullet()
{}