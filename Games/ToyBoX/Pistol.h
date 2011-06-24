//Joel Kemp
//FPS Project
//Copyright 2008

#pragma once
#include "Weapon.h"
#include "Bullet.h"

class Pistol : public Weapon
{
public:
	Pistol(IrrlichtDevice *device, ICameraSceneNode *parent = 0);
	~Pistol();

	/*
	Create a bullet that will follow the path
	specified by the line between the pistol's
	position, and the passed in camera's
	lookAt and farValue information.
	*/
	void Shoot(vector3df camTarget, f32 camFarValue);
	
	/*
	Set all the bullets in the clip as active,
	simulating a reload of the bullets.
	*/
	void Reload();

	/*
	Used for a brute force parent relation.
	Update the pistol's position as an offset
	of the parent. Update the pistol's rotation
	as the parent's rotation.

	This is used as an alternative to the setParent()
	methods because relative coordinates blow hard!
	*/
	void Update();

	/*
	Returns a pointer to the pistol's mesh.
	*/
	IAnimatedMeshSceneNode* GetPistol() { return mesh; }

	/*
	Return a list of the active bullets
	so that we can do collision detection
	on each bullet.

	Note: 
		We need to control the bullets and
		keep track of them so that we can
		do collision detection on them.
			-Maybe have an array representing
			a clip of ammunition. Each bullet can
			be accounted for in that clip.

		Alternatively, we might be able to add 
		triangle selectors to them and detect 
		collision via the collision manager. (Untested)
	*/
	Bullet** GetActiveBullets()
	{
		//Currently, just return the single bullet
		//return bullet;
	}

	
	Bullet* GetActiveBullet()
	{ 
		//TODO: Delete this later.
		if(bullet->isActive())
			return bullet; 
		else
			return NULL;
	}

private:
	//IAnimatedMeshSceneNode *mesh;
	
	/*
	Clip that consists of a number of bullets
	set by the inherited variable clipSize.
	*/
	Bullet **clip;
	ITexture *crosshairTexture;

	/*Todo: Delete this and use the clip.*/
	Bullet *bullet;

	/*
	Pointer to the parent of the pistol.
	*/
	ICameraSceneNode *parent;
	vector3df parentOffset;
};