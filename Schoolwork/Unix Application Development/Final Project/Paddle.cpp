#include "Paddle.h"
#include <curses.h>
#include <vector>
using namespace std;


/////////////////////////////////////////////////////////////
//						Constructors
/////////////////////////////////////////////////////////////
Paddle::Paddle()
{}

Paddle::Paddle(double x, double y)
{
	setPosition(x, y);
	setInterval(1);
	setDirection(1,1);

	//Set the shapes
	for (int i = 0; i < NUM_BARS; i++)
		shapes.push_back(178);
	
	//Set the rows and cols of the shapes
	for(int i = 0; i < NUM_BARS; i++){
		rows.push_back( (int)(y + (i - (NUM_BARS/2))) );
		cols.push_back((int)(x));
	}
		
	score = 0;
	moveOffset = 2;
}

/////////////////////////////////////////////////////////////
//						Virtual Overrides
/////////////////////////////////////////////////////////////
void Paddle::draw()
{
	//Draw a vertical column of lines
	for(int i = 0; i < NUM_BARS; i++)
		mvaddch(rows.at(i), cols.at(i), shapes.at(i));	
}

void Paddle::erase()
{
	//Draw a vertical column of lines
	for(int i = 0; i < NUM_BARS; i++)
		mvaddch(rows.at(i), cols.at(i), ' ');
}

void Paddle::update()
{
	if(--counter == 0){
		//Remove the previously drawn sprite
		erase();
		//Draw the sprite at its new location
		draw();
		//Reset the counter
		counter = interval;
	}
}

/////////////////////////////////////////////////////////////
//						Other Member Functions
/////////////////////////////////////////////////////////////
void Paddle::moveUp()
{
	//Erase before modifying the position otherwise, we have artifacts
	erase();

	int topPad = rows.at(0);
	bool exceedsTop = (topPad - moveOffset) < 0;
	 
	if(!exceedsTop)
		//Move all of the rows up
		for (int i = 0; i < NUM_BARS; i++)
			rows[i] = rows.at(i) - moveOffset;
}

void Paddle::moveDown()
{
	erase();

	int bottomPad = rows.at(NUM_BARS - 1);
	bool exceedsBottom = (bottomPad + moveOffset) >= LINES;

	if(!exceedsBottom)
		//Move all of the rows up
		for (int i = 0; i < NUM_BARS; i++)
			rows[i] = rows.at(i) + moveOffset;
}

void Paddle::increaseScore(int a)
{
	score += a;
}

int Paddle::getScore()
{
	return score;	
}

vector<int> Paddle::getCols()
{
	return cols;
}
	
vector<int> Paddle::getRows()
{
	return rows;
}