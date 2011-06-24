//Joel Kemp
//ToyBoX
//Copyright, 2008
#pragma once
#include "GameEntity.h"

/* Represents a regular game bullet. */
class Bullet : public GameEntity
{
public:
	Bullet(IrrlichtDevice *device);
	~Bullet();

	/* Creates the bullet to be rendered. */
	void Initialize(vector3df startPosition, vector3df endPosition);

	/* Update the bullet's position based on speed and its trajectory. */
	void Update();
		
	/* Return the bullet's trajectory as a line. Used in collision detection. */
	line3df GetTrajectoryLine()	{ return trajectory; }

	/* Returns True if the bullet is active. */
	bool isActive() { return active; }

private:
	s32 damage;
	f32 speed;

	/* 3D Line that also represents the bullet's trajectory. This is used in collision detection. */
	line3df trajectory;

	/* Mesh for the game bullet. */
	ISceneNode *mesh;

	/* Boolean to restrict how many bullets are active at a time. */
	bool active;
};