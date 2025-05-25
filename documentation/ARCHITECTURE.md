# COMPONENT ARCHITECTURE

The **Time Scheduler** component manages the execution of functions according to a predefined time schedule. The component's functionality is shown in [Figure 1](#rec-spec-figure_1).

<div style="float:center" markdown="1">

<a name="rec-spec-figure_1"></a>

|![](./media/functional-diagram.png "Time scheduler functional diagram")|
|---|
|*Figure 1. Time scheduler functional diagram.*|

</div>

The functionality of the component is described as follows:

* The tick function (shown as **T** in the diagram) generates a tick signal derived from the system clock.

* This tick signal is distributed to a set of period counters. Each period counter counts tick pulses up to a specified period limit, which is individually defined for each counter. When a counter reaches its period limit, it asserts its own interrupt request (IRQ), sent to the IRQ selector.

* The **IRQ selector** handles individual period IRQs and multiplexes them over a single shared interrupt line (Avalon® Interrupt Interface) to the Nios II® processor. A simple priority scheme is used while multiplexing the individual IRQs. The IRQ selector uses acknowledge signals and a vector parameter for multiplexing and prioritizing individual IRQs. These signals are transferred via the Avalon® Memory-Mapped Interface.

* The **Interrupt Service Routine (ISR)** reads the vector and acknowledges that the IRQ line is free. It then calls the corresponding period function based on the vector. Upon completion, the ISR acknowledges the completion of the period function execution.
  
  

## Hardware architecture.

The hardware module architecture is shown on [Figure 2](#fig-hw-arc).
<div style="float:center" markdown="1">

<a name="fig-hw-arc"></a>

|![](./media/time-scheduler-HW-architecture.png "Time scheduler hardware architecture diagram")|
|:---:|
|*Figure 2. Time scheduler hardware module architecture.*|

</div>

The hardware module is connected to the Avalon bus and is controlled via a set of registers. The hardware module consists of three blocks. Each block has control/data registers connected to the Avalon Memory-Mapped interface. All the registers are available for the software running on the Nios II processor connected to the Avalon bus. The blocks that constitute the hardware module are:

* **Timer function**. This block generates tick pulses. The tick pulse period is configured in the hardware synthesis phase. The tick function can be started and stopped via a register.
* **Period counter**. This block contains a set of tick pulse counters. The number of counters is defined in the hardware synthesis phase. The period limits can be set individually in the hardware synthesis phase and via registers as well. The period counters feed the generated IRQ to the IRQ selector block.
* **IRQ selector**. This block manages the individually generated period IRQs over a single interrupt line. The IRQ selector uses the period index as a vector. The IRQ selector expects an acknowledgment for IRQ taking and an acknowledgment for period function completion. The period index represents the priority of the period. Priority 0 is the highest. The lower the period index, the higher the priority.
  
## Software architecture ##

The software driver of the **Time Scheduler** component is designed to be included in a **Board Support Package** (BSP). The component's software architecture is shown in [Figure 3](#fig-sw-arc).

<div style="float:center" markdown="1">

<a name="fig-sw-arc"></a>

|![](./media/time-scheduler-SW-architecture.png "Time scheduler software architecture diagram")|
|:---:|
|*Figure 3. Time scheduler software architecture.*|

</div>

The device driver includes the following:

* **Device Instantiation** and **Device Initialization** blocks. HAL (Hardware Abstraction Layer) uses these blocks to construct the system startup section.  
  The *Device Instantiation* block creates a device instance for each Time Scheduler device present in the system.  
  The *Device Initialization* block performs initial setup and configuration of each Time Scheduler device present in the system.

* The **Interrupt Service Routine (ISR)** interacts with the Time Scheduler device through the *Device Register Interface*.  
  The ISR receives a pointer to the device instance (requiring service) as an input parameter.  
  Each device instance includes a pointer to a period function table, which is provided by the user software for each Time Scheduler device present in the system.

* The **Device Register Interface** provides access to the Time Scheduler device referenced by the corresponding device instance.

# COMPONENT CONFIGURATION. #

<Div style="float:center" markdown="1">
![Time scheduler functional diagram](./media/time-scheduler-HW-architecture.png "Time scheduler functional diagram")

figure 31.
</div>

<div style="float:center" markdown="1">
<figure>
  <img src="./media/time-scheduler-HW-architecture.png" alt="my alt text" />
  <figcaption>Figur 6. Hardware architecture.</figcaption>
</figure>
</div>

<div align="center">
  <p><img src="./media/time-scheduler-SW-architecture.png" /></p>
  <p>This is an image.</p>
</div>
