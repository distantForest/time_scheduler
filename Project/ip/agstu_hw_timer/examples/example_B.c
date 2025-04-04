/*
 * hello_world.c Igor Parchakov
------------------------------------------------------------------
 * Company: TEIS AB
 * Engineer: Igor Parchakov
 *
 * Created on: Nov 19, 2022
 * Design Name: C_Task_4
 * Target Devices: DE10-Lite
 * Tool versions: Quartus v18 and Eclipse Mars.2 Release (4.5.2)
 *
 *  Description:
 *  This file is an example of using TIMER_HW driver
 *
------------------------------------------------------------------
*/

#include <stdio.h>
#include <io.h>
#include <altera_avalon_timer_regs.h> // Timer driver HAL

/*
 * Example function counts seconds and minutes
 */
int main()
{
  int seconds = 0;
    int minutes = 0; // Locally stored counters

  TIMER_RESET;
  TIMER_START;
  while (1)
  {
    //timer counting to 1 sec
    while (TIMER_READ < (50 * 1000000));
    TIMER_RESET;
    TIMER_START;
    if (++seconds < 60)
    {
      printf("second = %d\n",seconds);
    }
    else
    {
      minutes++;
      seconds = 0;
      printf("minutes = %d\n",minutes);
    }
  }
  return 0;
}
