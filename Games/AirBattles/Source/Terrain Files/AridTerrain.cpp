/*
TODO: For our Airbattles terrain, we should use the ShTlTerrainSceneNode which would allow for 
incredibly large customizeable terrains. The source and demo are located /todos/terrainscenenode
folder. The main.cpp file includes an example usage of this custom scene node.
*/

#include "AridTerrain.h"

AridTerrain::AridTerrain(IrrlichtDevice* irrDevice)
{
	device = irrDevice;
	ISceneManager* smgr = device->getSceneManager();
	IVideoDriver* driver = device->getVideoDriver();

	// add terrain scene node
	terrain = smgr->addTerrainSceneNode( 
		"../media/textures/aridheightmap.bmp",						// height map file name
		0,										// parent node
		-1,										// node id
		vector3df(0.f, 0.f, 0.f),				// position
		vector3df(0.f, 0.f, 0.f),				// rotation
		vector3df(600.0f, 3.5f, 600.0f),		// scale
		SColor ( 255, 255, 255, 255 ),			// vertexColor,
		4,										// maxLOD
		ETPS_17,								// patchSize
		0										// smoothFactor
		);

	//Set terrain options
	terrain->setMaterialFlag(video::EMF_LIGHTING, false);
	terrain->setMaterialTexture(0, driver->getTexture("../media/textures/aridtexture.jpg"));
	terrain->setMaterialTexture(1, driver->getTexture("../media/textures/ariddetailmap.jpg"));
	terrain->setMaterialType(video::EMT_DETAIL_MAP);
	terrain->scaleTexture(1.0f, 20.0f);
	terrain->setName("aridterrain");		//Used to locate this scene node in the scene manager

	//Create triangle selector for the terrain	
	ITriangleSelector *selector = smgr->createTerrainTriangleSelector(terrain, 0);
	terrain->setTriangleSelector(selector);
	selector->drop();

}//end Terrain()

/*
Create a terrain triangle selector for the terrain scene node.
*/
void AridTerrain::CreateTriangleSelector()
{
	//Create triangle selector for the terrain	
	ITriangleSelector *selector = device->getSceneManager()->createTerrainTriangleSelector(terrain);
	terrain->setTriangleSelector(selector);
	selector->drop();
}

//Terrain::Terrain(IrrlichtDevice* irrDevice, const c8 * heightMapFileName, const c8 * textureFileName, 
//				 const c8 * detailMapFileName, vector3df position, vector3df scale)
//{
//	device = irrDevice;
//	ISceneManager* smgr = device->getSceneManager();
//	IVideoDriver* driver = device->getVideoDriver();
//
//	// set atributes of terrain
//	s32 terrainWidth = 1000;
//	s32 terrainHeight = 1000;
//	s32 meshSize = 100;
//	f32 tileSize = 1;
//	vector3df terrainPos(0.0f, 0.0f, 0.0f);
//		
//	// fog
//	driver->setFog(video::SColor(255,100,101,140), true, tileSize*meshSize/4, tileSize*(meshSize-4)/2, 0.05f);
//	
//	// light
//	scene::ILightSceneNode* light = smgr->addLightSceneNode(0, core::vector3df(0,0,0), 
//		video::SColorf(255, 255, 255, 255), 1000.0f);
//	video::SLight ldata = light->getLightData();
//    ldata.AmbientColor = video::SColorf(0.2,0.2,0.2);
//	ldata.DiffuseColor = video::SColorf(1,1,1);
//	ldata.Type = video::ELT_DIRECTIONAL;
//	ldata.Position = core::vector3df(-10,5,-5);
//	light->setLightData(ldata);
//
//	// create terrain scene node
//    ShTlTerrainSceneNode* terrain = new ShTlTerrainSceneNode(smgr, terrainWidth, terrainHeight, tileSize, meshSize);
//	terrain->drop();
//
//	// setup terrain node
//	terrain->setMaterialFlag(video::EMF_LIGHTING, true);
//	//terrain->setMaterialFlag(video::EMF_WIREFRAME, true);
//	//terrain->setMaterialFlag(video::EMF_BACK_FACE_CULLING, false);
//    terrain->setMaterialFlag(video::EMF_FOG_ENABLE, true);
//    
//    terrain->setPosition(terrainPos);
//
//	//TODO: Implement the terrain to render around the player
//	// set terrain to render around camera
//	terrain->follow(smgr->getSceneNodeFromName("player"));
//
//	// randomize terrain
//	makeRandomHills(terrain, 20000, 20);
//	makeRandomHills(terrain, 100000, 5);
//
//	// smooth normals
//	terrain->smoothNormals();
//
//	// randomize color
//	randomizeColor(terrain);
//
//	// randomize texture UV coords
//    randomizeUV(terrain);
//
//	// set detail texture
//	terrain->setMaterialTexture(0, driver->getTexture("../media/textures/detailmap3.jpg"));
//
//	//Create triangle selector for the terrain	
//	//selector = smgr->createTerrainTriangleSelector(terrain, 0);
//	//terrain->setTriangleSelector(selector);
//	//selector->drop();
//
//
//}

/*
Tell the collider to respond to collision with the terrain.
*/
void AridTerrain::AttachCollisionResponse(ISceneNode* collider, 
									vector3df collisionRadius, 
									vector3df radiusTranslation)
{
	ISceneNodeAnimator* anim = device->getSceneManager()->createCollisionResponseAnimator(
		terrain->getTriangleSelector(), collider, collisionRadius,
		core::vector3df(0,0,0), //gravity 
		radiusTranslation);

	collider->addAnimator(anim);
	anim->drop();
}//end AttachCollisionResponseAnimator()


ITerrainSceneNode* AridTerrain::GetTerrainNodePointer()
{
	return terrain;
}

AridTerrain::~AridTerrain(void)
{
}
