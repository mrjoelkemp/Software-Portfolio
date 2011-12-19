/******************************************************************************
  Title          : timers.c
  Author         : Stewart Weiss
  Created on     : March 21, 2006
  Description    : Set the value of the specified timer to the number of
                   milliseconds specified for intial and repeat values           
  Modified on    : April 5, 2008
                   Changed logic for computing fields to speed it up
******************************************************************************/


#include        <stdio.h>
#include        <sys/time.h>
#include        <signal.h>

int set_timer( int which, long initial, long repeat )
{
    struct itimerval itimer;
    long secs;

    // initialize initial delay
    secs = initial / 1000 ; 
    itimer.it_value.tv_sec     = secs;    
    itimer.it_value.tv_usec    = (initial - secs*1000 ) * 1000 ;   

    // initialize repeat inveral
    secs = repeat / 1000 ; 
    itimer.it_interval.tv_sec  = secs;     
    itimer.it_interval.tv_usec = (repeat - secs*1000 ) * 1000 ;
    
    return setitimer(which, &itimer, NULL);
}

