using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Diagnostics;

namespace Gesture
{
  /* Implement timing specific functions. This is useful both because 
   * it removes the garbage created by DateTime.Now, and because it 
   * allows me to tune the clock speed to sync with another server if 
   * necessary.
   */
  public class Timing
  {
    static Stopwatch timer;
    static long baseTicks;
    static double tickScale;

    /* Initialize the timer to "Now" based on the global system clock
     */
    public static void Init()
    {
      baseTicks = DateTime.Now.Ticks;
      timer = Stopwatch.StartNew();
      tickScale = 10000000.0 / Stopwatch.Frequency;
    }

    /* Read the current tick count, as estimated through global clock plus elapsed time.
     * There are 10,000,000 ticks per second.
     */
    public static long NowTicks
    {
      get
      {
        return baseTicks + (long)(timer.ElapsedTicks * tickScale);
      }
    }

    /* Adjust the rate by which time advances. "mul" generally should be in the 
     * range 0.99999 through 1.00001, because even very small adjustments add up 
     * over time.
     */
    public static void AdjustRate(double mul)
    {
      tickScale *= mul;
    }

    /* Skip time ahead or back by some number of ticks. There are 10,000,000 ticks 
     * per second.
     */
    public static void JumpTime(long ticks)
    {
      baseTicks += ticks;
    }
  }
}
