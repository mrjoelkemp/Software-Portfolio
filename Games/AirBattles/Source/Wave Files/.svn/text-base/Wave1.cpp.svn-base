#include "Wave1.h"

Wave1::Wave1(Player *player, IrrlichtDevice *device)
{
	//Store the pointer of the device
	this->device = device;
	//Store the pointer of the player
	this->player = player;

	//Set wave members
	numberEnemies = 1;
	enemyType = 1;
	waveId = 1;
	
	ShowLoadingScreen();

	//Initialize skybox
	skybox = new Sunset(this->device);

	//Initialize Terrain
	terrain = new AridTerrain(this->device);

	//Initialize Camera
	camera = new FollowPlayerCamera(this->device);
	camera->SetPlayerToFollow(this->player);

	//Set up the collision detection relationships between the objects
	//CreateCollisionRelations();

	//Render the wave number gui
	ShowWaveNumber();

	//Render the player's HUD
	player->CreateHUD();

	//Create the player's event receiver
	CreateEventReceiver();	

	//Create enemies
	//CreateEnemyList();

}

void Wave1::Update()
{
	//Update Enemy Positions
	//for(int i = 0; i<numberEnemies; i++)
	//	//enemies->data[i]->Update();
	//	enemies->operator [](i)->Update();
	
	//Update Player Positions
	player->Update();

	//Update Camera Positions
	camera->Update();
}

void Wave1::CreateCollisionRelations()
{
	/*TODO: Use a recursive pass through the 
		scenemanager and set collision between
		the player and the rest of scenenodes.
	*/

	//Add collision between player and enemies
	for(int i = 0; i<numberEnemies; i++)
		//enemies->data[i]->AttachCollisionResponse(player1->GetMeshPointer());
		enemies->operator [](i)->AttachCollisionResponse(player->GetAirplaneMesh());

	//Add collision between player and terrain
	player->AttachCollisionResponse(terrain->GetTerrainNodePointer());

}

void Wave1::CreateEventReceiver()
{
	receiver = new GameEventReceiver(player, camera, device);
	device->setEventReceiver(receiver);
}


void Wave1::ShowLoadingScreen()
{
	video::IVideoDriver* driver = device->getVideoDriver();
	gui::IGUIEnvironment* env = device->getGUIEnvironment();

	//Get size of window
	dimension2d<int> size = driver->getScreenSize();
	
	//Turn off cursor control
	device->getCursorControl()->setVisible(false);
	
	//Set the background color -- reddish
	video::SColor backColor(255,128,38,38);

	//Create in fader
	gui::IGUIInOutFader* inOutFader = env->addInOutFader();
	inOutFader->setColor(backColor,	video::SColor ( 0, 0, 0, 0 ));

	//Add Irrlicht logo
	env->addImage(driver->getTexture("../media/textures/irrlichtlogo2.png"), core::position2d<s32>(5,5));

	//Add "loading" text
	const int lwidth = size.Width - 20;
	const int lheight = 16;

	core::rect<int> pos(10, size.Height-lheight-10, 10+lwidth, size.Height-10);
	env->addImage(pos);
	
	gui::IGUIStaticText *statusText = env->addStaticText(L"Wave Loading...", pos, true);
	statusText->setOverrideColor(video::SColor(255,205,200,200));

	//Change font
	env->getSkin()->setFont(env->getFont("../media/fonts/fonthaettenschweiler.bmp"));

	//Set font color
	env->getSkin()->setColor(gui::EGDC_BUTTON_TEXT, video::SColor(255,100,100,100));

	//Render the current scene.
	driver->beginScene(true, true, backColor);
	env->drawAll();
	driver->endScene();

}

void Wave1::ShowWaveNumber()
{
	ISceneManager* smgr = device->getSceneManager();
	gui::IGUIEnvironment* env = device->getGUIEnvironment();
	video::IVideoDriver* driver = device->getVideoDriver();

	//Clear the environment to eliminate lingering components, if any.
	env->clear();

	//Add the Wave Text to the GUI Environment
	env->addImage(driver->getTexture("../media/textures/Wave1text.png"), 
		position2d<s32>(100, 50));

	//3 seconds converted to milliseconds
	u32 stopTime = device->getTimer()->getTime() + 3000;

	//Run timer for 3 seconds
	while(device->getTimer()->getTime() < stopTime)
	{
		//Increment the virtual timer
		device->getTimer()->tick();

		//Update wave's player and camera only
		//Note: We want the effect of the player and the
		//	environment, without enemies.
		//player->Update();
		//camera->Update();

		//Render the current scene.
		driver->beginScene(true, true, 0);
		smgr->drawAll();
		env->drawAll();
		driver->endScene();
	}

	//Remove the Wave text
	env->clear();
}

Wave1::~Wave1(void)
{
	if(terrain)
		delete terrain;
	if(camera)
		delete camera;
	if(skybox)
		delete skybox;
}
