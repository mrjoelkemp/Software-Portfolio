#include "Enemy.h"

Enemy::Enemy(s32 planeId, vector3df position, 
		vector3df rotation,
		IrrlichtDevice* device)
{
	this->device = device;
		
	AirplaneFactory *factory = new AirplaneFactory();

	//Create the Enemy scene node
	//mesh = smgr->addAnimatedMeshSceneNode(smgr->getMesh("../media/meshes/b25.x"),0, 1, position, rotation);
	mesh = factory->Create(planeId, position, rotation, device)->GetMeshPointer();
	delete factory;

	//Set enemy attributes
	//speed = 5;
	//health = 100;
	//armor = 0;
	//weight = 75;
	//bulletDamage = 10;

	//Default motion (straight)
	motionType = 0;
}

void Enemy::Update()
{
	vector3df meshPosition = mesh->getPosition();

	//Update position based on motiontype
	switch(motionType)
	{
	case 0:	//Straight
		mesh->setPosition(meshPosition + vector3df(0,0,(f32)speed));
		break;
	case 1: //Circular
		break;
	case 2:	//Vertical
		break;

	}
}//end Update()

Enemy::~Enemy(void)
{
}
