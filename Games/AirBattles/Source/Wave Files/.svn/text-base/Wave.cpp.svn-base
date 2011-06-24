#include "Wave.h"

Wave::Wave(void)
{
	//Initialize Enemy List
	enemies = new array<Enemy*>();
	numberEnemies = 0;
	enemyType = 0;
	waveId = 0;
}

/*
Check to see if all the enemies have been killed -> wave completed.
*/
bool Wave::IsWaveComplete()
{
//	if(enemies->empty())
//		return true;

	return false;
}//end IsWaveComplete()

/*
Populate the enemy list.
*/
void Wave::CreateEnemyList()
{
	ISceneManager *smgr = device->getSceneManager();

	//Get player position
	//vector3df playerPosition = smgr->getSceneNodeFromName("player")->getPosition();
	vector3df playerPosition = player->GetPosition();
	//Set the initial position for the enemies
	vector3df enemyInitialPosition = playerPosition + vector3df(-500.0f,0,2000.0f);
	vector3df enemyInitialRotation = vector3df(0,0,0);
	
	f32 newXPosition = enemyInitialPosition.X;
	f32 newYPosition = enemyInitialPosition.Y;
	vector3df finalEnemyPosition = vector3df(0,0,0);


	//Set the position and rotation for each enemy
	for(int i = 0; i < numberEnemies; i++)
	{
		newXPosition += 100;
		//newYPosition = 0; //Modify so that the enemies appear one up and one down
		finalEnemyPosition = enemyInitialPosition + vector3df(newXPosition, 0, 0);
		
		//Create a new enemy with the new position and rotation
		Enemy *enemy = new Enemy(enemyType, finalEnemyPosition, enemyInitialRotation, device);
		//Add the enemy to the enemies list
		enemies->insert(enemy);
	}
}//end CreateEnemyList()

void Wave::CreateCollisionRelations()
{
}

void Wave::ShowLoadingScreen()
{
}

void Wave::Update()
{
}

void Wave::ShowWaveNumber()
{
}

Wave::~Wave(void)
{
	if(receiver)
		delete receiver;
	if(enemies)
	{
		enemies->clear();
		delete enemies;
	}
}
