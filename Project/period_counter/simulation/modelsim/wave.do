onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /period_controller_vhd_tst/clk
add wave -noupdate /period_controller_vhd_tst/reset_n
add wave -noupdate /period_controller_vhd_tst/p0_irq_ack
add wave -noupdate /period_controller_vhd_tst/p0_irq_out
add wave -noupdate /period_controller_vhd_tst/p0
add wave -noupdate /period_controller_vhd_tst/p1
add wave -noupdate /period_controller_vhd_tst/p2
add wave -noupdate /period_controller_vhd_tst/p3
add wave -noupdate /period_controller_vhd_tst/ack_0
add wave -noupdate /period_controller_vhd_tst/ack_1
add wave -noupdate /period_controller_vhd_tst/ack_2
add wave -noupdate /period_controller_vhd_tst/i1/p0_counter_irq
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 0
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {155596193059 ps} {155599094233 ps}
