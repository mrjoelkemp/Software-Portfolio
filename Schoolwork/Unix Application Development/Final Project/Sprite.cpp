#include    <curses.h>
#include    <cmath>
#include    "Sprite.h"

/////////////////////////////////////////////////////////////
//						Constructors
/////////////////////////////////////////////////////////////
Sprite::Sprite() : x(0), y(0), row(0), col(0)
{}

Sprite::Sprite(double x, double y, int interval, double dirx, double diry) 
	: x(x), y(y), interval(interval)
{
	row = y;
	col = x;
	counter = interval;
}

/////////////////////////////////////////////////////////////
//						Mutators
/////////////////////////////////////////////////////////////
void Sprite::setPosition(double x, double y)
{
	this->x = x;
	col = (int)x;
	this->y = y;
	row = (int)y;
}

void Sprite::setInterval(int i)
{
	interval = i;
	counter = i;	
}

void Sprite::setPositionX(double x)
{
	this->x = x;
	col = (int)(x);
}

void Sprite::setDirection(double x, double y)
{
	double ds = sqrt(y*y + x*x);
	
	dy = y / ds;
    dx = x / ds;
}
		
void Sprite::setPositionY(double y)
{
	this->y = y;
	row = (int)y;
}

/////////////////////////////////////////////////////////////
//						Accessors
/////////////////////////////////////////////////////////////
double Sprite::getPositionX()
{ return x; }

double Sprite::getPositionY()
{ return y; }

int Sprite::getRow()
{ return row; }

int Sprite::getCol()
{ return col; }

/////////////////////////////////////////////////////////////
//						Other Members
/////////////////////////////////////////////////////////////
void Sprite::moveX(double amount)
{
	x += amount;
	col = (int) (x);
}

void Sprite::moveY(double amount)
{
	y += amount;
	row = (int) (y);
}

/////////////////////////////////////////////////////////////
//						Virtual Functions
/////////////////////////////////////////////////////////////
void Sprite::draw()
{}

void Sprite::erase()
{}

void Sprite::update()
{}