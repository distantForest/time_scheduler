onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /period_controller_vhd_tst/clk
add wave -noupdate /period_controller_vhd_tst/p0
add wave -noupdate /period_controller_vhd_tst/p1
add wave -noupdate /period_controller_vhd_tst/p2
add wave -noupdate /period_controller_vhd_tst/p3
add wave -noupdate /period_controller_vhd_tst/reset_n
add wave -noupdate /period_controller_vhd_tst/i1/tick_function_1/tick
add wave -noupdate /period_controller_vhd_tst/i1/tick_front
add wave -noupdate /period_controller_vhd_tst/i1/tick_ack
add wave -noupdate /period_controller_vhd_tst/i1/counter_p0
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {298532580000 ps} 0}
quietly wave cursor active 1
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
WaveRestoreZoom {298532122369 ps} {298535277861 ps}
