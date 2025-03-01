/*
 * time_scheduler.c
 *
 *  Created on: 25 Feb 2025
 *      Author: Igor Parchakov
 */

#include "sys/alt_stdio.h"
#include "io.h"
#include "system.h"
#include <sys/alt_irq.h>
#include "time_scheduler_regs.h"

void (*period_functions[5])(void) = {0,0,0,0,0};

#define TIME_SCHEDULER_CONTEXT(name,  ...) \
    struct name##_context {             \
        int base;               \
        int functions[name##_HEIGHT];};    \
    struct name##_context name##_i = {.base = name##_BASE, .functions = {__VA_ARGS__}};

struct general_context {
    unsigned base;
    period_function_ptr period_functions[];
};

void alt_isr_period_0 (void* isr_context){
    struct general_context *base = (struct general_context*)isr_context;
	unsigned vector = IORD_TIME_SCHEDULER_IRQ_VECTOR_REG(TIME_SCHEDULER_0_BASE);

	IOWR_TIME_SCHEDULER_IRQ_VECTOR_REG(base, 0x0);
	*(unsigned*)isr_context = (*(unsigned*)isr_context + 1) & 0xf;
//	alt_printf("Period %x done %x\n", vector, *(unsigned*)isr_context);

	// call period function by vector
	base->period_functions[vector]();
	IOWR_TIME_SCHEDULER_IRQ_ACK_REG(base->base, 1 << vector);
}

void time_scheduler_init(void){
    TIME_SCHEDULER_CONTEXT(TIME_SCHEDULER_0, 0,0,0);
    //
}
