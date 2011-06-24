//Joel Kemp
//ToyBoX
//Copyright 2008
#pragma once
#include "GameEntity.h"
#include "FPSCamera.h"
#include "MayaCamera.h"
#include "HeadsUpGUI.cpp"
#include "Pistol.h"
#include "WeaponManager.h"

/**
Represents a player in the game.
The player will be a CameraSceneNode
and not an actual mesh. Thus, we treat
the camera as if it's a mesh by creating
additional scene nodes to represent the head
and body, for collision purposes (with map, enemies,
and bullets).
*/
class Player : public IEventReceiver, public GameEntity
{

private:
	/* Custom first person shooter camera. */
	FPSCamera *fpsCamera;
	/* Mesh that represents the player in 3d space. The camera is the parent of the mesh. 
	i.e. the mesh model follows the camera. (might change) */
	IAnimatedMeshSceneNode *model;
	/* Health and armor counts. */
	s32 health, armor;
	/* Heads up display object for the player to display ammo and health counts. */
	HeadsUpGUI *headsUpGUI;
	/* Inventory of the player containing weapons (guns, grenades, etc). */
	WeaponManager *weaponManager;
	/* Collision response animator. 
	Kept as a member to easily modify collision particulars (gravity, etc). */
	ISceneNodeAnimatorCollisionResponse* collisionAnimator;

public:
/* Camera constants */
#define FPS_CAMERA		0
#define MAYA_CAMERA		1
#define THIRD_CAMERA	2
#define BIRDS_CAMERA	3

	Player(IrrlichtDevice *device, IAnimatedMeshSceneNode *model = 0);
	~Player();

	ICameraSceneNode* GetCamera() { return fpsCamera->GetCamera(); }
	ICameraSceneNode* GetActiveCamera() {return smgr->getActiveCamera();}
	IAnimatedMeshSceneNode* GetPlayerSceneNode() { return model; }
	//Weapon* GetActiveWeapon() { return activeWeapon; }	
	WeaponManager *GetWeaponManager() { return weaponManager; }

	///* Switch between different cameras */
	//void SetActiveCamera(s32 cameraType)
	//{
	//	//Tell the new camera to accept input (keyboard & mouse)
	//	cameraList[cameraType]->setInputReceiverEnabled ( true );
	//	//Tell the device to use the new camera
	//	device->getSceneManager()->setActiveCamera(cameraList[cameraType]);
	//}

	/* Changes the player's mesh to a user-defined mesh. */
	void SetAnimatedMeshSceneNode(IAnimatedMeshSceneNode *node)
	{
		//Stop the current scene node from rendering.
		if(model) model->remove();
		//Set the passed scene node to the player's scene node.
		model = node;
	}


	/* Create the collision response between the player and scenenodes in metatriangle selector. */
	void CreateCollisionRelationships(IMetaTriangleSelector* metaSelector, vector3df gravity);
	/* Set the gravity vector that affects the player. */
	void SetGravity(vector3df gravityVector);
	/* Sets the HUD's visibility */
	void SetHUDVisibility(bool value);
	/* Updates the player's internal states. */
	void Update();
	/* Controls the process of creating bullets and shooting them in space. */
	void Shoot();
	/* Que the player's death animation. */
	void Die();
	/* Captures the keyboard and mouse events and updates the camera. */
	bool OnEvent(const SEvent& event);

	/* Decrease the player's health by the passed damage. If the player has armor,
	first decrease those points, otherwise decrease the health directly.
	The lowest health possible is 0 points. */
	void DecreaseHealth(s32 damagePoints);
	/* Increase the player's health by the passed health increase (from health packs, etc).
	The health limit is 100 points. */
	void IncreaseHealth(s32 healthIncrease);
	/* Increase the player's armor by the passed armor increase (from armor powerups).
	The armor limit is 100 points. */
	void IncreaseArmor(s32 armorIncrease);
};