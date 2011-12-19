/* 
 * timers.h    : Header file for interval timer functions
 * Author      : Stewart Weiss
 * Created     : March 21, 2006
 * Purpose     : Just a utility to demonstrate call to setitimer
 */

#ifndef _TIMERS_H
#define _TIMERS_H

#include        <stdio.h>
#include        <sys/time.h>
#include        <signal.h>

// Initialize an interval timer of type which with initial delay
// of initial msecs and a repeat interval of repeata msecs.
// Return 0 on success, -1 on failure
int set_timer( int which, long initial, long repeat );


#endif
