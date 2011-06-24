//Joel Kemp
//ToyBoX
//Copyright 2008
#pragma once
#include "GameEntity.h"

/* Represents the simulator's main toolbar; providing useful shortcuts. */
class ToolBar : public GameEntity
{

public:

	ToolBar(IrrlichtDevice *device) : GameEntity(device)
	{
		IGUIToolBar* bar = env->addToolBar();

		ITexture* image = driver->getTexture("open.png");
		bar->addButton(1102, 0, L"Open a model",image, 0, false, true);

		image = driver->getTexture("tools.png");
		bar->addButton(1104, 0, L"Open Toolset",image, 0, false, true);

		image = driver->getTexture("zip.png");
		bar->addButton(1105, 0, L"Set Model Archive",image, 0, false, true);

		image = driver->getTexture("help.png");
		bar->addButton(1103, 0, L"Open Help", image, 0, false, true);
	}

	~ToolBar()
	{
		printf("Toolbar Deleted \n");
	}
};