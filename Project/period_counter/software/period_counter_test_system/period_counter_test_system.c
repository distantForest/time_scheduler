#include "sys/alt_stdio.h"
#include "io.h"
#include "system.h"
#include <sys/alt_irq.h>

#define HUGE_DELAY (6 * 1000 * 1000)

#define TIME_SCHEDULER_VECTOR_REG 0x8
#define TIME_SCHEDULER_IRQ_CLEAR { \
	IOWR_32DIRECT(TIME_SCHEDULER_0_BASE, \
			TIME_SCHEDULER_VECTOR_REG, 0);}
#define TIME_SCHEDULER_VECTOR_READ ( \
	IORD_32DIRECT(TIME_SCHEDULER_0_BASE, \
	TIME_SCHEDULER_VECTOR_REG))
#define PERIOD_0_INTERRUPT_ACK_REG 0x4
#define PERIOD_0_INTERRUPT_ENABLE_REG 0x0
#define PERIOD_0_IRQ_CLEAR { \
		IOWR_32DIRECT(TIME_SCHEDULER_0_BASE, \
				PERIOD_0_INTERRUPT_ACK_REG, 1);}
#define PERIOD_0_IRQ_ENABLE { \
	    IOWR_32DIRECT(TIME_SCHEDULER_0_BASE, \
	    		PERIOD_0_INTERRUPT_ENABLE_REG, 1);}

#define PERIOD_2_INTERRUPT_ACK_REG 0x4
#define PERIOD_2_INTERRUPT_ENABLE_REG 0x4
#define PERIOD_2_IRQ_CLEAR { \
		IOWR_32DIRECT(TIME_SCHEDULER_0_BASE, \
				PERIOD_0_INTERRUPT_ACK_REG, 4);}
#define PERIOD_2_IRQ_ENABLE { \
	    IOWR_32DIRECT(TIME_SCHEDULER_0_BASE, \
	    		PERIOD_0_INTERRUPT_ENABLE_REG, 5);} //enable periods 2 and 0

#define PERIOD_X_IRQ_CLEAR(x) { \
		IOWR_32DIRECT(TIME_SCHEDULER_0_BASE, \
				PERIOD_0_INTERRUPT_ACK_REG, x);}

#define PERIOD_READ_IRQ_ENABLE_REG ( \
	IORD_32DIRECT(TIME_SCHEDULER_0_BASE, \
			PERIOD_0_INTERRUPT_ENABLE_REG))

//period functions
void p_function0(void){
	alt_printf("++function 0 %x ++\n",PERIOD_READ_IRQ_ENABLE_REG);
}

void p_function2(void){
	alt_printf("**function 2 %x **\n",PERIOD_READ_IRQ_ENABLE_REG);
}

void (*period_functions[5])(void) = {p_function0,0,p_function2,0,0};

void alt_isr_period_0 (void* isr_context){
	unsigned vector = TIME_SCHEDULER_VECTOR_READ;

	TIME_SCHEDULER_IRQ_CLEAR;
	*(unsigned*)isr_context = (*(unsigned*)isr_context + 1) & 0xf;
//	alt_printf("Period %x done %x\n", vector, *(unsigned*)isr_context);

	// call period function by vector
	period_functions[vector]();
	PERIOD_X_IRQ_CLEAR(1 << vector);
}

unsigned period_0_data = 0;
int main()
{
  alt_putstr("Hello from Nios II! multichannel\n");
  if (alt_ic_isr_register(
		  TIME_SCHEDULER_0_IRQ_INTERRUPT_CONTROLLER_ID,
		  TIME_SCHEDULER_0_IRQ,
		  alt_isr_period_0,
		  &period_0_data,
		  0x0
		  )){
	  alt_printf("Error ISR register period 0");
  }

  PERIOD_2_IRQ_ENABLE;
  /* Event loop never exits. */
  while (1){
	  static int j = 0;
//	  delay and print background loop message
	  for (int i = HUGE_DELAY; i > 0; i --){
		  int j = i;
	  }
	  alt_printf("-- background -- %x\n", j++ & 0xff);
  }

  return 0;
}
