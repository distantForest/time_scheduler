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
#include "agstu_time_scheduler_regs.h"
#include "agstu_time_scheduler.h"

__attribute__((weak)) int weak_int = 0;

void alt_isr_period_0 (void* isr_context){
  static unsigned depth = 0;
  general_context *base = (general_context*)isr_context;
  unsigned vector = IORD_TIME_SCHEDULER_IRQ_VECTOR_REG(base->base);
  alt_u32 irq_enabled;

  depth += 1;
  IOWR_TIME_SCHEDULER_IRQ_VECTOR_REG(base->base, 0x0);
//  __asm__ volatile ("rdctl %0, ienable" : "=r" (irq_enabled));
//  __asm__ volatile ("wrctl ienable, %0" : : "r" (irq_enabled | (1 << base->irq)) : "memory");
//  __asm__ volatile ("wrctl status, %0" : : "r" (1 << 0) : "memory");

  alt_printf("..irq vector %x, depth %x",vector, depth);

  // call period function by vector
  base->period_functions[vector]();

//  __asm__ volatile ("wrctl status, %0" : : "r" (0) : "memory");
//  __asm__ volatile ("wrctl ienable, %0" : : "r" (irq_enabled) : "memory");
  IOWR_TIME_SCHEDULER_IRQ_ACK_REG(base->base, 1 << vector);
  depth -= 1;
}

void time_scheduler_init(general_context* scheduler){
//    TIME_SCHEDULER_CONTEXT(TIME_SCHEDULER_0, 0,0,0);
    // Register ISR
static int f = 1;
    f++;
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
        alt_printf("~~~~weak %x", weak_int);
}
