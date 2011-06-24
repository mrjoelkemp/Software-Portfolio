#include "PlayerSelectGUI.h"

PlayerSelectGUI::PlayerSelectGUI(IrrlichtDevice *device)
{
	this->device = device;

	//TODO: Add GUI components
	//4 Plane Selection Rectangles
	//	Each has a picture of the airplane -- maybe a 3d render of plane?
	

	//Set the receiver to this.
	device->setEventReceiver(this);
}

bool PlayerSelectGUI::Render()
{
	return true;
}

bool PlayerSelectGUI::OnEvent(const irr::SEvent &event)
{
	//If the event is from the MainGUI and there was input.
	if (event.EventType == EET_GUI_EVENT && 
		event.GUIEvent.Caller->getID() != -1)
	{
		gui::IGUIEnvironment* env = device->getGUIEnvironment();

		//Get the ID of the component that generated the event
		s32 id = event.GUIEvent.Caller->getID();

		switch(event.GUIEvent.EventType)
		{
			case gui::EGET_BUTTON_CLICKED:
				switch(id)
				{
					case 101: //B25
						return true;
					case 102: //F14
						return true;
					case 103: //Naboo
						return true;
					case 104: //Concorde
						return true;
				}
				break;

			default:
				break;
		
		}//end switch
	}//end if

	return false;

}

PlayerSelectGUI::~PlayerSelectGUI()
{

}