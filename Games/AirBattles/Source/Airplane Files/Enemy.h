#pragma once
#include "Airplane.h"
#include "AirplaneFactory.h"

/**
 Represents an enemy aircraft.
*/
class Enemy :
	public Airplane
{
public:
	/** 
	Constructor for the enemy class.
	Creates an enemy aircraft of the defined type
	at the defined position, with the defined
	initial rotation.
	*/
	Enemy(s32 planeId = 0, /**< The id of the aircraft to be used*/
		vector3df position = vector3df(0,0,0), /**< The initial position of the enemy*/
		vector3df rotation = vector3df(0,0,0), /**< The initial rotation of the enemy*/
		IrrlichtDevice* device = 0 /**< Pointer to the Irrlicht Device */
		); 
	
	~Enemy(void);
	
	/** 
	Update the enemy position and rotation
	based on its type of motion (motionType).
	*/
	void Update();

	/** Set the enemy's motion type*/
	void SetMotionType(s32 type);

private:
	/**
	Controls the flight path of the enemy.
	0: Straight Path,
	1: Circular Path,
	2: Vertical Path
	*/
	s32 motionType;
	/** Pointer to the main Irrlicht Device */
	IrrlichtDevice *device;
};
