#include "Game.h"

Game::Game()
{
	device = 0;
	mainMenu = 0;
	level = 0;
	player = 0;
	g_Gravity = vector3df(0,-50.0f,0);
	metaSelector = 0;
	enemyManager = 0;
	nodeFound = 0;
	//We start in simulation mode
	editingMode = false;
}

void Game::Initialize()
{

#pragma region Device Initialization
	//Initialize device and components
	device = createDevice(EDT_DIRECT3D9, dimension2d<s32>(800,600), 16);//, false, false, true);
	if (device == 0) device = createDevice(EDT_OPENGL, dimension2d<s32>(800,600), 16);//, false, false, true);
	env = device->getGUIEnvironment();
	driver = device->getVideoDriver();
	smgr = device->getSceneManager();
	
	//Set up the device
	device->setResizeAble(true);
	//Add media folder as the main media search path
	device->getFileSystem()->addFolderFileArchive("media/");
	device->setWindowCaption(L"ToyBox | Joel Kemp");
	device->setEventReceiver(this);
	device->getCursorControl()->setVisible(editingMode);

	//Change the font
	IGUIFont* font = env->getFont("fonts/font_lucida.bmp");
	if (font) env->getSkin()->setFont(font);
#pragma endregion

	mainMenu = new MainMenu(device);
	level = new Level(device);
	player = new Player(device);
	metaSelector = smgr->createMetaTriangleSelector();
	enemyManager = new EnemyManager(device);

	//Load up default game objects (level, player, etc)
	LoadDefaultObjects();

	//Establish collision relationships between objects.
	CreateCollisions();
}//end Initialize()


void Game::LoadDefaultObjects()
{
	//Load up default objects
	LoadConfigFile("config.xml");
	
	//Load up default level
	level =	ContentLoader::LoadLevel(StartUpMapFile.c_str(), device);

	//Center player about level
	vector3df playerPos = player->GetCamera()->getPosition();
	vector3df mapCenter = level->GetSceneNode()->getBoundingBox().getCenter();
	f32 xpos = playerPos.X - mapCenter.X;
	f32 ypos = playerPos.Y - mapCenter.Y;
	f32 zpos = playerPos.Z - mapCenter.Z;
	level->SetPosition( vector3df(xpos,ypos,zpos) );

	//Load up enemies 
	//Set enemies near map center.

	for(int i = 0; i< NUM_ENEMIES; i++)
		enemyManager->AddEnemy(vector3df(xpos, ypos, zpos) + vector3df(((f32)i*10), 0,0));

}//end LoadDefaultObjects()

//TODO: Fix enemy collision response!
void Game::CreateCollisions()
{
	/*** Set up the meta triangle selector ***/

	//Add level's selector
	if(level) metaSelector->addTriangleSelector(level->GetSceneNode()->getTriangleSelector());
	
	//Establish weapon collision response
	//TODO: Add all weapon selectors
	//for( iterate over every enemy in the world )
	
	//TODO: Add each enemy's selector
//	for(int i=0; i<(int)enemyList.size(); i++)
//		if(enemyList[i])
//			metaSelector->addTriangleSelector( enemyList[i]->GetMeshSceneNode()->getTriangleSelector());

	//Establish player's collision response
	player->CreateCollisionRelationships(metaSelector, g_Gravity);

	//TODO: Add player's selector (Camera or mesh?)
	metaSelector->addTriangleSelector(player->GetCamera()->getTriangleSelector());

	//Establish each enemy's collision response
//	for(int i=0; i<(int)enemyList.size(); i++)
//		if(enemyList[i])
//			enemyList[i]->CreateCollisionRelationships(metaSelector, g_Gravity);
}


void Game::LoadConfigFile(stringc fn)
{
	//Read configuration from xml file
	IXMLReader* xml = device->getFileSystem()->createXMLReader(fn.c_str());

	while(xml && xml->read())
	{
		switch(xml->getNodeType())
		{
			case EXN_TEXT:
				//In this xml file, the only text which occurs is the messageText
				MessageText = xml->getNodeData();
				break;
			case EXN_ELEMENT:
				{
					if (stringw("startUpModel") == xml->getNodeName())
						StartUpModelFile = xml->getAttributeValue(L"file");
					else if (stringw("messageText") == xml->getNodeName())
						Caption = xml->getAttributeValue(L"caption");
					else if (stringw("modelTexture") == xml->getNodeName())
						StartUpModelTextureFile = xml->getAttributeValue(L"file");
					else if (stringw("startUpMap") == xml->getNodeName())
						StartUpMapFile = xml->getAttributeValue(L"file");
					else if (stringw("startUpCrosshair") == xml->getNodeName())
						StartUpCrosshairFile = xml->getAttributeValue(L"file");
					else if (stringw("startUpWeapon") == xml->getNodeName())
						StartUpWeaponFile = xml->getAttributeValue(L"file");
				}
				break;
		}//end switch
	}//end while

	if (xml) xml->drop(); // don't forget to delete the xml reader
}//end LoadConfigFile()



