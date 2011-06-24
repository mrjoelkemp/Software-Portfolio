#include "HealthGUI.h"

HealthGUI::HealthGUI(IrrlichtDevice *device) : GameEntity(device)
{
	//Create the array of healthbars
	healthbars = new HealthBar*[MAX_HEALTH_BARS];

	dimension2d<s32> screenDim = driver->getScreenSize();

	//Rectangle at the upper middle of screen
	rect<s32> tabRect(screenDim.Width/2 - 110, 25, screenDim.Width/2 + 75, 50);
	//Create a tab that will house the healthbars
	healthTab = env->addTab(tabRect);
	
	//Populate the array
	for(s32 i=0; i < MAX_HEALTH_BARS; i++)
	{	
		//Allocate space
		healthbars[i] = new HealthBar(device);
		//Set the healthbar as active
		healthbars[i]->SetActive(true);
		//Set the position for the healthbar		
		position2d<s32> pos = position2d<s32>( tabRect.UpperLeftCorner.X + (i*20 + healthbars[i]->GetTexture()->getSize().Width), 
			tabRect.UpperLeftCorner.Y);
		
		//Add healthbar to the panel of healthbars
		healthTab->addChild(env->addImage(healthbars[i]->GetTexture(), pos));
	}
}
	
void HealthGUI::IncreaseHealth()
{
	for(int i=0; i<MAX_HEALTH_BARS; i++)
		if(healthbars[i]->GetActive() == false)
		{
			healthbars[i]->SetActive(true);
			break;
		}
}//end IncreaseHealth()

void HealthGUI::DecreaseHealth()
{
	for(int i=MAX_HEALTH_BARS; i > 0; i--)
		if(healthbars[i]->GetActive())
		{
			//Set the rightmost active bullet to inactive			
			healthbars[i]->SetActive(false);
			break;
		}

}//end DecreaseHealth()

void HealthGUI::Update(s32 healthAmount)
{
	s32 remainder = healthAmount % 10;

	//Update the health interface system based on healthAmount
	if(remainder != 0)
	{	//If the new health amount is less than the previous value
		if(remainder < previousRemainder)
			DecreaseHealth();
		else if(remainder > previousRemainder)
			IncreaseHealth();
	}

}//end Update()

void HealthGUI::SetVisible(bool value)
{
	healthTab->setVisible(value);
}//end SetVisible()



HealthGUI::~HealthGUI()
{
	if(healthbars)
		delete [] healthbars;

	printf("HealthGUI Deleted\n");
}