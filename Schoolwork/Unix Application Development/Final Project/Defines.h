#ifndef _DEFINES_H
#define _DEFINES_H

#include <curses.h>

//Represents a collection of useful helper functions.
class Defines{
	public:
		//Purpose: Prints the passed message at the bottom of the screen.
		static void printDebug(const char* msg)
		{
		    //Clear first
		    mvaddstr(LINES-1, 0, " 									");
		    //Then write
		    mvaddstr(LINES-1, 0, msg);
		}	

		//Prints the "Game Over" string near the top center
		//winner is the number of the winning player 
		//1 = player1
		//2 = player2
		static void printGameOver(int winner)
		{
			//Allows us to fake a blinking effect
			static int showTimer = 0;

			//Draw every 4 draw calls
			bool timeToShow = showTimer % 4 == 0;

			char msg[15];
			if(winner == 1)
				sprintf(msg, "%s", "Player 1 Wins!");
			else
				sprintf(msg, "%s", "Player 2 Wins!");
							
			//Draw coords
			int px = (COLS/2) - (strlen(msg) / 2);
			int py = 1;

			if(timeToShow){

				//Show it				
				mvaddstr(py, px , " 			");
				mvaddstr(py, px, msg);
			}
			else{
				//Erase it
				mvaddstr(py, px , " 			");
			}
			// Increase the timer
			showTimer++;
		}

		//Prints the passed scores to the left and right top-ends of the screen.
		static void printScores(int s1, int s2)
		{
			//Positions for printing
			int s1x = 6;
			int s1y = 1;
			int s2x = COLS - s1x;
			int s2y = s1y;

			//Positions for labels
			int p1lx = s1x - 3;
			int p2lx = s2x - 3;
			int p1ly = s1y - 1;
			int p2ly = s2y - 1;
			
			//Clear the player labels positions
			mvaddstr(p1ly, p1lx, "               ");
			mvaddstr(p2ly, p2lx, "               ");
			//Print player labels
			mvaddstr(p1ly, p1lx, "PLAYER 1");
			mvaddstr(p2ly, p2lx, "PLAYER 2");

			//Clear the scores positions
			mvaddstr(s1y, s1x, "  ");
			mvaddstr(s2y, s2x, "  ");
			//Print Scores
			char buff[5];
			sprintf(buff, "%i", s1);
			mvaddstr(s1y, s1x, buff);
			sprintf(buff, "%i", s2);
			mvaddstr(s2y, s2x, buff);				
		}

		//Prints a welcome message at the top center
		static void printWelcome()
		{
			char msg[] = "Welcome to Pong!!";
			int py = 0;
			int px = (COLS / 2) - (strlen(msg)/2);
			
			mvaddstr(py, px, "                                            ");
			mvaddstr(py, px, msg);
		}

		//Prints project information at the bottom right
		static void printProjectInfo()
		{
			int px = COLS - 25;
			int py = LINES - 1;

			mvaddstr(py, px, "                    ");
			mvaddstr(py, px, "Joel Kemp, Fall 2011");
			/*
			py = LINES - 2;

			mvaddstr(py, px, "                        ");
			mvaddstr(py, px, "Unix App. Dev. Fall 2011");

			py = LINES - 1;

			mvaddstr(py, px, "             ");
			mvaddstr(py, px, "Final Project");
			*/
		}

		//Prints game instructions on the lower left
		static void printInstructions()
		{
			int px = 1;
			int py = LINES - 4;

			//mvaddstr(py, px, "             ");
			//mvaddstr(py, px, "INSTRUCTIONS:");
			
			//py = LINES - 3;

			//mvaddstr(py, px, "       ");
			//mvaddstr(py, px, "q: quit");

			py = LINES - 2;

			mvaddstr(py, px, "                            ");
			mvaddstr(py, px, "w: up  |  s: down (Player 1)");

			py = LINES - 1;

			mvaddstr(py, px, "                            ");
			mvaddstr(py, px, "i: up  |  k: down (Player 2)");
		}
};

#endif