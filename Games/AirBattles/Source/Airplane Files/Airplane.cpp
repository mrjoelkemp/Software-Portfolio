#include "Airplane.h"

Airplane::Airplane()
{
	//CreateTriangleSelector();
}

void Airplane::CreateTriangleSelector()
{
	ITriangleSelector *selector = device->getSceneManager()->createOctTreeTriangleSelector(mesh->getMesh(),
		mesh);

	mesh->setTriangleSelector(selector);
	selector->drop();
}//end CreateTriangleSelector()

void Airplane::AttachCollisionResponse(ISceneNode* collider, vector3df collisionRadius, vector3df radiusTranslation)
{
	ISceneNodeAnimator* anim = device->getSceneManager()->createCollisionResponseAnimator(
		mesh->getTriangleSelector(), collider, collisionRadius,
		core::vector3df(0,0,0), //gravity 
		radiusTranslation);	//Translating the ellipsoid

	collider->addAnimator(anim);
	anim->drop();
}//end AttachCollisionResponse()

void Airplane::Shoot(s32 bulletType)
{
	/** 
	Struct used for the rendering of 
	the impact of bullets.
	*/
	struct SParticleImpact
	{
		u32 when; /**< Point of collision*/
		vector3df pos;	/**< Position of collision*/
		vector3df outVector; /**< Resulting position*/
	};

	ISceneManager* smgr = device->getSceneManager();
	//ICameraSceneNode* camera = smgr->getActiveCamera();
	ISceneNode* player = smgr->getSceneNodeFromName("player");
	video::IVideoDriver* driver = device->getVideoDriver();
	ITriangleSelector* mapSelector = smgr->getSceneNodeFromName("terrain")->getTriangleSelector();
	array<SParticleImpact*> Impacts;
	SParticleImpact *imp = new SParticleImpact();
	
	//Initialize structure member
	imp->when = 0;

	////Get the line of camera sight
	//vector3df start = camera->getPosition();
	//vector3df end = (camera->getTarget() - start);
	//end.normalize();
	//start += end*8.0f;
	//end = start + (end * camera->getFarValue());

	//Get the line of airplane sight
	//Get forward vector of  Node in the direction that if faces
	vector3df forwardVector = vector3df(0,0,50000);
	matrix4 m;
	m.setRotationDegrees(player->getRotation());
	m.transformVect(forwardVector);	//vector contains the absolute forward vector


	vector3df start = player->getPosition();
	//vector3df end = start - player->getRotation();// + vector3df(0,0,2000);
	vector3df end = start + forwardVector;
	
	//player->getRotation
	//end.normalize();
	//start += end*8.0f;
//	end = start + (end  camera->getFarValue());
	//end = start + (end * vector3df(start.X, start.Y, 5000));	//Scale the value back
	//end = start + end;
	//// create map triangle selector
	//mapSelector = smgr->createOctTreeTriangleSelector(quakeLevelMesh->getMesh(0),
	//	quakeLevelNode, 128);

	//Get forward vector of  Node in the direction that if faces
	//vector3df vector = vector3df(0,0,1);
	//matrix4 m;
	//m.setRotationDegrees(player->getRotation());
	//m.transformVect(vector);	//vector contains the absolute forward vector

	//Get intersection point with map
	triangle3df triangle;
	line3d<f32> line(start, end);

	if (smgr->getSceneCollisionManager()->getCollisionPoint(
		line, mapSelector, end, triangle))
	{
		//Collides with terrain
		vector3df out = triangle.getNormal();
		out.setLength(0.03f);

		imp->when = 1;
		imp->outVector = out;
		imp->pos = end;
	}
	else
	{
		////Doesn't collide with terrain

		vector3df forwardVector = vector3df(0,0,50000);
		matrix4 m;
		m.setRotationDegrees(player->getRotation());
		m.transformVect(forwardVector);	//vector contains the absolute forward vector

		//Doesn't collide with terrain
		vector3df start = player->getPosition();
		//vector3df end = (start + 5000);
//		vector3df end = start - player->getRotation();// + vector3df(0,0,2000);
		vector3df end = start + forwardVector;

		//end.normalize();
		//start += end*8.0f;
		//end = start + (end * camera->getFarValue());
		//end = start + (end * vector3df(start.X, start.Y, 5000));

	}

	ISceneNode* node = 0;

	switch(bulletType)
	{

	case 1:	//Machine Gun
		//Create fire ball
		node = smgr->addBillboardSceneNode(0,		//Parent
			//dimension2d<f32>(25,25),				//Size of Billboard
			dimension2d<f32>(25, 25),
			start);									//Start position

		node->setMaterialFlag(video::EMF_LIGHTING, false);
		node->setMaterialTexture(0, device->getVideoDriver()->getTexture("../media/textures/fireball.bmp"));
		node->setMaterialType(video::EMT_TRANSPARENT_ADD_COLOR);
		break;

	case 2: //Missile

		//Create fire ball
		node = smgr->addBillboardSceneNode(0,		//Parent
			//dimension2d<f32>(25,25),				//Size of Billboard
			dimension2d<f32>(25, 25),
			start);									//Start position

		node->setMaterialFlag(video::EMF_LIGHTING, false);
		node->setMaterialTexture(0, device->getVideoDriver()->getTexture("../media/textures/missile.png"));
		node->setMaterialType(video::EMT_TRANSPARENT_ADD_COLOR);
		break;

	
	}

	f32 length = (f32)(end - start).getLength();
	const f32 speed = 3.0f;
	u32 time = (u32)(length / speed);

	ISceneNodeAnimator* anim = 0;

	//Set fireball flight line
	anim = smgr->createFlyStraightAnimator(start, end, time);
	node->addAnimator(anim);
	anim->drop();

	//Set fireball termination animator
	anim = smgr->createDeleteAnimator(time);
	node->addAnimator(anim);
	anim->drop();

	if (imp->when)
	{
		//Create impact note
		imp->when = device->getTimer()->getTime() + (time - 100);
		Impacts.push_back(imp);
	}

/*
	// play sound
	#ifdef USE_IRRKLANG
	if (ballSound)
		irrKlang->play2D(ballSound);
	#endif
	#ifdef USE_SDL_MIXER
	if (ballSound)
		playSound(ballSound);
	#endif
*/
	delete imp;
}


s32 Airplane::GetSpeed()			{return speed;}
s32 Airplane::GetHealth()			{return health;}
s32 Airplane::GetArmor()			{return armor;}		
s32 Airplane::GetWeight()			{return weight;}
s32 Airplane::GetBulletDamage()		{return bulletDamage;}
vector3df Airplane::GetPosition()	{return mesh->getPosition();}
vector3df Airplane::GetRotation()	{return mesh->getRotation();}
IAnimatedMeshSceneNode* Airplane::GetMeshPointer()	{return mesh;}

void Airplane::SetSpeed(s32 value)			{speed = value;}
void Airplane::SetHealth(s32 value)			{health = value;}
void Airplane::SetArmor(s32 value)			{armor = value;}
void Airplane::SetWeight(s32 value)			{weight = value;}
void Airplane::SetBulletDamage(s32 value)	{bulletDamage = value;}
void Airplane::SetPosition(vector3df value)	{mesh->setPosition(value);}
void Airplane::SetRotation(vector3df value) {mesh->setRotation(value);}
void Airplane::SetDevice(IrrlichtDevice *device) {this->device = device;}
