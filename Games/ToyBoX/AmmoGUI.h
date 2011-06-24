//Joel Kemp
//ToyBoX
//Copyright 2008
#pragma once
#include "GameEntity.h"

/* Represents the ammunition interface that indicates player's ammo count.
The ammo interface consists of a numerical string that indicates the ammo count. 
(Working implementation) */
class AmmoGUI : public GameEntity
{

public:
	AmmoGUI(IrrlichtDevice *device);

	/* Increase the value of the ammo string. */
	void IncreaseAmmo();
	
	/* Decrease the value of the ammo string. */
	void DecreaseAmmo();
	
	/* Update the text based ammunition counter by increasing or decreasing
	the count, based on the change in the passed ammo count. */
	void Update(s32 ammoCount);
	/* Toggles the ammo GUIs visibility. */
	void SetVisible(bool value);
	~AmmoGUI();

private:
	//String stuff goes here
	IGUIStaticText *ammoText;
	IGUITab *ammoTab;
	s32 previousAmmoCount;
};