//Joel Kemp
//FPS Project
//Copyright 2008

#pragma once
#include "GameEntity.h"

/*
Represents a single health bar
that is used in the health interface
system defined below this class. Each
bar represents 10 points of health.
*/
class HealthBar : public GameEntity
{
private:
	bool active;
	ITexture *healthBarIcon;

public:

	HealthBar(IrrlichtDevice *device) : GameEntity(device)
	{
		healthBarIcon = driver->getTexture("media/textures/healthBarIcon.jpg");
		active = false;
	}

	bool GetActive() { return active; }
	ITexture *GetTexture() { return healthBarIcon; }

	void SetActive(bool value) { active = value; }
};


/* Represents the health interface for the player in the game.
The health interface will be implemented using an array of box-like textures that 
will increment and decrement accordingly. 
*/
class HealthGUI : public GameEntity
{

#define MAX_HEALTH_BARS 10

public:

	HealthGUI(IrrlichtDevice *device);
	
	/*
	Increase the number of health bars by
	setting the leftmost non-active bar to 
	active.
	*/
	void IncreaseHealth();

	/*
	Decrease the number of health bars by
	setting the rightmost active bar to 
	inactive.
	*/
	void DecreaseHealth();

	/*
	Updates the health interface system
	by determining how many bars should
	be active at a given time. This 
	implementation takes in the player's
	amount of health each frame.
	*/
	void Update(s32 healthAmount);

	/* Changes the visibility of the Health Gui. */
	void SetVisible(bool value);

	~HealthGUI();
	
private:
	/* Array of single health bars */
	HealthBar **healthbars;
	
	/*
	Used to keep track of the health changes
	between frames to determine how many
	bars should be active.
	*/
	s32 previousRemainder;

	/* Panel that houses the healthbars. */
	IGUITab *healthTab;
};