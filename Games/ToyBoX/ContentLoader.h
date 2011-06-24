//Joel Kemp
//Toybox
//Copyright, 2009
#pragma once

#include "GameEntity.h"
#include "Level.h"

class ContentLoader
{
public:
	ContentLoader();
	~ContentLoader(void);

	static IAnimatedMeshSceneNode* LoadModel(const c8 *filename, IrrlichtDevice *device);
	static ITexture* LoadTexture(const c8 *filename, IrrlichtDevice* device);
	static Level* LoadLevel(const c8 *filename, IrrlichtDevice* device);
	static void LoadArchive(const c8 *filename, IrrlichtDevice *device);
};
