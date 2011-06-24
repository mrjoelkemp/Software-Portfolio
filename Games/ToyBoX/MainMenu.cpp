//Joel Kemp
//ToyBoX
//Copyright 2008
#pragma once
#include "GameEntity.h"
//#include "ToolBar.cpp"

/* Represents the main (topmost) menu system. */
class MainMenu : public GameEntity
{

private:
	IGUIContextMenu *menu;
	IGUIStaticText* fpstext;
//	ToolBar *toolbar;

public:
	MainMenu(IrrlichtDevice *device) : GameEntity(device)
	{
		//Main menu (parent)
		menu = env->addMenu(0, 1);						//ID: 1
		menu->addItem(L"File", -1, true, true);			//ID: 100 -> 199
		menu->addItem(L"Add", -1, true, true);			//ID: 200 -> 299
		menu->addItem(L"Edit", -1, true, true);			//ID: 300 -> 399
		menu->addItem(L"Camera", -1, true, true);		//ID: 400 -> 499
		menu->addItem(L"Help", -1, true, true);			//ID: 500 -> 599

		//File Menu
		IGUIContextMenu* submenu;
		submenu = menu->getSubMenu(0);
		submenu->addItem(L"Save Simulation", 100);
		submenu->addItem(L"Open Simulation", 101);
		submenu->addItem(L"Change Media Archive", 102);
		submenu->addSeparator();
		submenu->addItem(L"Quit", 103);
		
		//Add Menu							 
		submenu = menu->getSubMenu(1);
		submenu->addItem(L"Mesh", 200, true, true);
		submenu->addItem(L"Texture", 220, true, true);
		submenu->addItem(L"Level/Map", 210);
		//Add Mesh Submenu		ID: 201 -> 209
		submenu = submenu->getSubMenu(0);
		submenu->addItem(L"Player", 201);
		submenu->addItem(L"Enemy", 202);
		submenu->addItem(L"Weapon", 203);
		//Add Texture Submenu	ID: 221 -> 239
		submenu = menu->getSubMenu(1)->getSubMenu(1);
		submenu->addItem(L"Player", 221, true, true);
		submenu->addItem(L"Enemy", 230, true, true);
		submenu->addItem(L"Crosshair", 239);
		submenu->addItem(L"Bullet", 240);
		submenu->addItem(L"Portals", 241);

		//Edit Menu		
		//Note: Each option will open its own separate window (no submenus)
		submenu = menu->getSubMenu(2);
		submenu->addItem(L"Meshes", 300);
		submenu->addItem(L"Levels", 301);
		submenu->addItem(L"Textures", 302);
		submenu->addItem(L"Controls", 303);
		submenu->addItem(L"Network Options", 304);
		submenu->addSeparator();
		submenu->addItem(L"ToyBoX Options", 305);
		
		//Camera Menu
		submenu = menu->getSubMenu(3);
		submenu->addItem(L"Maya Style", 400);
		submenu->addItem(L"First Person", 401);
		submenu->addItem(L"Third Person", 402);
		submenu->addItem(L"Bird's Eye", 403);

		//Help Menu
		submenu = menu->getSubMenu(4);
		submenu->addItem(L"Contents", 500);
		submenu->addItem(L"About", 501);

		//Create frames per second text
		fpstext = env->addStaticText(L"", rect<s32>(400,4,700,23), false, false, menu, -1, true);
	
		//Initially hidden -- starts in simulation
		menu->setVisible(false);

	}

	/* Return a pointer to the main context menu. */
	IGUIContextMenu *GetMenu() { return menu; }
	/* Return a pointer to the main menu's frames text. */
	IGUIStaticText* GetFPSText() { return fpstext; }

	~MainMenu()
	{
		printf("Main Menu Deleted \n");
	}
};