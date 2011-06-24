#include "EnemyManager.h"

EnemyManager::EnemyManager(IrrlichtDevice *device) : GameEntity(device)
{
	
}

void EnemyManager::Update(u32 gameTime)
{
	//Update all the enemies in the list.
}

void EnemyManager::AddEnemy(vector3df position)
{
	Enemy* enemy = new Enemy(device);
	if(enemy)
	{
		IAnimatedMeshSceneNode* node = smgr->addAnimatedMeshSceneNode(
			smgr->getMesh("meshes/ninja/ninja.b3d"));
			
		enemy->SetMeshSceneNode(node);
		enemy->SetPosition(position);

		//Enemy ID is the incremented count of current enemies.
		node->setID(enemyList.size() + 1);
		enemyList.insert(enemy);
	}
}

void EnemyManager::RemoveEnemy(u32 id)
{
	//Cache the size
	int listSize = (int)enemyList.size();
	//Iterate over the enemy list
	for(int i = 0; i< listSize; i++)
		//If you find a matching id,
		if(enemyList[i]->GetMeshSceneNode()->getID() == id)
		{	
			//Remove that node from the list
			enemyList.erase(i);
			break;
		}
}

Enemy* EnemyManager::GetEnemy(u32 id)
{
	//Cache the size
	int listSize = (int)enemyList.size();
	//Iterate over the enemy list
	for(int i = 0; i< listSize; i++)
		//If you find a matching id,
		if(enemyList[i]->GetMeshSceneNode()->getID() == id)
			//Return a pointer to that node
			return enemyList[i];
		
	return 0;
}

EnemyManager::~EnemyManager(void)
{
	//Cache the size
	int listSize = (int)enemyList.size();
	//Iterate over the enemy list
	for(int i = 0; i< listSize; i++)
		if(enemyList[i])
		{
			//TODO: Verify that deleting then clearing doesn't memory fault.
			delete enemyList[i];
			//enemyList.erase(i);
		}
	//Just in case.
	//enemyList.clear();
}
