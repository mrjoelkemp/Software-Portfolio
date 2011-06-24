//Joel Kemp
//FPS Project
//Copyright 2008

#pragma once
#include "GameEntity.h"

/*
Represents the base class for all
game weapons (guns, grenades, etc).
*/
class Weapon : public GameEntity
{
public:
	Weapon(IrrlichtDevice *device) : GameEntity(device)
	{
		mesh = 0;
		clipSize = 0;
		ammoCount = 0;
	}

	s32 GetClipSize() { return clipSize; }
	s32 GetAmmoCount() { return ammoCount; }
	IAnimatedMeshSceneNode* GetMesh() { return mesh; }

	void SetParent(ICameraSceneNode *camera) { mesh->setParent(camera); }
	void SetPostion(vector3df position) { mesh->setPosition(position); }

	virtual void Update() {}
	virtual void Shoot(vector3df camTarget, f32 camFarValue) {}

protected:
	IAnimatedMeshSceneNode *mesh;
	s32 clipSize;
	s32 ammoCount;
};