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


// Read registers
#define IORD_TIME_SCHEDULER_IRQ_ENABLE_REG(x) \
		(IORD_32DIRECT(x, TIME_SCHEDULER_IRQ_ENABLE_REG))

#define IORD_TIME_SCHEDULER_IRQ_ACK_REG(base) \
		(IORD_32DIRECT(base, TIME_SCHEDULER_IRQ_ACK_REG))

#define IORD_TIME_SCHEDULER_IRQ_VECTOR_REG(base) \
		(IORD_32DIRECT(base, TIME_SCHEDULER_IRQ_VECTOR_REG))


#define IOWR_TIME_SCHEDULER_IRQ_ENABLE_REG(base, data){ \
        IOWR_32DIRECT(base, \
                TIME_SCHEDULER_IRQ_ENABLE_REG, data);}

#define IOWR_TIME_SCHEDULER_IRQ_ACK_REG(base, data){ \
        IOWR_32DIRECT(base, \
                TIME_SCHEDULER_IRQ_ACK_REG, data);}

#define IOWR_TIME_SCHEDULER_IRQ_VECTOR_REG(base, data){ \
        IOWR_32DIRECT(base, \
                TIME_SCHEDULER_IRQ_VECTOR_REG, data);}



#endif /* INC_TIME_SCHEDULER_REGS_H_ */
