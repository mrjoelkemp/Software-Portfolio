#include "Level.h"

Level::Level(IrrlichtDevice *device, stringc filename, vector3df position, vector3df rotation) : GameEntity(device)
{
	levelNode = 0;
	levelMesh = 0;
	levelName = "";

	if(filename != "")
		//Attempt to load the level from the passed filename (if passed)
		if(LoadLevelFromFile(filename))
		{
			//Set position
			levelNode->setPosition(position);
			//Set rotation
			levelNode->setRotation(rotation);
			//Set up triangle selector
			CreateTriangleSelector();
		}
}

bool Level::LoadLevelFromFile(stringc filename)
{
	stringc extension;
	getFileNameExtension(extension, filename);

	//If the filename is a zipped package, add it to the system
	if(	extension == ".pk3" || extension == ".zip" )
		return this->LoadArchive(filename);
	
	//If the level file is an irr scene
	if(extension == ".irr")
		return this->LoadIrrScene(filename);
	
	//Create the mesh
	levelMesh = smgr->getMesh(filename.c_str());
	if(levelMesh)
	{
		//Remove the scene node from the scene (if exists)
		if(levelNode) levelNode->remove();
		//Create the new scene node
		levelNode = smgr->addOctTreeSceneNode(levelMesh, 0, -100, 128);
		//Set up triangle selector
		if(levelNode)	this->CreateTriangleSelector();
		return true;
	}
	
	return false;
}// end LoadlevelFromFile

bool Level::LoadIrrScene(stringc fn)
{
	//Prepare Mip level usage for the scene
	driver->setTextureCreationFlag(video::ETCF_CREATE_MIP_MAPS, true);
	//Simply load it up
	smgr->loadScene(fn.c_str());
	return true;
}

bool Level::LoadArchive(stringc fn)
{
	device->getFileSystem()->addZipFileArchive( fn.c_str () );
	return true;
}

void Level::CreateTriangleSelector()
{
	//Create level triangle selector
	ITriangleSelector *levelSelector = smgr->createOctTreeTriangleSelector(levelMesh->getMesh(0), levelNode, 128);
	levelNode->setTriangleSelector(levelSelector);
	levelSelector->drop();	
}

Level::~Level()
{
	printf("level Deleted \n");
}