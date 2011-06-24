//Joel Kemp
//ToyBoX
//Copyright 2008
#pragma once
#include "MainMenu.cpp"
#include "Level.h"
#include "FPSCamera.h"
#include "Enemy.h"
#include "Player.h"
#include "ContentLoader.h"
#include "EnemyManager.h"

using namespace irr;
using namespace gui;
using namespace scene;
using namespace video;
using namespace core;

using namespace io;

class Game : public IEventReceiver
{
public:

#define NUM_ENEMIES 10

	Game();
	/* Initializes the Irrlicht device and its components. */
	void Initialize();
	/* Starts the game loop. */
	void Run();

	/* Loads a mesh model into the simulation. */
	IAnimatedMeshSceneNode* LoadModel(const c8* fn);
	/* Loads a texture in to the simulation. */
	ITexture* LoadTexture(const c8* fn);
	/* Loads up objects defined in config file. */
	void LoadDefaultObjects();
	/* Loads a game archive (pk3, zip) into the simulation. */
	void LoadArchive(const c8* fn);
	/* Loads a new simulation level. */
	void LoadLevel(const c8* fn);
	/* Loads ToyBoX configuration file. */
	void LoadConfigFile(stringc fn);
	/* Changes game to run in edit mode. */
	void StartEditMode();
	/* Changes game to run in simulation mode. */
	void StartSimulationMode();

	/* Creates collision relationships between game objects. */
	void CreateCollisions();
	/* Handles keyboard and mouse input. */
	bool OnEvent(const SEvent& event);
	/* Updates (Time-based) the player and game state (objects) */
	void Update(u32 time);

	~Game();

private:
	IrrlichtDevice *device; 
	IGUIEnvironment *env;
	ISceneManager* smgr;
	IVideoDriver *driver;

	/* Current player object. */
	Player *player;
	/* Current simulation map. */
	Level *level;			
	/* Simluation's Editing Mode's Main Menu. */
	MainMenu* mainMenu;				
	/* Enemy Manager */
	EnemyManager *enemyManager; 

	/* Boolean to keep track of the mode that the game is in: edit or simulation modes */
	bool editingMode;

	/* Holds all the triangle selectors for game objects to do all collision detection in one pass. */
	IMetaTriangleSelector *metaSelector;

	/* Gravity vector that is applied to game objects. */
	vector3df g_Gravity;

	//Default Game Startup Objects
	//TODO: Clean up this startup crap!
	stringc StartUpModelFile;
	stringc	StartUpModelTextureFile;
	stringc StartUpMapFile;
	stringc StartUpCrosshairFile;
	stringc StartUpWeaponFile;
	stringw MessageText;
	stringw Caption;

	//Node that is clicked and modified in edit mode.
	ISceneNode* nodeFound;
	ISceneNode* clone;
};