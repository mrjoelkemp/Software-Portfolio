//Joel Kemp
//ToyBoX
//Copyright 2008
#pragma once
#include "GameEntity.h"
#include "Weapon.h"
#include "Pistol.h"

#include "FPSCamera.h"

/*
Represents the manager of the game that
controls the weapon system by maintaining
a list of game weapons. Weapons can include:
guns, grenades, and other projectiles. 

By default, ToyBoX will support certain weapons, 
but will allow for custom weapon meshes to be 
handled by the weapon manager.
*/
class WeaponManager : public GameEntity
{
private:
	array<Weapon*> weaponList;
	Weapon* activeWeapon;
	
public:
#define PISTOL	0
#define UZI		1
#define LAZER	2
#define	SMACH	3
#define	GRENADE	4

	WeaponManager(IrrlichtDevice *device) : GameEntity(device)
	{
		/*** Set up Weapon List ***/
		weaponList.push_back(new Pistol(device));
		//weaponList.push_back(new Uzi(device));
	}

	void AddWeapon(Weapon *weapon)
	{
		weaponList.push_back(weapon);
		//TODO: Set activeWeapon -- pointer to newly added element
		activeWeapon = weaponList[weaponList.size() - 1];
	}

	/* 
	Removes the specified weapon, given by
	the passed pointer, from the weapon manager's
	list of available weapons.
	*/
	void RemoveWeapon(Weapon *weapon)
	{
		s32 index = weaponList.linear_search(weapon);
		weaponList.erase(index);
	}

	/*
	Sets the specified weapon, given by
	the passed pointer, as the currently
	active weapon by setting it as a child of 
	the first person camera.

	Note: Only the FPS camera will have children
	that are weapons.
	*/

	//TODO: Rework this implementation.
	void SetActiveWeapon(Weapon* weapon, FPSCamera *fpsCamera)
	{ 
		weapon->SetParent(fpsCamera->GetCamera()); 
		activeWeapon = weapon;
		activeWeapon->SetPostion(vector3df(5,-5,10));
	}

	/* Returns a pointer to the player's active weapon */
	Weapon *GetActiveWeapon() { return activeWeapon; }
	
	/*
	Returns a pointer to the specified weapon, 
	given by a passed index. 
	
	Note: you can use the defined constants 
	of the weapon manager to reference the 
	stock weapons.
	*/
	Weapon *GetWeaponPointer(s32 index)
	{ return weaponList[index]; }


	void Update()
	{
		
	}

	~WeaponManager()
	{
		weaponList.clear();
		printf("Weapon Manager Deleted \n");
	}

};