/*
 * time_scheduler.h
 *
 *  Created on: 25 Feb 2025
 *      Author: Igor Parchakov
 */

#ifndef INC_TIME_SCHEDULER_H_
#define INC_TIME_SCHEDULER_H_

//#include "io.h"
#include "sys/alt_stdio.h"

#define TIME_SCHEDULER_VECTOR_READ(x) ( \
    IORD_32DIRECT(x, \
    TIME_SCHEDULER_IRQ_VECTOR_REG))
#define TIME_SCHEDULER_TIMER_RUN(X) {  \
        IOWR_32DIRECT(X,TIME_SCHEDULER_CS_REG,(0x1));}


typedef void (*period_function_ptr)(void);
typedef period_function_ptr function_array_t[];


// time scheduler instance declarations
typedef struct  {
    unsigned base;
    unsigned irq;
    unsigned irq_id;
  period_function_ptr (*period_functions)[];
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

/* #define TIME_SCHEDULER_INIT(name1, name2) \ */
/*   { \ */
/*     const char a[] = " this is n_a_m_e_1 name1##,"; \ */
/*     const char b[] = " this is n-a-m-e-2 name2##."; \ */
/*    }; */

#define TIME_SCHEDULER_INSTANCE(name, class) \
    struct name##_context {             \
        unsigned base;               \
        unsigned irq;               \
        unsigned irq_id;            \
        period_function_ptr (*functions)[name##_HEIGHT];};	\
    __attribute__((weak)) period_function_ptr name##_functions[name##_HEIGHT] = {NULL}; \
    struct name##_context name##_i = {  \
                                        .base = name##_BASE, \
                                        .irq = name##_IRQ,  \
                                        .irq_id = name##_IRQ_INTERRUPT_CONTROLLER_ID, \
                                        .functions = name##_functions};

#define TIME_SCHEDULER_FUNCTIONS(name, ...)					\
  period_function_ptr name##_functions[name##_HEIGHT] = {__VA_ARGS__};

#define TIME_SCHEDULER_INIT(name, class) \
  {					 \
  if (alt_ic_isr_register(		 \
					 name##_i.irq_id,	\
					 name##_i.irq,	\
					 alt_isr_period_0,	\
					 &name##_i,		\
					 0x0			\
					 )){			      \
    alt_printf("Error ISR register scheduler_%x",name##_i.irq);     \
  }								      \
  else{									\
    alt_printf("Register success, irq_id %x, irq %x, base %x\n",	\
	       name##_i.irq_id, name##_i.irq, name##_i.base);	\
  }};

void time_scheduler_init(general_context* scheduler);
void alt_isr_period_0 (void* isr_context);

#endif /* INC_TIME_SCHEDULER_H_ */
