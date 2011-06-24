#pragma once
#include <irrlicht.h>

using namespace irr;
using namespace scene;
using namespace core;

/**
 * Base class for game aircraft (including players and enemies)
 */
class Airplane
{
public:
	/**
	 Constructor for the airplane base class.
	 Automatically sets up the triangle selector for the
	 airplane, to be used in collision detection.
	*/
	Airplane();

	/** Return Airplane Speed */
	s32 GetSpeed();
	/** Return Airplane Health */
	s32 GetHealth();
	/** Return Airplane Armor */
	s32 GetArmor();
	/** Return Airplane Weight */
	s32 GetWeight();
	/** Return Airplane Bullet Damage */	
	s32 GetBulletDamage();
	/** Return Airplane Current Position */
	vector3df GetPosition();
	/** Return Airplane Current Rotation */
	vector3df GetRotation();
	/** 
	Return a pointer to the Airplane's 
	IAnimatedMeshSceneNode object
	*/
	IAnimatedMeshSceneNode* GetMeshPointer();

	/** Set Airplane Speed */
	void SetSpeed(s32 value);
	/** Set Airplane Health */
	void SetHealth(s32 value);
	/** Set Airplane Armor */
	void SetArmor(s32 value);
	/** Set Airplane Weight */
	void SetWeight(s32 value);
	/** Set Airplane Bullet Damage */
	void SetBulletDamage(s32 value);
	/** Set Airplane Current Position */
	void SetPosition(vector3df value);
	/** Set Airplane Current Rotation */
	void SetRotation(vector3df value);
	/** Set Airplane pointer to the Irrlicht Device */
	void SetDevice(IrrlichtDevice* device);

	/** 
	Attach a collision response animator to the 
	ISceneNode that will collide with the airplane.
	i.e. Tell the collider to react to collision with
	the airplane.
	*/
	void AttachCollisionResponse(ISceneNode* collider, 
		vector3df collisionRadius = vector3df(100,100,60), 
		vector3df radiusTranslation = vector3df(0,0,0));

	/**
	Render a bullet by attaching a bullet texture
	to a 2d billboard object. The caller can specify
	which bullet to render by the bulletType parameter.
	*/
	void Shoot(s32 bulletType);
	//void Update();

protected:
	/** 
	The scene node that represents the airplane 
	mesh model, rendered by the Scene Manager.
	*/
	IAnimatedMeshSceneNode* mesh;	

	IrrlichtDevice* device;

	/**
	Airplane's speed. Used in calculations
	of acceleration.
	*/
	s32 speed;

	/**
	Airplane's health. Maximum value is 100.
	*/
	s32 health;

	/**
	Airplane's armor. Maximum value is 100.
	*/
	s32 armor;

	/**
	The base amount of damage done by the airplane's
	bullets. i.e. The amount of points deducted from the
	enemy's health.
	*/
	s32 bulletDamage;

	/**
	The weight of the airplane. Used in physics
	equations, to manipulate acceleration of the
	airplane, and movement.
	*/
	s32 weight;

	/**
	Creates the Airplane's triangle selector
	that will handle collision against any 
	vertex face of the mesh.
	*/
	void CreateTriangleSelector();



};