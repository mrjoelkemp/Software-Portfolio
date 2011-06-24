//Joel Kemp
//ToyBoX
//Copyright, 2008
#pragma once
#include "GameEntity.h"

class ToolBox : public GameEntity
{
public:

	ToolBox(IrrlichtDevice* device) : GameEntity(device)
	{
		//IGUIElement* root = env->getRootGUIElement();
		//Grab the pointer to the toolbox element if it exists (ID = 5000); search children as well.
		IGUIElement* e = env->getRootGUIElement()->getElementFromId(5000, true);
		//Remove tool box if already there
		if (e) e->remove();

		//Create the toolbox window (ID = 5000)
		IGUIWindow* wnd = env->addWindow(rect<s32>(600,25,800,480),	false, L"Tool BoX", 0, 5000);

		//Create tab control
		IGUITabControl* tab = env->addTabControl(rect<s32>(2,20,800-602,480-7), wnd, true, true);
		//Add "Scale" Tab
		IGUITab* t1 = tab->addTab(L"Scale");

		//Add some edit boxes 
		env->addEditBox(L"1.0", rect<s32>(40,50,130,70), true, t1, 901);
		env->addEditBox(L"1.0", rect<s32>(40,80,130,100), true, t1, 902);
		env->addEditBox(L"1.0", rect<s32>(40,110,130,130), true, t1, 903);
		//Add a "Set" button to "Scale" tab
		env->addButton(core::rect<s32>(10,150,100,190), t1, 1101, L"set");

		// bring irrlicht engine logo to front, because it
		// now may be below the newly created toolbox
		//root->bringToFront(root->getElementFromId(666, true));
	}

	~ToolBox()
	{
		printf("ToolBox Deleted \n");
	}
};