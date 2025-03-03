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




void alt_isr_period_0 (void* isr_context){
    general_context *base = (general_context*)isr_context;
	unsigned vector = IORD_TIME_SCHEDULER_IRQ_VECTOR_REG(base->base);

	alt_printf("..irq vector %x",vector);
	IOWR_TIME_SCHEDULER_IRQ_VECTOR_REG(base->base, 0x0);
	//*(unsigned*)isr_context = (*(unsigned*)isr_context + 1) & 0xf;

	// call period function by vector
	base->period_functions[vector]();
	IOWR_TIME_SCHEDULER_IRQ_ACK_REG(base->base, 1 << vector);
}

void time_scheduler_init(general_context* scheduler){
//    TIME_SCHEDULER_CONTEXT(TIME_SCHEDULER_0, 0,0,0);
    // Register ISR
    if (alt_ic_isr_register(
            scheduler->irq_id,
            scheduler->irq,
            alt_isr_period_0,
            scheduler,
            0x0
            )){
        alt_printf("Error ISR register scheduler_%x",scheduler->irq);
    }
    else{
        alt_printf("Register success, irq_id %x, irq %x, base %x\n",scheduler->irq_id, scheduler->irq, scheduler->base);
    }
}
