#include "MainGui.h"

MainGui::MainGui()
{
	InitializeDevices();
	startGame = false;
	ShowACMScreen();
}

void MainGui::ShowACMScreen()
{
	//Clear the environment to eliminate lingering components, if any.
	env->clear();

	//Add the Wave Text to the GUI Environment
	env->addImage(driver->getTexture("../media/textures/acm.jpg"), 
		position2d<s32>(240, 125));

	//3 seconds converted to milliseconds
	u32 stopTime = device->getTimer()->getTime() + 3000;

	//Run timer for 3 seconds
	while(device->getTimer()->getTime() < stopTime)
	{
		//Increment the virtual timer
		device->getTimer()->tick();

		//Render the current scene.
		driver->beginScene(true, false, video::SColor(0, 255,255,255));
		//smgr->drawAll();
		env->drawAll();
		driver->endScene();

		device->yield();
	}

	//Remove the Wave text
	env->clear();
}

bool MainGui::OnEvent(const SEvent& event)
{
	//If the event is from the MainGUI
	if (event.EventType == EET_GUI_EVENT)
	{
		env = device->getGUIEnvironment();

		//Get the ID of the component that generated the event
		s32 id = event.GUIEvent.Caller->getID();

		switch(event.GUIEvent.EventType)
		{
			case gui::EGET_BUTTON_CLICKED:
				switch(id)
				{
					case 101: //New Game
						device->closeDevice();
						startGame = true;
						return true;
					case 102: //Load Game
						env->addFileOpenDialog(L"Please choose a file.");
						return true;
					case 103: //Options
						//Add some GUI stuff here
						return true;
					case 104: //Quit
						device->closeDevice();
						startGame = false;
						return true;
				}
				break;

			default:
				break;
		
		}//end switch
	}//end if

	return false;
}

void MainGui::InitializeDevices()
{
	device = createDevice(video::EDT_DIRECT3D9, core::dimension2d<s32>(800, 600), 16, 
				false, false, false, this);
	
	//Toggle Mouse visibility on
	device->getCursorControl()->setVisible(true);
	//Set device window caption
	device->setWindowCaption(L"Irrlicht AirBattles");

	env = device->getGUIEnvironment();
	driver = device->getVideoDriver();
	smgr = device->getSceneManager();

	//Create event receiver to capture gui events
	//device->setEventReceiver(this);
}

bool MainGui::Render()
{	
	env = device->getGUIEnvironment();
	driver = device->getVideoDriver();

	//Add the background image -- cover entire window
	env->addImage(driver->getTexture("../media/textures/mainbg2.jpg"), core::position2d<s32>(2,0));

	//Add a new font for text
	env->getSkin()->setFont(env->getFont("../media/fonts/fonthaettenschweiler.bmp"));

	//Add buttons to the MainGUI
	env->addButton(core::rect<s32>(10,210,110,210 + 50), 0, 101, L"New Game", L"Starts a New Game of Airbattles");
	env->addButton(core::rect<s32>(10,270,110,270 + 50), 0, 102, L"Load Game", L"Continues an Existing Game");
	env->addButton(core::rect<s32>(10,330,110,330 + 50), 0, 103, L"Options", L"Configure Game Options");
	env->addButton(core::rect<s32>(10,390,110,390 + 50), 0, 104, L"Quit", L"Exit AirBattles");

	//Render all 2D graphics
	while(device->run())
		if (device->isWindowActive())
		{
			//Render the current GUI environment.
			driver->beginScene(true, true, 0);
			env->drawAll();
			driver->endScene();
		}
		
	//device->closeDevice();
	device->drop();

	return startGame;
}

MainGui::~MainGui()
{

}