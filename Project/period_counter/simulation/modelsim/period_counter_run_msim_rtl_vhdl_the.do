transcript on
if ![file isdirectory vhdl_libs] {
	file mkdir vhdl_libs
}

vlib vhdl_libs/altera
vmap altera ./vhdl_libs/altera
vcom -2008 -work altera {/home/igor/work/intelFPGA_lite/18.1/quartus/eda/sim_lib/altera_syn_attributes.vhd}
vcom -2008 -work altera {/home/igor/work/intelFPGA_lite/18.1/quartus/eda/sim_lib/altera_standard_functions.vhd}
vcom -2008 -work altera {/home/igor/work/intelFPGA_lite/18.1/quartus/eda/sim_lib/alt_dspbuilder_package.vhd}
vcom -2008 -work altera {/home/igor/work/intelFPGA_lite/18.1/quartus/eda/sim_lib/altera_europa_support_lib.vhd}
vcom -2008 -work altera {/home/igor/work/intelFPGA_lite/18.1/quartus/eda/sim_lib/altera_primitives_components.vhd}
vcom -2008 -work altera {/home/igor/work/intelFPGA_lite/18.1/quartus/eda/sim_lib/altera_primitives.vhd}

vlib vhdl_libs/lpm
vmap lpm ./vhdl_libs/lpm
vcom -2008 -work lpm {/home/igor/work/intelFPGA_lite/18.1/quartus/eda/sim_lib/220pack.vhd}
vcom -2008 -work lpm {/home/igor/work/intelFPGA_lite/18.1/quartus/eda/sim_lib/220model.vhd}

vlib vhdl_libs/sgate
vmap sgate ./vhdl_libs/sgate
vcom -2008 -work sgate {/home/igor/work/intelFPGA_lite/18.1/quartus/eda/sim_lib/sgate_pack.vhd}
vcom -2008 -work sgate {/home/igor/work/intelFPGA_lite/18.1/quartus/eda/sim_lib/sgate.vhd}

vlib vhdl_libs/altera_mf
vmap altera_mf ./vhdl_libs/altera_mf
vcom -2008 -work altera_mf {/home/igor/work/intelFPGA_lite/18.1/quartus/eda/sim_lib/altera_mf_components.vhd}
vcom -2008 -work altera_mf {/home/igor/work/intelFPGA_lite/18.1/quartus/eda/sim_lib/altera_mf.vhd}

vlib vhdl_libs/altera_lnsim
vmap altera_lnsim ./vhdl_libs/altera_lnsim
vlog -sv -work altera_lnsim {/home/igor/work/intelFPGA_lite/18.1/quartus/eda/sim_lib/mentor/altera_lnsim_for_vhdl.sv}
vcom -2008 -work altera_lnsim {/home/igor/work/intelFPGA_lite/18.1/quartus/eda/sim_lib/altera_lnsim_components.vhd}

vlib vhdl_libs/fiftyfivenm
vmap fiftyfivenm ./vhdl_libs/fiftyfivenm
vlog -vlog01compat -work fiftyfivenm {/home/igor/work/intelFPGA_lite/18.1/quartus/eda/sim_lib/mentor/fiftyfivenm_atoms_ncrypt.v}
vcom -2008 -work fiftyfivenm {/home/igor/work/intelFPGA_lite/18.1/quartus/eda/sim_lib/fiftyfivenm_atoms.vhd}
vcom -2008 -work fiftyfivenm {/home/igor/work/intelFPGA_lite/18.1/quartus/eda/sim_lib/fiftyfivenm_components.vhd}

if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vcom -2008 -work work {/home/igor/AGSTU/TEIS/EX_JOBB/B/time_scheduler/Project/hdl/tick_timer.vhd}
vcom -2008 -work work {/home/igor/AGSTU/TEIS/EX_JOBB/B/time_scheduler/Project/hdl/period_controller.vhd}

vcom -2008 -work work {/home/igor/AGSTU/TEIS/EX_JOBB/B/time_scheduler/Project/period_counter/simulation/modelsim/period_controller.vht}

vsim -t 1ps -L altera -L lpm -L sgate -L altera_mf -L altera_lnsim -L fiftyfivenm -L rtl_work -L work -voptargs="+acc"  period_controller_vhd_tst

add wave *
view structure
view signals
do wave.do
run -all

