onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /period_controller_vhd_tst/clk
add wave -noupdate /period_controller_vhd_tst/i1/tick_function_1/tick
add wave -noupdate /period_controller_vhd_tst/reset_n
add wave -noupdate /period_controller_vhd_tst/p0_irq_out
add wave -noupdate /period_controller_vhd_tst/cs_n
add wave -noupdate /period_controller_vhd_tst/addr
add wave -noupdate /period_controller_vhd_tst/write_n
add wave -noupdate /period_controller_vhd_tst/read_n
add wave -noupdate -radix ufixed /period_controller_vhd_tst/din
add wave -noupdate /period_controller_vhd_tst/dout
add wave -noupdate /period_controller_vhd_tst/irq_number
add wave -noupdate /period_controller_vhd_tst/ack_put_data_on
add wave -noupdate /period_controller_vhd_tst/ack_processing
add wave -noupdate /period_controller_vhd_tst/irq_enable_ph_1
add wave -noupdate /period_controller_vhd_tst/irq_enable_ph_2
add wave -noupdate /period_controller_vhd_tst/write_irq_enable
add wave -noupdate /period_controller_vhd_tst/i1/tick_length
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {32231170000 ps} 0}
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
WaveRestoreZoom {35746748455 ps} {35746939555 ps}
