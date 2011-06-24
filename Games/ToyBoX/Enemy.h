//Joel Kemp
//ToyBoX
//Copyright 2008
#pragma once
#include "GameEntity.h"

/*
Represents a generic Enemy object
that is used in the simulation.
*/
class Enemy : public GameEntity
{

public:
	Enemy(IrrlichtDevice *device, 
		stringc filename = "",
		vector3df position = vector3df(0,0,0),
		vector3df rotation = vector3df(0,0,0));

	~Enemy();
	
	void Shoot();
	void Update();
	void Die();
	void CreateCollisionRelationships(IMetaTriangleSelector *metaSelector, vector3df gravity);

	/* Insert the animation into a list of mesh animations */
	void InsertAnimation(stringc name, s32 startFrame, s32 endFrame);

#pragma region Getters/Setters
	
	//Get Pointer to mesh scene node
	IAnimatedMeshSceneNode* GetMeshSceneNode()	{ return meshSceneNode; }
	//Get Enemy Health
	s32 GetHealth()	{ return health; }
	//Get Enemy Position
	vector3df GetPosition()	{ return meshSceneNode->getPosition(); }
	//Get enemy rotation
	vector3df GetRotation()	{ return meshSceneNode->getRotation(); }


	//Set the mesh scene node
	void SetMeshSceneNode(IAnimatedMeshSceneNode *msn)
	{	
		if(meshSceneNode) meshSceneNode->remove();
		meshSceneNode = msn; 
	}
	//Set the texture of the enemy
	void SetTexture(s32 index, ITexture *texture){ meshSceneNode->setMaterialTexture(index, texture); }
	//Set the texture of the enemy from a filename
	void SetTexture(s32 index, stringc filename)
	{
		ITexture *texture = driver->getTexture(filename.c_str());
		meshSceneNode->setMaterialTexture(index, texture);
	}
	//Set enemy position
	void SetPosition(vector3df position){ meshSceneNode->setPosition(position); }
	//Set enemy rotation
	void SetRotation(vector3df rotation){ meshSceneNode->setRotation(rotation); }
	//Set enemy mesh
	void SetMesh(IAnimatedMesh *mesh)
	{
		if(meshSceneNode) meshSceneNode->remove();
		//meshSceneNode->setMesh(mesh);
		meshSceneNode = smgr->addAnimatedMeshSceneNode(mesh);
	}
	//Set the current animation
	void SetAnimation(s32 startFrame, s32 endFrame)	{ meshSceneNode->setFrameLoop(startFrame, endFrame);}
	//Set the speed of the current animation
	void SetAnimationSpeed(f32 fps) { meshSceneNode->setAnimationSpeed(fps); }

#pragma endregion
		
protected:
	s32 health;
	IAnimatedMeshSceneNode *meshSceneNode;
};
