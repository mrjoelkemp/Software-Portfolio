#include "Enemy.h"

Enemy::Enemy(IrrlichtDevice *device, stringc filename, vector3df position, vector3df rotation) : GameEntity(device)
{
	health = 100;
	meshSceneNode = 0;

	meshSceneNode = smgr->addAnimatedMeshSceneNode(smgr->getMesh(filename.c_str()), 0, -1, position, rotation);
	
	if(meshSceneNode)
	{
		//Turn off dynamic lighting
		meshSceneNode->setMaterialFlag(EMF_LIGHTING, false);
		meshSceneNode->setAnimationSpeed(20);
		
		//Create the (optimized) OccTree triangle selector
		ITriangleSelector *selector = smgr->createOctTreeTriangleSelector(smgr->getMesh(filename.c_str()), meshSceneNode);
		if(selector)
		{
			meshSceneNode->setTriangleSelector(selector);
			selector->drop();
		}
	}
}

void Enemy::Die()
{}

void Enemy::Update()
{}

void Enemy::Shoot()
{}

void Enemy::CreateCollisionRelationships(IMetaTriangleSelector *metaSelector, vector3df gravity)
{
	ISceneNodeAnimatorCollisionResponse* collider =
				smgr->createCollisionResponseAnimator(
				metaSelector,				//The Collision Pool
				meshSceneNode,				//The Enemy's Scene Node
				vector3df(25,40,10),		//Ellipsoid Radius
				gravity,					//Gravity
				vector3df(0,35,0),			//Ellipsoid Translation
				0.005f);					//Sliding Value
	
	meshSceneNode->addAnimator(collider);
	collider->drop();
}

Enemy::~Enemy()
{
	printf("Enemy Deleted \n");
}