/**
\author Joel Kemp
\date 2007-2008
*/
#include "MainGui.h"
#include "WaveController.h"
#pragma comment(lib, "Irrlicht.lib")

int main()
{
	MainGui* mainGui = new MainGui();
	WaveController* waveController;

	//MainGUI Render returns true when the user clicks New Game
	if(mainGui->Render())
	{
		if(mainGui)
			delete mainGui;

		//Create the game's wave controller
		waveController = new WaveController();
		
		//Clean up
		if(waveController)
			delete waveController;	
	}
	return 0;
}