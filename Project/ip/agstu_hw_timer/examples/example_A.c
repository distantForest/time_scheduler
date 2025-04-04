/*
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
 *  This file is an example of using TIMER_HW driver. The example
 *  program measures duration of the for-loop and the max possible
 *  reading of the timer.
 *
------------------------------------------------------------------
 *
 */

#include <stdio.h>
#include <io.h>
#include <altera_avalon_timer_regs.h> // Timer driver HAL


int main()
{

    TIMER_RESET;
    TIMER_START;
    while (1)
    {
        alt_u32 max = 0, m = 1, step, measurement;
        TIMER_RESET;
        TIMER_START;
        //the timer overflows when m < max
        for (; m > max; m = TIMER_READ)
        {
            max = m;
        }
        step = m - max;                       //duration of the last round of
        measurement = max + step - m - 1;     //the last number before zero
        printf("max = %lu, m = %lu\n", max,m);
        printf("loop step %lu\n",step);
        printf("THE = %lu\n",measurement);
        printf("Compare with %lu\n",(alt_u32)(0 - 1));
        max = 0;
    }
    return 0;
}
