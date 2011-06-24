#pragma once
#include "Airplane.h"

class F14 :	public Airplane
{
public:
	F14(vector3df position, vector3df rotation, IrrlichtDevice *device);
	~F14(void);
};
