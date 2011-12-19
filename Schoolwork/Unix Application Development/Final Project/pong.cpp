/*
Author: 	Joel Kemp
File: 		pong.cpp
Purpose: 	A simple pong clone utilizing signals and the curses library.
Build:      make makefile all
Usage:      ./pong
*/
#include    <stdio.h>
#include 	<stdlib.h>
#include    <ncurses.h>
#include    <signal.h>
#include    "timers.h"
#include 	"Paddle.h"
#include 	"Ball.h"
#include    "Collision.h"
#include    "Defines.h"
#include    <vector>
#include    <string.h>   //for strcat
#include    <cstdlib>   //for itoa
using namespace std;

#define  CENTERY    (LINES/2)        // The middle line in terminal
#define  CENTERX    (COLS/2)         // The middle column in terminal
#define  GO_SCORE   10               // Game over score limit
Paddle *p1, *p2;
Ball *ball;
/////////////////////////////////////////////////////////////
//                      Prototypes
/////////////////////////////////////////////////////////////
//Purpose: Registers the signal handler.
void initHandler();
void initCurses();

//Purpose: Starts the real time interval timer with delay interval size
void setRefreshTimer(int delay);

//Purpose: Contains game update logic for each alarm-triggered game refresh.
void update_all(int signum);

//Purpose: Handles various forms of gameplay object collision
void checkCollision();
//Purpose: Continuously loops for and handles input
void loopForInput();
//Purpose: Steps to be executed for a game over scenario
void handleGameOver(int winner);

/////////////////////////////////////////////////////////////
//                      Main Function
/////////////////////////////////////////////////////////////
int main(int argc, char* argv[])
{  
	initHandler();
    initCurses();

	//Init Sprites      
   	p1 = new Paddle(2, CENTERY);
   	p2 = new Paddle(COLS-3, CENTERY);   	
   	ball = new Ball(CENTERX, CENTERY);
    
    setRefreshTimer(20);
    loopForInput();

    endwin();
    delete p1;
    delete p2;
    delete ball;

    return 0;
}

/////////////////////////////////////////////////////////////
//                      Init Functions
/////////////////////////////////////////////////////////////
void setRefreshTimer(int delay)
{
    set_timer(ITIMER_REAL, 1000/delay, 1000/delay);
}

void initCurses()
{
    // prepare the terminal for the animation
    initscr();     // initialize the library and screen
    cbreak();      // put terminal into non-blocking input mode
    noecho();      // turn off echo
    clear();       // clear the screen
    curs_set(0);   // supposed to hide the cursor
    keypad(stdscr, TRUE);
}

void initHandler()
{
    struct sigaction newhandler;      // for installing handlers      
    sigset_t         blocked;         // to set mask for handler

    newhandler.sa_handler = update_all; // name of handler 
    newhandler.sa_flags = SA_RESTART; // flag is just RESTART
    sigemptyset(&blocked);            // clear all bits of blocked set
    newhandler.sa_mask = blocked;     // set this empty set to be the mask

    if ( sigaction(SIGALRM, &newhandler, NULL) == -1 ){  // try to install
        perror("sigaction");
        exit(1);
    }
}

/////////////////////////////////////////////////////////////
//                      Helper Functions
/////////////////////////////////////////////////////////////
void update_all(int signum)
{	
    //We have to reprint the welcome because it could get occluded by the ball
    Defines::printWelcome();  
    Defines::printScores(p1->getScore(), p2->getScore());
    Defines::printInstructions();
    Defines::printProjectInfo();

    //Check for game over
    bool p1wins = p1->getScore() >= GO_SCORE;
    bool p2wins = p2->getScore() >= GO_SCORE;
    if(p1wins)
        handleGameOver(1);
    else if(p2wins)
        handleGameOver(2);
    
    //We only want to update the sprites if it's not game over
    //Pausing the updates on game over simulates a game pause.
    bool shouldUpdate = !p1wins && !p2wins;

    if(shouldUpdate){
        //Update the animation timers and trigger drawing if appropriate
        p1->update();
        p2->update();
        ball->update();
        
        //Check for collision between balls, paddles, and screen bounds
        checkCollision();    
    }    
    
    move(LINES-1, COLS-1);
    refresh();
}

void handleGameOver(int winner)
{
    Defines::printGameOver(winner);

    //Increase the update delay on the objects to simulate a pause
    //Note: if we modified the refresh timer, the blinking 
    //  "game over" wouldn't blink
    //p1->setInterval(1000);
    //p2->setInterval(1000);
    //ball->setInterval(1000);
}

void checkCollision()
{
    int by = ball->getPositionY();
    int bx = ball->getPositionX();

    //Ball with walls
    if(Collision::collidesWithRightWall(bx, by)){
        //Player 1 gets the point
        p1->increaseScore();
        ball->flipHorizontalDirection();
        ball->resetPosition(CENTERX, CENTERY);
    }
    else if(Collision::collidesWithLeftWall(bx, by)){
        //Player 2 gets the point
        p2->increaseScore();
        ball->flipHorizontalDirection();
        ball->resetPosition(CENTERX, CENTERY);
    }
    
    //Ball with Paddles
    vector<int> pxs = p1->getCols();
    vector<int> pys = p1->getRows();
    vector<int> p2xs = p2->getCols();
    vector<int> p2ys = p2->getRows();
    bool hitPaddle1 = Collision::collidesWithPaddle(pxs, pys, bx, by, 1);
    bool hitPaddle2 = Collision::collidesWithPaddle(p2xs, p2ys, bx, by, 2);
    if( hitPaddle1 || hitPaddle2) {
        ball->flipHorizontalDirection();
        ball->increaseSpeed();
    }
}

void loopForInput()
{
    bool done = false;
    while(!done) {    
        int c = getch();
        switch (c) {
        case 'Q':
        case 'q': 
        case KEY_F(1):
            done = true;
            break;       
        case 'W':   //P1 UP Controls
        case 'w':
            p1->moveUp();
            break;
        case 'S':   //P1 DOWN controls
        case 's':
            p1->moveDown();
            break;
        case 'I':   //P2 UP controls
        case 'i':
            p2->moveUp();
            break;
        case 'K':   //P2 down controls
        case 'k':
            p2->moveDown();
            break;
        }
    }
}