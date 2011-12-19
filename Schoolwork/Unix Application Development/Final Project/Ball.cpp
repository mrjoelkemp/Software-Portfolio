#include "Ball.h"
#include <curses.h>	//For LINES and COLS
#include <cmath>
#include <cstdlib>
#include <ctime>

Ball::Ball()
{}

Ball::Ball(double x, double y)
{
	srand(time(NULL));	

	//Not using initialization lists to make it clearer
	setPosition(x, y);
	setInterval(3);

	//Random number between 1 and 3
	int rx = rand() % 3 + 1;
	//The direction is a random diagonal
	setDirection(rx,rx);

	shapes[0] = 'O';
}

void Ball::draw()
{
	mvaddch(row, col, shapes[0]);
}

void Ball::erase()
{
	mvaddch(row, col, ' ');
}

void Ball::changeDirection(double dirx, double diry)
{
	double ds = sqrt(diry*diry + dirx*dirx);
	dy = diry / ds;
    dx = dirx / ds;
}

void Ball::flipHorizontalDirection()
{
	dx = -dx;

	//Call updatePosition to move the piece as soon as its
	//	direction is updated. Otherwise, it won't move for an entire
	//	refresh. This screws with collision detection!
	updatePosition();
}

void Ball::flipVerticalDirection()
{
	dy = -dy;

	updatePosition();
}

void Ball::increaseSpeed(int a)
{
	//The update interval controls the rendering speed. 
	//Subtracting from the update interval means the ball updates/draws
	//	in a shorter period of time.
	bool hitsZero = interval - a <= 0;
	if(!hitsZero){
		interval -= a;
		counter = interval;
	}
}

void Ball::decreaseSpeed(int a)
{
	//Adding to the interval delays drawing and 
	//	slows down the ball's movement.
	interval += a;
	counter = interval;
}

void Ball::resetPosition(int x, int y)
{
	erase();
	this->x = x;
	this->y = y;
	row = x;
	row = y;

	//Random number between 1 and 3
	int rx = rand() % 3 + 1;
	dx += rx;
	dy += rx;
	//The direction is a random diagonal
	setDirection(dx,dy);
	setInterval(3);
}

void Ball::updatePosition()
{
	erase();

    y += dy;
    x += dx;
	row = (int)(y);
    col = (int)(x);  
   
   	//Collision with the top and bottom.
    if ((y > LINES-0.5) && (dy > 0))
        flipVerticalDirection();
    else if ((y < 0.0) && (dy < 0))
        flipVerticalDirection();
}

void Ball::update()
{
	//Animation Update trigger
	if(--counter == 0){
		//Remove the previously drawn sprite
		erase();
		updatePosition();
		//Draw the sprite at its new location
		draw();
		//Reset the counter
		counter = interval;
	}

	
}