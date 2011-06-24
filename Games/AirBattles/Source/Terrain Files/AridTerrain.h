#pragma once
#include <irrlicht.h>
//Used for the Shifted Terrain Scene Node
//#include "ShTlTerrainSceneNode.h"
//#include "SomeFunctions.h"

using namespace irr;
using namespace scene;
using namespace core;
using namespace video;


class AridTerrain
{

public:

	AridTerrain(IrrlichtDevice* irrDevice);

	void AttachCollisionResponse(ISceneNode* collider, 
		vector3df collisionRadius = vector3df(100,100,60), 
		vector3df radiusTranslation = vector3df(0,0,0));

	ITerrainSceneNode* GetTerrainNodePointer();
	~AridTerrain(void);

private:
	IrrlichtDevice* device;
	ITerrainSceneNode* terrain;

	void CreateTriangleSelector();
};