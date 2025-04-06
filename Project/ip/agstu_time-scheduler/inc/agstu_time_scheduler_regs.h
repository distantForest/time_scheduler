/*
 * time_scheduler_regs.h
 *
 *  Created on: 25 Feb 2025
 *      Author: Igor Parchakov
 */

#ifndef INC_TIME_SCHEDULER_REGS_H_
#define INC_TIME_SCHEDULER_REGS_H_

//#include "io.h"


#define TIME_SCHEDULER_IRQ_ENABLE_REG (0x0)
#define TIME_SCHEDULER_IRQ_ACK_REG (0x4)
#define TIME_SCHEDULER_IRQ_VECTOR_REG (0x8)
#define TIME_SCHEDULER_CS_REG (12)
#define TIME_SCHEDULER_PERIOD_REG (TIME_SCHEDULER_CS_REG + 4)

#define CONCATENATE(A,B) A##B

// Read registers
#define IORD_TIME_SCHEDULER_IRQ_ENABLE_REG(x) \
		(IORD_32DIRECT(x, TIME_SCHEDULER_IRQ_ENABLE_REG))

#define IORD_TIME_SCHEDULER_IRQ_ACK_REG(base) \
		(IORD_32DIRECT(base, TIME_SCHEDULER_IRQ_ACK_REG))

#define IORD_TIME_SCHEDULER_IRQ_VECTOR_REG(base) \
		(IORD_32DIRECT(base, TIME_SCHEDULER_IRQ_VECTOR_REG))


#define IOWR_TIME_SCHEDULER_IRQ_ENABLE_REG(base, data) do { \
        IOWR_32DIRECT(base, \
		      TIME_SCHEDULER_IRQ_ENABLE_REG, data);} while (0)

#define IOWR_TIME_SCHEDULER_IRQ_ACK_REG(base, data) do { \
        IOWR_32DIRECT(base, \
		      TIME_SCHEDULER_IRQ_ACK_REG, data);} while (0)

#define IOWR_TIME_SCHEDULER_IRQ_VECTOR_REG(base, data) do { \
        IOWR_32DIRECT(base, \
		      TIME_SCHEDULER_IRQ_VECTOR_REG, data);} while (0)

#define IOWR_TIME_SCHEDULER_PERIOD_REG(base, period, data) do { \
    IOWR_32DIRECT(base, \
		  (TIME_SCHEDULER_PERIOD_REG + (4 * period)), \
		  data);} while (0)

#endif /* INC_TIME_SCHEDULER_REGS_H_ */
