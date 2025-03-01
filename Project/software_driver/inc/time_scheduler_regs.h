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


#define TIME_SCHEDULER_VECTOR_READ(x) ( \
    IORD_32DIRECT(x, \
    TIME_SCHEDULER_IRQ_VECTOR_REG))

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

typedef void (*period_function_ptr)(void);

typedef struct  {
    unsigned base;
    unsigned irq;
    unsigned irq_id;
    period_function_ptr period_functions[];
} general_context;

#define TIME_SCHEDULER_CONTEXT(name,  ...) \
    struct name##_context {             \
        unsigned base;               \
        unsigned irq;               \
        unsigned irq_id;            \
        period_function_ptr functions[name##_HEIGHT];};    \
    struct name##_context name##_i = {  \
                                        .base = name##_BASE, \
                                        .irq = name##_IRQ,  \
                                        .irq_id = name##_IRQ_INTERRUPT_CONTROLLER_ID, \
                                        .functions = {__VA_ARGS__}};


#endif /* INC_TIME_SCHEDULER_REGS_H_ */
