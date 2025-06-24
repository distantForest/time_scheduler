# VALIDATION

The validation of the Time Scheduler Component is performed on the DE10-Lite card. The test system shematic is shown in the figure 17. The test system was created with the Platform Designer tool.

  <a name="fig-1-validation">
 <figure>
  <img src="./media/test_system_schematic.png" alt="Schematic diagram" style="width:100%; float:center">
  <figcaption>Figure 17. Test system schematic diagram.</figcaption>
</figure> 
  </a>

The four `agstu_hw_timer`-s are used for measuring of the defined time schedule. The Quartus project for the test system and the text of the test program are placed in the `examples` folder of the `agstu_time_scheduler` ip folder. A protocol of the test program execution is shown bellow.

```
Period 2 limit 16
Period 1 limit 6
Period 0 limit 1
-- background time adjustment 17
function 101c4
..irq vector 0, depth 1+++ Period 0 +++ 0 CounteD d150, PerioD 0
function 101c4
..irq vector 0, depth 1+++ Period 0 +++ 1 CounteD d357, PerioD 2faf03a
function 101c4
..irq vector 0, depth 1+++ Period 0 +++ 2 CounteD d357, PerioD 2faf037
function 10270
..irq vector 1, depth 1+++ Period 1 ++.+ 0 function 101c4
..irq vector 0, depth 2+++ Period 0 +++ 3 CounteD d357, PerioD 2faf03c
counted 2faf0d3, period 0
function 101c4
..irq vector 0, depth 1+++ Period 0 +++ 4 CounteD d357, PerioD 2faf037
function 101c4
..irq vector 0, depth 1+++ Period 0 +++ 5 CounteD d357, PerioD 2faf03e
function 101c4
..irq vector 0, depth 1+++ Period 0 +++ 6 CounteD d357, PerioD 2faf03e
function 10270
..irq vector 1, depth 1+++ Period 1 ++.+ 1 function 101c4
..irq vector 0, depth 2+++ Period 0 +++ 7 CounteD d357, PerioD 2faf03a
counted 2faf0e2, period a720961
function 101c4
..irq vector 0, depth 1+++ Period 0 +++ 8 CounteD d357, PerioD 2faf03b
Xfunction 101c4

```
The next follows en excerpt from the test protocol showing the maximal preemption depth:

```
..irq vector 0, depth 1+++ Period 0 +++ 21 CounteD de50, PerioD 2fae848
function 10340
..irq vector 2, depth 1*** Period 2 *** 2 function 101c4
..irq vector 0, depth 2+++ Period 0 +++ 22 CounteD de50, PerioD 2faf824
function 10270
..irq vector 1, depth 2+++ Period 1 ++.+ 9 function 101c4
..irq vector 0, depth 3+++ Period 0 +++ 23 CounteD de50, PerioD 2faf043
counted 2faf0e4, period a721445
COUNTED 47d9a61, PERIOD 224202a6
function 101c4
..irq vector 0, depth 1+++ Period 0 +++ 24 CounteD de50, PerioD 2faf036
function 101c4
..irq vector 0, depth 1+++ Period 0 +++ 25 CounteD de50, PerioD 2faf03b
function 10270
..irq vector 1, depth 1+++ Period 1 ++.+ a function 101c4
..irq vector 0, depth 2+++ Period 0 +++ 26 CounteD de50, PerioD 2faf03a
counted 2faf0e6, period a6a7eac
function 101c4
..irq vector 0, depth 1+++ Period 0 +++ 27 CounteD de50, PerioD 2faf03a
function 101c4

```
The parameter `depth` indicates preemption depth. The results of the time measurements are shown in Table 6.

<!-- <caption> -->
<!-- Table 6. Timing measurements. -->
<!-- </caption> -->

