#include "Collision.h"
#include <curses.h>

bool Collision::collidesWithRightWall(int x, int y)
{
	//Right wall is at position col = COLS;
	if(x >= COLS)
		return true;
	
	return false;
}

bool Collision::collidesWithLeftWall(int x, int y)
{
	if(x <= 0)
		return true;

	return false;
}

bool Collision::collidesWithPaddle(vector<int> pxs, vector<int> pys, int bx, int by, int paddle)
{
	bool sameCol = false;
	for (int i = 0; i < pxs.size(); i++){
		if(bx <= pxs.at(i) && paddle == 1){
			sameCol = true;
			break;
		}
		else if(bx >= pxs.at(i) && paddle == 2){
			sameCol = true;
			break;
		}
	}

	if(!sameCol) return false;

	for (int i = 0; i < pys.size(); i++){
		int curPadCompRow = pys.at(i);
		if(by == curPadCompRow)
			return true;
	}
	return false;	
}