#ifndef  _SPRITE_H
#define  _SPRITE_H

#include    <ncurses.h>

class Sprite
{
	public:
		//Constructors
		Sprite();
		Sprite(double x, double y, int interval, double dirx, double diry);
		
		//Mutators
		void setPosition(double x, double y);
		void setPositionX(double x);
		void setPositionY(double y);
		void setDirection(double x, double y);
		void setInterval(int i);
				
		//Accessors
		double getPositionX();
		double getPositionY();
		int getRow();
		int getCol();
		void getShape(char s);
		
		void moveX(double amount);
		void moveY(double amount);

		virtual void draw();
		virtual void update();
		virtual void erase();
		
	protected:
		//Display Positions
	   	int     row; 
   		int     col;
   		//Real Positions
   		double  y;
   		double  x;
   		
   		//Update interval
   		int interval;
   		//Elapsed tick counter
   		int counter;
   		
   		//Directional Information
   		double dx;
   		double dy;
   		
};

#endif
