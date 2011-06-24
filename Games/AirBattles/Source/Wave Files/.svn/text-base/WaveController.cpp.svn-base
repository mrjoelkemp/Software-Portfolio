#include "WaveController.h"

WaveController::WaveController(void)
{
	//Initialize the array of waves
	waves = new array<Wave*>();

	//Create an instance of the Wave Factory
	waveFactory = new WaveFactory();

	//Set up the array of waves.
	//waves->insert(wave1);

	//Initialize the device
	Initialize();

	//Show the player select interface
	//playerType = ShowPlayerSelectGUI();
	playerType = 1;

	//Set how many levels the game will have
	totalNumWaves = 1;

	//Start the game
	StartGame();
}

void WaveController::Initialize()
{
	device = createDevice(video::EDT_DIRECT3D9, dimension2d<s32>(800, 600), 32, false, false, false);

	//If the DX Device fails
	if(this->device == 0)
		//Create an OpenGL Device
		this->device = createDevice(video::EDT_OPENGL, dimension2d<s32>(640,480), 16, false, false, false);//, this);

	if (device == 0)
		exit(1); // could not create selected driver.
	
	this->smgr = device->getSceneManager();
	this->driver = device->getVideoDriver();
	this->env = device->getGUIEnvironment();

	//Toggle Mouse visibility off
	device->getCursorControl()->setVisible(false);
	device->setWindowCaption(L"AirBattles");


}//end Initialize()

void WaveController::StartGame()
{
	//Initialize the player
	player = new Player(playerType, 
		vector3df(2000,100,100),
		vector3df(0,0,0),
		device);

	//Iterate over the total number of waves
	for(s32 i=0; i< totalNumWaves; i++)
	{
		//Initialize the wave to the Wave Factory's output.
		//Note the usage of i+1 since the array is 0 based
		//but the waves start at count 1 (Wave 1, 2, 3, etc).
		
		//waves->operator [](i) = waveFactory->Create(i+1, device);
		//Add the current wave to the list.
		//waves->insert(waveFactory->Create(i+1, player, device));
		Wave *currentWave = waveFactory->Create(i+1, player, device);
		
		//Render the current wave
		//Render(waves->operator [](i));
		Render(currentWave);

		//When done rendering, delete the wave.
		delete currentWave;

	}

}//end StartGame()

bool WaveController::Render(Wave *wave)
{
	//ICameraSceneNode* camera = smgr->addCameraSceneNodeFPS(0,100.0f,1200.f);

	//camera->setPosition(core::vector3df(1900*2,255*2,3700*2));
	//camera->setTarget(core::vector3df(2397*2,343*2,2700*2));
	//camera->setFarValue(12000.0f);

	bool waveComplete = wave->IsWaveComplete();
	int lastFPS = -1;

	while(!waveComplete && device->run())
	{
		if(device->isWindowActive())
		{
			wave->Update();

			//Render the current scene.
			driver->beginScene(true, true, 0);
			smgr->drawAll();
			env->drawAll();
			driver->endScene();

			//Update the window caption -- Frames per second
			int fps = driver->getFPS();

			if (lastFPS != fps)
			{
				stringw str = L"Irrlicht AirBattles :";
				str = str + " FPS:" + fps;
				device->setWindowCaption(str.c_str());
				lastFPS = fps;
			}

		}//end If
	}//end While

	//Render returns true when the device has closed, or the wave is complete
	return true;		
}//end Render()

s32 WaveController::ShowPlayerSelectGUI()
{
	//TODO: Implement method
	s32 result = 0;

	return result;
}//end ShowPlayerSelectGui()

WaveController::~WaveController(void)
{
	//If the array waves exists
	if(waves)
	{
		//Delete all elements
		waves->clear();
		//Delete pointer
		delete waves;
	}

	//If the factory exists
	if(waveFactory)
		delete waveFactory;

	device->drop();
}
