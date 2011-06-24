//Joel Kemp
//FPS Project
//Copyright 2008
#pragma once
#include "GameEntity.h"

/*
Represents a generic
*/
class Level : public GameEntity
{
public:
	/* Load the level from the passed filename,
	set at the passed position with the given
	rotation.
	*/
	Level(IrrlichtDevice *device, 
		stringc filename = "", 
		vector3df position = vector3df(0,0,0),
		vector3df rotation = vector3df(0,0,0));

	~Level();

	/* Loads level from the passed file */
	bool LoadLevelFromFile(stringc filename);
	/* Loads Archive from passed filename*/
	bool LoadArchive(stringc fn);
	/* Loads Irr Scene from passed filename. */
	bool LoadIrrScene(stringc fn);

	/* Set up the triangle selector for the level */
	void CreateTriangleSelector();

#pragma region Getters / Setters

	//Get Scene Node
	ISceneNode *GetSceneNode() { return levelNode; }
	//Get Name
	stringc GetName() { return levelName; }
	//Get Position
	vector3df GetPosition() { return levelNode->getPosition(); }
	//Get Rotation
	vector3df GetRotation() { return levelNode->getRotation(); }

	//Set Scene Node
	void SetSceneNode(ISceneNode *node) 
	{ 
		levelNode->remove();
		levelNode = node; 
	}
	//Set level Name
	void SetName(stringc name) { levelName = name; }
	//Set level Position
	void SetPosition(vector3df position) { levelNode->setPosition(position); }
	//Set level Rotation
	void SetRotation(vector3df rotation) { levelNode->setRotation(rotation); }

#pragma endregion

private:
	ISceneNode *levelNode;
	IAnimatedMesh *levelMesh;
	stringc levelName;
};