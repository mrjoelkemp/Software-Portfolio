#ifndef _PADDLE_H
#define _PADDLE_H

#include "Sprite.h"
#include <vector>

#include "Defines.h"
using namespace std;

const int NUM_BARS = 5;

class Paddle : public Sprite
{
	public:
		Paddle();
		Paddle(double x, double y);

		void draw();
		void erase();
		void update();
		
		//Handles pre-movement and movement processes
		void moveUp();
		void moveDown();

		void increaseScore(int a = 1);
		int getScore();

		//Since a paddle has multiple components, collision
		//	can occur on any component. These functions return
		//	collections of the rows and columns occupied by the paddle.
		vector<int> getCols();
		vector<int> getRows();
		
	private:		
		vector<char> shapes;
		vector<int> rows;
		vector<int> cols;

		int score;
		//The number of chars to jump per upward or downward move
		int moveOffset;
};
#endif