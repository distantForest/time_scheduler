/*
 ------------------------------------------------------------------
 * Company: TEIS AB
 * Engineer: Igor Parchakov
 *
 * Created on: Nov 20, 2022
 * Design Name: TIMER_HW driver
 * Target Devices: DE10-Lite
 * Tool versions: Quartus v18 and Eclipse Mars.2 Release (4.5.2)
 *
 *
 ------------------------------------------------------------------
 */
/** \file
 * This file defines the  driver for a TIMER_HW component. The component uses a
 * register interface to the data bus. There are defined two 32-bit registers:
 *
 * - Data register. Size - 32 bits. Read-only register shows current time in 20ns units.
 *
 * - Control register. Write-only register uses bits 30,31 as follows:
 *   + 0b00 -> bits30,31 resets the timer;
 *   + 0b01 -> bits30,31 stops the timer;
 *   + 0b10 -> bits30,31 starts the timer.
 *
 * The component does not use hardware interrupts therefore polling the
 * data register is the only way to get information about the timer as well as
 * to read the time measurements.
 */
#ifndef ALTERA_AVALON_TIMER_REGS_H_
#define ALTERA_AVALON_TIMER_REGS_H_

#include <io.h>
#include <system.h>

#define CONCATENATE(A,B) A##B

/** \def TIMER_STOP
 * this macro generates instruction to stop the timer
 *
 */
#define TIMER_STOP(timer) do {IOWR_32DIRECT(CONCATENATE(timer, _BASE),4,0x40000000);} while (0) //!<writing 0x0 to control register stops timer

/** \def TIMER_RESET
 * This macro generates instruction to reset the timer and clears the timer current value
 */
#define TIMER_RESET(timer) do {IOWR_32DIRECT(CONCATENATE(timer, _BASE),4,0x00000000);} while (0) //!<writing 0x40000000 to control register resets timer

/** \def TIMER_START
 * This macro generates instruction to start the timer
 *
 */
#define TIMER_START(timer) do {IOWR_32DIRECT(CONCATENATE(timer, _BASE),4,0x80000000);} while (0) //!<writing 0x80000000 to control register starts timer

/** \def TIMER_READ
 * this macro generates instruction to read the timer current value
 *
 */
#define TIMER_READ(timer) IORD_32DIRECT(CONCATENATE(timer, _BASE),0) //!<reading time measurements

/** \def TIMER_ST_MES
 * this macro generates instruction to start the timer measurement
 *
 */
#define TIMER_ST_MES(timer) \
  do {TIMER_RESET(timer); TIMER_START(timer);} while (0) //!<Start time measurement

#endif /* ALTERA_AVALON_TIMER_REGS_H_ */
