//Joel Kemp
//ToyBoX
//Copyright 2008
#pragma once
#include "GameEntity.h"

/*
Represents the generic game camera base class
that is used to abstract all of the possible
simulation cameras.
*/
class Camera : public GameEntity
{
public:

	Camera(IrrlichtDevice *device) : GameEntity(device) 
	{ camera = 0; }
	
	~Camera() {}

	ICameraSceneNode* GetCamera()		{ return camera; }
	vector3df GetPosition()				{ return camera->getPosition(); }
	vector3df GetRotation()				{ return camera->getRotation(); }
	
	//Return what the camera is looking at (direction)
	vector3df GetTarget()				{ return camera->getTarget(); }
	f32 GetFarValue()					{ return camera->getFarValue(); }

	void SetTarget(ISceneNode *target = 0) { this->target = target; }

	void AddChild(ISceneNode *node) { camera->addChild(node); }

protected:
	ICameraSceneNode* camera;
	
	//Used if the camera will follow the player
	ISceneNode *target;
};