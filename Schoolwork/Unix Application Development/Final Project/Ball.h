#ifndef _BALL_H
#define _BALL_H

#include "Sprite.h"

//In case we want to tweak what's drawn for the ball.
const int NUM_SHAPES = 1;

class Ball : public Sprite
{
	public:
		Ball();
		Ball(double x, double y);
		void increaseSpeed(int a = 1);
		void decreaseSpeed(int a = 1);

		//Modifies the direction of travel 
		void changeDirection(double dirx, double diry);
		
		//Modifies the direction of travel
		void flipHorizontalDirection();
		void flipVerticalDirection();

		// Resets the ball's position (both real and display)
		// to the passed coordinates.
		// Should be the center of the screen
		void resetPosition(int x, int y);

		void updatePosition();

		void draw();
		void erase();
		void update();

	private:
		char shapes[NUM_SHAPES];
};

#endif