bool Game::OnEvent(const SEvent &event)
{
	#pragma region Keyboard_Events
	if (event.EventType == EET_KEY_INPUT_EVENT && event.KeyInput.PressedDown == false)
		//Escape swaps camera input (disabled / enabled)
		switch(event.KeyInput.Key)
		{
			//ESC Toggles the game's mode between Simulation and Edit
			case KEY_ESCAPE:
			{
				//Toggle game mode
				editingMode = !editingMode;					
				//If the game is in edit mode
				(editingMode) ? StartEditMode() : StartSimulationMode();
				return true;
			}
			
			//Tab toggles the player's camera receiver
			case KEY_TAB:
			{
				if(mainMenu->GetMenu()->isVisible())
					player->GetCamera()->setInputReceiverEnabled(!player->GetCamera()->isInputReceiverEnabled());
				return true;
			}

			//Q Key quite the application
			case KEY_KEY_Q:
			{
				//TODO: Message prompt for exit
				device->closeDevice();
				return true;
			}
			default: 
				player->OnEvent(event);
		}//end switch
	#pragma endregion
	
	#pragma region Mouse_Events
	//Grab the node while holding down the left mouse button.
	if (event.EventType == EET_MOUSE_INPUT_EVENT &&			//Is Mouse Event
		event.MouseInput.Event == EMIE_LMOUSE_PRESSED_DOWN &&	//Is Left Button Held Down
		this->editingMode)									//Is Editing Mode
	{ 		
		ISceneCollisionManager* scm = smgr->getSceneCollisionManager();

		//Grab the scene node that's in the cursor's sight
		nodeFound = scm->getSceneNodeFromScreenCoordinatesBB(
			device->getCursorControl()->getPosition(), 0, false);

		//Get the forward line from the cursor's position
		line3d<f32> castedLine = scm->getRayFromScreenCoordinates(device->getCursorControl()->getPosition());

		//Output parameters for collision 
		vector3df pointFound = vector3df(0, 0, 0);
		triangle3df tri;

		//Get collision information between ray and world
		scm->getCollisionPoint(castedLine, metaSelector, pointFound, tri);
		
		//Return false if no scene nodes are clicked
		if (nodeFound == NULL || nodeFound == 0) 
			{ return false; }
		
		//If the nodeFound is a game object (based on node's id)
		else if(nodeFound->getID() == -1)
		{			
			//Set the parent of the node to camera (moves with camera)
			nodeFound->setParent(player->GetCamera());
			//Set the position relative to the parent
			nodeFound->setPosition(vector3df(0,0,20));			
		}
	}

	//Release the node when left mouse button is released
	if (event.EventType == EET_MOUSE_INPUT_EVENT &&			//Is Mouse Event
		event.MouseInput.Event == EMIE_LMOUSE_LEFT_UP &&	//Is Left Button Released
		this->editingMode)									//Is Editing Mode
	{
		//Store world position
		vector3df nodePos = nodeFound->getAbsolutePosition();

		//Kill parent relationship
		nodeFound->setParent(smgr->getRootSceneNode());
		//Set new position to the old node position (relative to world, not parent)
		nodeFound->setPosition(nodePos);
	}

	#pragma endregion

	#pragma region GUI_Events
	if (event.EventType == EET_GUI_EVENT)
	{
		s32 id = event.GUIEvent.Caller->getID();

		switch(event.GUIEvent.EventType)
		{
			//Menu item was clicked
			case EGET_MENU_ITEM_SELECTED:
			{
				IGUIContextMenu* menu = (IGUIContextMenu*)event.GUIEvent.Caller;
				//Get the id of the selected item
				s32 id = menu->getItemCommandId(menu->getSelectedItem());

				switch(id)
				{
					/*** File Menu ***/
					case 100: //File -> Save Simulation
						//env->addFileOpenDialog(L"Please select a model file to open");
						break;
					case 101: //File -> Open Simulation
						//env->addFileOpenDialog(L"Please select your game archive/directory");
						break;
					case 102: //File -> Change Media Archive
						//env->addFileOpenDialog(L"Please select your game archive/directory");
						break;
					case 103: //File -> Quit
						device->closeDevice();
						break;

					/*** Add Menu ***/
					case 210: //Add -> Level/Map
						env->addFileOpenDialog(L"Please select a level/map file to open",true,0,id);
						break;
					
					/* Add Mesh */
					case 201: //Add -> Mesh -> Player
						env->addFileOpenDialog(L"Please select a mesh file for a player",true,0,id);
						break;
					case 202: //Add -> Mesh -> Enemy
						env->addFileOpenDialog(L"Please select a mesh file for an enemy",true,0,id);
						break;
					case 203: //Add -> Mesh -> Weapon
						env->addFileOpenDialog(L"Please select a mesh file a weapon", true,0,id);
						break;
					
					/* Add Texture */
					case 221: //Add -> Texture -> Player
						//TODO: Show the player properties to add textures
						break;
					case 230: //Add -> Texture -> Enemy
						//TODO: Show enemies screen to select a single enemy to see properties
						break;
					case 239: //Add -> Texture -> Crosshair
						env->addFileOpenDialog(L"Please select a texture file for the player's crosshair",true,0,id);
						break;
					case 240: //Add -> Texture -> Bullet
						env->addFileOpenDialog(L"Please select a texture file for a weapon's bullet",true,0,id);
						break;
					case 241: //Add -> Texture -> Portals
						//TODO: Implement Portals Stuff.
						break;

					/*** Edit Menu ***/
					case 300: //Edit -> Meshes
						break;
					case 301: //Edit -> Levels
						break;
					case 302: //Edit -> Textures
						break;
					case 303: //Edit -> Controls
						break;
					case 304: //Edit -> Network Options
						break;
					case 305: //Edit -> ToyBoX Options
						break;

					/*** Camera Menu ***/
					case 400: //Camera -> Maya Style
						//player->SetActiveCamera(MAYA_CAMERA);
						break;
					case 401: //Camera -> First Person
						//player->SetActiveCamera(FPS_CAMERA);
						break;
					case 402: //Camera -> Third Person
						//player->SetActiveCamera(THIRD_CAMERA);
						break;
					case 403: //Camera -> Bird's Eye
						break;

				}//end switch
			break;
			}

		case EGET_FILE_SELECTED:
			{
				IGUIFileOpenDialog* dialog = (IGUIFileOpenDialog*)event.GUIEvent.Caller;
				switch(dialog->getID())
				{
					case 100: //File -> Save Simulation
						//TODO: Implement Simulation Save
						break;
					case 101: //File -> Open Simulation
						//TODO: Implement Loading Simulation
						break;
					case 102: //File -> Change Media Archive
						//env->addFileOpenDialog(L"Please select your game archive/directory");
						break;
					
					case 201: //Add -> Mesh -> Player
						//if(model) model->remove();
						//Load the model file, selected in the file open dialog
						//model = LoadModel(stringc(dialog->getFileName()).c_str());
						//TODO: Load the new model as the player's model
						break;
					case 202: //Add -> Mesh -> Enemy
						//AddEnemyToList(ContentLoader::LoadModel( stringc(dialog->getFileName()).c_str(), device));
						//TODO: Use EnemyManager to add a new enemy to list.
						break;
					case 203: //Add -> Mesh -> Weapon
						//weapon = LoadModel(stringc(dialog->getFileName()).c_str());
						break;		

					case 210: //Add -> Level/Map
						level = ContentLoader::LoadLevel(stringc(dialog->getFileName()).c_str(), device);
						break;
				}//end switch
			}
		}//end switch
	}//end if
	#pragma endregion

	return false;
}//end OnEvent()

