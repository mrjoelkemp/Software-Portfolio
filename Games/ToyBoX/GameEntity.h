//Joel Kemp
//ToyBoX
//Copyright, 2008
#pragma once
#include <irrlicht.h>
using namespace irr;
using namespace video;
using namespace core;
using namespace gui;
using namespace scene;
using namespace io;

/*
Base class for all game entities. Game Entities 
all use Irrlicht.h and the irr namespace derivations. 
Therefore, we include them in one place to keep tidy.
*/
class GameEntity
{
public:
	GameEntity (IrrlichtDevice *device)
	{ 
		this->device = device; 
		this->driver = device->getVideoDriver();
		this->env = device->getGUIEnvironment();
		this->smgr = device->getSceneManager();
	}

	~GameEntity()
	{}

protected:
	IrrlichtDevice *device;
	IGUIEnvironment *env;
	IVideoDriver *driver;
	ISceneManager *smgr;
};