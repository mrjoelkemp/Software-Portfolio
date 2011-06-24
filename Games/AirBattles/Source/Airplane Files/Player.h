#pragma once
#include "Airplane.h"
#include "AirplaneFactory.h"
#include "HUD.h"

/**
Represents the game's player.
*/
class Player : public IEventReceiver
{
public:
	/**
	Player constructor that creates a new aircraft
	specified by planeID at the defined position, 
	and with an initial defined rotation.
	*/
	Player(s32 planeId, /**< Type of plane */
		vector3df position, /**< Initial Position */
		vector3df rotation, /**< Initial Rotation */
		IrrlichtDevice *device /**< Irrlicht Device Pointer */
		);

	~Player(void);
	
	c8* GetName(){return this->name;}
	Airplane* GetAirplane(){return airplane;}
	vector3df GetPosition(){return airplane->GetPosition();}
	vector3df GetRotation(){return airplane->GetRotation();}
	IAnimatedMeshSceneNode* GetAirplaneMesh(){return airplane->GetMeshPointer();}

	void SetPosition(vector3df position){airplane->SetPosition(position);}
	void SetRotation(vector3df rotation){airplane->SetRotation(rotation);}
	void SetName(c8 *name) {this->name = name;}
	
	/**
	Update the player's position based on rotation.
	*/
	void Update();
	
	/**
	Creates the player's heads up display.
	*/
	void CreateHUD();

	void AttachCollisionResponse(ISceneNode *collider){airplane->AttachCollisionResponse(collider);}
	bool OnEvent(const SEvent &event);

private:
	IrrlichtDevice *device;

	c8 *name;	/**< Player's name */
	HUD *headsUpDisplay; /**< Player's Heads Up Display */
	Airplane *airplane;

	//Movement Variables
	f32 rotationUpLimit;
	f32 rotationDownLimit;
	f32 rotationLeftLimit;
	f32 rotationRightLimit;
	vector3df playerPosition, playerRotation;
	s32 playerSpeed, cameraMode;
};