void Game::StartEditMode()
{
	//Turn on main menu
	mainMenu->GetMenu()->setVisible(true);
	//Turn on mouse cursor
	//TODO: Implement an edit cursor (similar to Forge)

	device->getCursorControl()->setVisible(true);

	//Turn off player gravity (allow floating)
	player->SetGravity(vector3df(0,0,0));

	//TODO: Turn off player HUD
	player->SetHUDVisibility(false);

	player->GetCamera()->setInputReceiverEnabled(true);
}

void Game::StartSimulationMode()
{
	//Turn off main menu
	mainMenu->GetMenu()->setVisible(false);

	//Turn off mouse cursor
	device->getCursorControl()->setVisible(false);

	//Turn on player gravity
	player->SetGravity(g_Gravity);

	//TODO: Turn on player HUD
	player->SetHUDVisibility(true);

	player->GetCamera()->setInputReceiverEnabled(true);
	
}

void Game::Update(u32 time)
{
	//TODO: Implement game updates with time-based rendering
	
	//TODO: Implement Player Update
	if(player) player->Update();

	//TODO: Implement Enemy Updates
	if(enemyManager) enemyManager->Update(time);
	

}//end Update()

void Game::Run()
{
	//Draw everything
	while(device->run() && driver)
	{
		if (device->isWindowActive())
		{
			driver->beginScene(true, true, SColor(150,50,50,50));
			smgr->drawAll();
			env->drawAll();
			driver->endScene();
			
			//Only if the main menu is visible
			if(mainMenu->GetMenu()->isVisible())
			{
				//Render the main menu's static text with a frame count and triangle count
				core::stringw str(L"FPS: ");
				str.append(stringw(driver->getFPS()));
				str += L" Tris: ";
				str.append(stringw(driver->getPrimitiveCountDrawn()));
				mainMenu->GetFPSText()->setText(str.c_str());
			}

			//Update Game state
			Update(device->getTimer()->getTime());
		}
		else
			device->yield();
	}
}//end Run()


Game::~Game()
{
	//Clean Up
	device->drop();
	
	if(mainMenu) delete mainMenu;
	if(level) delete level;
	if(metaSelector) delete metaSelector;
	if(player) delete player;

	/*
	for(int i=0; i<(int)enemyList.size(); i++)
		if(enemyList[i]) delete enemyList[i];
	enemyList.clear();
	*/
	if(enemyManager) delete enemyManager;
}