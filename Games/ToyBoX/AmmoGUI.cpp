#include "AmmoGUI.h"

AmmoGUI::AmmoGUI(IrrlichtDevice *device) : GameEntity(device)
{
	previousAmmoCount = 0;
	dimension2d<s32> screenSize = driver->getScreenSize();

	//Create a 200x200 rectangle at the bottom left of the screen
	//rect<s32> ammoRect(20, screenSize.Height - 150, 100, screenSize.Height - 80);

	//Add the ammo stuff to upper right screen corner
	rect<s32> ammoRect(screenSize.Width - 150, 0, screenSize.Width, 50);
	//Add panel to GUI environment
	ammoTab = env->addTab(ammoRect);

	//TODO: Delete this -- debug.
	ammoTab->setBackgroundColor(SColor(100,100,100,100));
	ammoTab->setDrawBackground(true);

	//Add the text at panel location
	ammoText = env->addStaticText(L"0", ammoRect, true);
	//Establish parent relationship
	ammoTab->addChild(ammoText);
}
	
void AmmoGUI::IncreaseAmmo()
{
	//TODO: Fix ammo string increase
	//ammoText->setText(((ammoText->getText() - '0') + 1) + '0');
}//end IncreaseAmmo()

void AmmoGUI::DecreaseAmmo()
{
	//TODO: Fix ammo string decrease

}//end DecreaseAmmo()

void AmmoGUI::Update(s32 ammoCount)
{
	//TODO: Figure out the cast between s32 and wchar_t
//	wchar_t text(ammoCount);
	/*
	For a string based ammo counter, 
	we do not need to use the IncreaseAmmo
	and DecreaseAmmo methods. We simply need
	to modify the static text.
	*/
//	ammoText->setText(L"0" + ammoCount);

}//end Update()

void AmmoGUI::SetVisible(bool value)
{
	ammoTab->setVisible(value);
}

AmmoGUI::~AmmoGUI()
{
	printf("AmmoGUI Deleted \n");
}