<!-- | Target period length, tick | Period length mesured | Tick length       | Period length in ticks, measured | Period length in seconds | -->
<!-- |:---------------------------|:----------------------|:------------------|:---------------------------------|:-------------------------| -->
<!-- | 2                          | 2faf037               | 24999963.5        | 1.99999708                       | 0.9999985400000001       | -->
<!-- |                            |                       |                   |                                  |                          | -->
<!-- | 7                          | a6a7ead               | 24964486.42857143 | 6.9900562                        | 3.4950281000000003       | -->
<!-- |                            |                       |                   |                                  |                          | -->
<!-- | 23                         | 22499852              | 25010802.86956522 | 23.00993864                      | 11.50496932              | -->
<!-- |                            |                       |                   |                                  |                          | -->

<table>
<caption>
Table 6. Time measurements.
</caption>
<colgroup>
<col style="width: 21%" />
<col style="width: 17%" />
<col style="width: 14%" />
<col style="width: 26%" />
<col style="width: 20%" />
</colgroup>
<thead>
<tr>
<th style="text-align: left;">Target period length, tick</th>
<th style="text-align: left;">Period length mesured, clocks</th>
<th style="text-align: left;">Tick length</th>
<th style="text-align: left;">Period length in ticks, measured</th>
<th style="text-align: left;">Period length in seconds</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align: left;">2</td>
<td style="text-align: left;">0x2faf037</td>
<td style="text-align: left;">24999963.5</td>
<td style="text-align: left;">1.99999708</td>
<td style="text-align: left;">0.9999985400000001</td>
</tr>
<tr>
<td style="text-align: left;"></td>
<td style="text-align: left;"></td>
<td style="text-align: left;"></td>
<td style="text-align: left;"></td>
<td style="text-align: left;"></td>
</tr>
<tr>
<td style="text-align: left;">7</td>
<td style="text-align: left;">0xa6a7ead</td>
<td style="text-align: left;">24964486.42857143</td>
<td style="text-align: left;">6.9900562</td>
<td style="text-align: left;">3.4950281000000003</td>
</tr>
<tr>
<td style="text-align: left;"></td>
<td style="text-align: left;"></td>
<td style="text-align: left;"></td>
<td style="text-align: left;"></td>
<td style="text-align: left;"></td>
</tr>
<tr>
<td style="text-align: left;">23</td>
<td style="text-align: left;">0x22499852</td>
<td style="text-align: left;">25010802.86956522</td>
<td style="text-align: left;">23.00993864</td>
<td style="text-align: left;">11.50496932</td>
</tr>
<tr>
<td style="text-align: left;"></td>
<td style="text-align: left;"></td>
<td style="text-align: left;"></td>
<td style="text-align: left;"></td>
<td style="text-align: left;"></td>
</tr>
</tbody>
</table>

The test results are presented in Table 7.

<!-- <caption> -->
<!-- Table 7. Validation test protocol. -->
<!-- </caption> -->


<!-- | No. | Test description                                                           | Acceptance | -->
<!-- |:----|:---------------------------------------------------------------------------|:-----------| -->
<!-- | 1.  | Time schedule verification. The period functions must report their timing. | Approved   | -->
<!-- | 2.  | Preemption verification. The ISR must report the depth of preemption.      | Approved   | -->
<!-- | 3.  | The target time must match the measured timing                             | Approved           | -->


<table>
<caption>
Table 7. Validation test protocol.
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
<td style="text-align: left;">Approved</td>
</tr>
<tr>
<td style="text-align: left;">2.</td>
<td style="text-align: left;">Preemption verification. The ISR must
report the depth of preemption.</td>
<td style="text-align: left;">Approved</td>
</tr>
<tr>
<td style="text-align: left;">3.</td>
<td style="text-align: left;">The target time must match the measured
timing</td>
<td style="text-align: left;">Approved</td>
</tr>
</tbody>
</table>


The validation approved.

# REFERENCES

1. Time Scheduler Component. Github repository https://github.com/distantForest/time_scheduler
