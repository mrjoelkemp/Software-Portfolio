//Joel Kemp
//ToyBox
//Copyright, 2009
#pragma once
#include "GameEntity.h"
#include "Enemy.h"

/* Represents the entity that adds, removes, and updates enemies. */
class EnemyManager : public GameEntity
{
public:
	EnemyManager(IrrlichtDevice *device);
	/* Adds an enemy to the list based on position. A unique id is assigned to new enemy. */
	void AddEnemy(vector3df position);
	/* Remove an enemy specified by the id.*/
	void RemoveEnemy(u32 id);
	/* Updates all enemies in the enemy list. */
	void Update(u32 gameTime);

	/* Get a pointer to the enemy specified by the id. */
	Enemy* GetEnemy(u32 id);
	/* Returns a copy of the list of enemies. */
	array<Enemy*> GetEnemyList() { return enemyList; }
	~EnemyManager(void);

private: 
	/* Array of enemies */
	array<Enemy*> enemyList;	

};
