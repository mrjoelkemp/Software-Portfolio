//Joel Kemp
//ToyBoX
//Copyright 2008
#include <iostream>
#include "Game.h"

#pragma comment(lib, "Irrlicht.lib")

int main()
{
	Game *toyBox = new Game();
	
	if(toyBox)
	{
		//Initialize Device stuff
		toyBox->Initialize();
		//Enter the game loop
		toyBox->Run();

		//Clean Up
		delete toyBox;
	}
	return 0;
}

