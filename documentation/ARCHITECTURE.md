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

The hardware module concist of three blocks:

  * **Timer function**.
  * **Period counter**.
  * **IRQ selector**.
  
  Each block has control/data registers connected to the Avalon Memory Mapped interface. All the registers are available for the software ran on Nios II processor connected to tne Avalon bus.
  
## Software architecture ##

The component software architecture is shown on [Figure 3](#fig-sw-arc).
<div style="float:center" markdown="1">

<a name="fig-sw-arc"></a>

|![](./media/time-scheduler-SW-architecture.png "Time scheduler software architecture diagram")|
|:---:|
|*Figure 3. Time scheduler software architecture.*|

</div>



<div style="float:center" markdown="1">
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
