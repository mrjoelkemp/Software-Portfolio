#pragma once
#include <irrlicht.h>

using namespace irr;
//using namespace gui;
//using namespace video;
using namespace core;

/**
Represents the game's Main interface.
*/
class MainGui : public IEventReceiver
{

public:
	/**
	Constructor for the MainGui class that creates
	the game's main interface.
	*/
	MainGui();
	
	/**
	Renders the interface.
	*/
	bool Render();
	
	~MainGui(void);

	/**
	Captures the user's input.
	*/
	bool OnEvent(const SEvent& event);

private:
	IrrlichtDevice* device;
	gui::IGUIEnvironment *env;
	video::IVideoDriver *driver;
	scene::ISceneManager* smgr;

	bool startGame;		//True if the game should start

	/**
	Sets up the device window.
	*/
	void InitializeDevices();
	void ShowACMScreen();


};