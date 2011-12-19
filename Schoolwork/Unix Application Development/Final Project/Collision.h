#ifndef _COLLISION_H
#define _COLLISION_H

#include <vector>
using namespace std;
class Collision
{
	public:
		//Determines if the passed coordinates intersect with the right
		//	screen boundary.
		static bool collidesWithRightWall(int x, int y);

		//Determines if the passed coordinates intersect with the left
		//	screen boundary.
		static bool collidesWithLeftWall(int x, int y);

		//Determines if the ball collides with player 1's paddle
		//px and py are the paddle's coordinates
		//bx and by are the ball's coordinates
		static bool collidesWithPaddle(vector<int> pxs, vector<int> pys, int bx, int by, int paddle);
};

#endif