# TEST PROTOCOL

Two test protocols defined in this project:

  * Verification test protocol. This protocol defines testing by simulation the component functionality on ModelSim tool.
  * Validation test protocol defines testing the component functionality on DE10-Lite card in real inironment.
  
  
## Verification test protocol

The verification results must be presented in Table 1.

<!-- <caption> -->
<!-- Table 1. Verification test protocol. -->
<!-- </caption> -->

<!-- | No. | Test description                                                                                                                                                                                     | Acceptance | -->
<!-- |:----|:-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|:-----------| -->
<!-- | 1.  | Tick generation verification. The component generates tick pulses according to the specified parameter `tick_length`. The length of the output signal ``tick` is set according to the `tick_length`. |    | -->
<!-- |     |                                                                                                                                                                                                      |            | -->
<!-- | 2.  | Period counting verification. The counting ranges verified. The individual IRQ setting for each period verified                                                                                      |    | -->
<!-- | 3.  | IRQ processing verification. Interaction between interrupt requests and interrupt acknowledges verified. Multiplexing of IRQ line verified.                                                          |    | -->
<!-- | 4.  | Interaction with ISR verification. The register interface verified. The following of the defined time scheduler verified.                                                                            |    | -->
<!-- |     |                                                                                                                                                                                                      |            | -->


<table>
<caption>
Table 1. Verification test protocol.
</caption>
<colgroup>
<col style="width: 2%" />
<col style="width: 92%" />
<col style="width: 5%" />
</colgroup>
<thead>
<tr>
<th style="text-align: left;">No.</th>
<th style="text-align: left;">Test description</th>
<th style="text-align: left;">Acceptance</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align: left;">1.</td>
<td style="text-align: left;">Tick generation verification. The
component generates tick pulses according to the specified parameter
<code>tick_length</code>. The length of the output signal
`<code>tick</code> is set according to the
<code>tick_length</code>.</td>
<td style="text-align: left;"></td>
</tr>
<tr>
<td style="text-align: left;"></td>
<td style="text-align: left;"></td>
<td style="text-align: left;"></td>
</tr>
<tr>
<td style="text-align: left;">2.</td>
<td style="text-align: left;">Period counting verification. The counting
ranges verified. The individual IRQ setting for each period
verified</td>
<td style="text-align: left;"></td>
</tr>
<tr>
<td style="text-align: left;">3.</td>
<td style="text-align: left;">IRQ processing verification. Interaction
between interrupt requests and interrupt acknowledges verified.
Multiplexing of IRQ line verified.</td>
<td style="text-align: left;"></td>
</tr>
<tr>
<td style="text-align: left;">4.</td>
<td style="text-align: left;">Interaction with ISR verification. The
register interface verified. The following of the defined time scheduler
verified.</td>
<td style="text-align: left;"></td>
</tr>
<tr>
<td style="text-align: left;"></td>
<td style="text-align: left;"></td>
<td style="text-align: left;"></td>
</tr>
</tbody>
</table>


## Validation test protocol

The validation results must be presented in Table 2.

<!-- <caption> -->
<!-- Table 2. Validation test protocol. -->
<!-- </caption> -->


<!-- | No. | Test description                                                           | Acceptance | -->
<!-- |:----|:---------------------------------------------------------------------------|:-----------| -->
<!-- | 1.  | Time schedule verification. The period functions must report their timing. |            | -->
<!-- | 2.  | Preemption verification. The ISR must report the depth of preemption.      |            | -->
<!-- | 3.  | The target time must match the measured timing                             |            | -->


<table>
<caption>
Table 2. Validation test protocol.
</caption>
<colgroup>
<col style="width: 5%" />
<col style="width: 81%" />
<col style="width: 12%" />
</colgroup>
<thead>
<tr>
<th style="text-align: left;">No.</th>
<th style="text-align: left;">Test description</th>
<th style="text-align: left;">Acceptance</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align: left;">1.</td>
<td style="text-align: left;">Time schedule verification. The period
functions must report their timing.</td>
<td style="text-align: left;"></td>
</tr>
<tr>
<td style="text-align: left;">2.</td>
<td style="text-align: left;">Preemption verification. The ISR must
report the depth of preemption.</td>
<td style="text-align: left;"></td>
</tr>
<tr>
<td style="text-align: left;">3.</td>
<td style="text-align: left;">The target time must match the measured
timing</td>
<td style="text-align: left;"></td>
</tr>
</tbody>
</table>
