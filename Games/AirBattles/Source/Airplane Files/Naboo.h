#pragma once
#include "Airplane.h"

class Naboo : public Airplane
{
public:
	Naboo(vector3df position, vector3df rotation, IrrlichtDevice *device);
	~Naboo(void);
};
