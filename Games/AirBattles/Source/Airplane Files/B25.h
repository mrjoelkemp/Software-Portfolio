#pragma once
#include "Airplane.h"

/**
Represents a B25 Jet Airplane.
*/
class B25 : public Airplane
{
public:
	/**
	Constructor for the B25 class that creates
	an airplane at the given position, with the
	defined rotation.
	*/
	B25(vector3df position, vector3df rotation, IrrlichtDevice *device);
	~B25();

private:

};