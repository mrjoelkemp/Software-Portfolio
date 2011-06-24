#pragma once
#include "Enemy.h"
#include "Player.h"
#include "FollowPlayerCamera.h"
#include "GameEventReceiver.h"
using namespace irr;
using namespace core;
using namespace scene;

/**
Represents a level of the game.
*/
class Wave
{
public:

#pragma region Public Members
	/**
	Constructor of the wave class.
	*/
	Wave(void);
	~Wave(void);
	
	//void Render();
	//void PreRender();
	//void RenderWaveNumber();
	
	/**
	Returns if the list of enemies is empty. 
	i.e. Returns true if all the enemies are dead, 
	false otherwise.
	*/
	bool IsWaveComplete();

	/**
	Creates a list of enemies by populating
	the wave's array list.
	*/
	void CreateEnemyList();
	
	/**
	Updates the enemy positions, player positions,
	and any other updates for the wave.
	*/
	virtual void Update();

	/**
	Render the loading screen for the wave.
	*/
	virtual void ShowLoadingScreen();

	/**
	Loads the wave number texture to the 
	gui environment.
	*/
	virtual void ShowWaveNumber();

#pragma region Setters
	void SetPlayer(Player *curPlayer) { player = curPlayer;}
	void SetDevice(IrrlichtDevice *curDevice) { device = curDevice;}
	void SetNumberEnemies(s32 num) { numberEnemies = num;}
	void SetWaveId(s32 id) { waveId = id;}
	void SetEnemyType(s32 id) { enemyType = id;}
#pragma endregion

#pragma endregion 

protected:
#pragma region Protected Attributes
	IrrlichtDevice *device;	/**< Pointer to the Irrlicht Device */
	s32 numberEnemies;		/**< The number of enemies for the wave.*/
	array<Enemy*> *enemies; /**< List of enemies */
	s32 enemyType;			/**< Type of enemy aircraft */
	s32 waveId;				/**< Id number of the wave */
	Player *player;
	FollowPlayerCamera *camera;
	GameEventReceiver* receiver;
#pragma endregion

	/**
	Creates the collision relationships 
	between objects in the wave: terrain,
	players, enemies, bullets, etc.
	*/
	virtual void CreateCollisionRelations();


};
