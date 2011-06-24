//Joel Kemp
//ToyBoX
//Copyright 2008
#pragma once
#include "GameEntity.h"
#include "AmmoGUI.h"
#include "HealthGUI.h"

/* Represents the player's heads up display.
The display contains an ammo counter, a health system, and maybe some logos. */
class HeadsUpGUI : public GameEntity
{
private:
	AmmoGUI *ammoGUI;
	HealthGUI *healthGUI;

public:

	HeadsUpGUI(IrrlichtDevice *device) : GameEntity(device)
	{
		ammoGUI = 0;
		healthGUI = 0;
		
		//Create AmmoGUI
		ammoGUI = new AmmoGUI(device);
		//Create HealthGUI
		healthGUI = new HealthGUI(device);
		//TODO: Create other HUD stuff (map/radar, etc)

	}
	
	/* Updates the count of the ammo and health interfaces by passing player information. */
	void Update(s32 ammoCount, s32 healthCount)
	{
		if(healthGUI) healthGUI->Update(healthCount);
		if(ammoGUI)	ammoGUI->Update(ammoCount);
	}//end Update()

	/* Changes the visibility of the HUD. */
	void SetVisible(bool value)
	{
		if(ammoGUI) ammoGUI->SetVisible(value);
		if(healthGUI) healthGUI->SetVisible(value);
	}//end SetVisible()

	~HeadsUpGUI()
	{
		if(ammoGUI)
			delete ammoGUI;
		if(healthGUI)
			delete healthGUI;
		
		printf("HUD Deleted \n");
	}
};