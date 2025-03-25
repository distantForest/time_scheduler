/*
 * time_scheduler.h
 *
 *  Created on: 25 Feb 2025
 *      Author: Igor Parchakov
 */

#ifndef INC_TIME_SCHEDULER_H_
#define INC_TIME_SCHEDULER_H_

//#include "io.h"


#define TIME_SCHEDULER_VECTOR_READ(x) ( \
    IORD_32DIRECT(x, \
    TIME_SCHEDULER_IRQ_VECTOR_REG))
#define TIME_SCHEDULER_TIMER_RUN(X) {  \
        IOWR_32DIRECT(X,TIME_SCHEDULER_CS_REG,(0x1));}


typedef void (*period_function_ptr)(void);

// time scheduler instance declarations
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


#endif /* INC_TIME_SCHEDULER_H_ */
