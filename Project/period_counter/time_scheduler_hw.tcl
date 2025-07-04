# TCL File Generated by Component Editor 18.1
# Tue Jan 28 19:24:55 CET 2025
# DO NOT MODIFY


# 
# time_scheduler "time_scheduler" v1.0
#  2025.01.28.19:24:55
# 
# 

# 
# request TCL package from ACDS 16.1
# 
package require -exact qsys 16.1


# 
# module time_scheduler
# 
set_module_property DESCRIPTION ""
set_module_property NAME time_scheduler
set_module_property VERSION 1.0
set_module_property INTERNAL false
set_module_property OPAQUE_ADDRESS_MAP true
set_module_property AUTHOR ""
set_module_property DISPLAY_NAME time_scheduler
set_module_property INSTANTIATE_IN_SYSTEM_MODULE true
set_module_property EDITABLE true
set_module_property REPORT_TO_TALKBACK false
set_module_property ALLOW_GREYBOX_GENERATION false
set_module_property REPORT_HIERARCHY false


# 
# file sets
# 
add_fileset QUARTUS_SYNTH QUARTUS_SYNTH "" ""
set_fileset_property QUARTUS_SYNTH TOP_LEVEL period_controller
set_fileset_property QUARTUS_SYNTH ENABLE_RELATIVE_INCLUDE_PATHS false
set_fileset_property QUARTUS_SYNTH ENABLE_FILE_OVERWRITE_MODE false
add_fileset_file period_controller.vhd VHDL PATH ../hdl/period_controller.vhd TOP_LEVEL_FILE
add_fileset_file tick_timer.vhd VHDL PATH ../hdl/tick_timer.vhd
add_fileset_file irq_selector.vhd VHDL PATH ../hdl/irq_selector.vhd


# 
# parameters
# 
add_parameter counter_height INTEGER 4 ""
set_parameter_property counter_height DEFAULT_VALUE 4
set_parameter_property counter_height DISPLAY_NAME counter_height
set_parameter_property counter_height WIDTH ""
set_parameter_property counter_height TYPE INTEGER
set_parameter_property counter_height UNITS None
set_parameter_property counter_height ALLOWED_RANGES 1:16
set_parameter_property counter_height DESCRIPTION ""
set_parameter_property counter_height HDL_PARAMETER true

# add_system_info "COUNTER_HEIGHT" [get_parameter_value counter_height]


add_parameter tick_length INTEGER 25000000 "tick puls length in system clock pulses"
set_parameter_property tick_length DEFAULT_VALUE 25000000
set_parameter_property tick_length DISPLAY_NAME tick_length
set_parameter_property tick_length TYPE INTEGER
set_parameter_property tick_length UNITS None
set_parameter_property tick_length ALLOWED_RANGES -2147483648:2147483647
set_parameter_property tick_length DESCRIPTION "tick puls length in system clock pulses"
set_parameter_property tick_length HDL_PARAMETER true

for {set i 0} {$i < 16} {incr i} {
set param_name ""

append param_name "per" $i 
    add_parameter $param_name INTEGER [expr $i + 1] "Period length for period $i"

    set_parameter_property $param_name VISIBLE false
    set_parameter_property $param_name HDL_PARAMETER true
    set_parameter_property $param_name DEFAULT_VALUE [expr $i + 1] 
}
set_module_property VALIDATION_CALLBACK  adjust_height
set_module_property ELABORATION_CALLBACK  post_elaboration


proc log2ceil {arg} {
    if {$arg <= 1} {
        return 0
    }
    
    set log 0
    set tmp 1
    
    while {$tmp < $arg} {
        set tmp [expr {$tmp * 2}]
        set log [expr {$log + 1}]
    }
    
    return $log
}

proc post_elaboration {} {
    set_module_assignment embeddedsw.CMacro.HEIGHT \
	[get_parameter_value counter_height]
    # add_sw_property COUNTER_HEIGHT [get_parameter_value counter_height]
    add_interface_port avalon_slave_0 addr address Input \
	[log2ceil [expr {[get_parameter_value counter_height] + 1 + 4}]]
    # 2

}


proc adjust_height {} {
    set per_len [get_parameter_value counter_height]

    if {$per_len > 0} {    
	for {set i 0} {$i < 16} {incr i} {
	    set param_name ""
	    if {$i < $per_len} {
		set vis true
	    } else {
		set vis false
	    }
	    append param_name "per" $i
	    set_parameter_property $param_name VISIBLE $vis
      	}
    }
}
# 
# display items
# 
add_display_item "tick generator" tick_length PARAMETER ""


# 
# connection point clock
# 
add_interface clock clock end
set_interface_property clock clockRate 0
set_interface_property clock ENABLED true
set_interface_property clock EXPORT_OF ""
set_interface_property clock PORT_NAME_MAP ""
set_interface_property clock CMSIS_SVD_VARIABLES ""
set_interface_property clock SVD_ADDRESS_GROUP ""

add_interface_port clock clk clk Input 1


# 
# connection point reset
# 
add_interface reset reset end
set_interface_property reset associatedClock clock
set_interface_property reset synchronousEdges DEASSERT
set_interface_property reset ENABLED true
set_interface_property reset EXPORT_OF ""
set_interface_property reset PORT_NAME_MAP ""
set_interface_property reset CMSIS_SVD_VARIABLES ""
set_interface_property reset SVD_ADDRESS_GROUP ""

add_interface_port reset reset_n reset_n Input 1


# 
# connection point avalon_slave_0
#


add_interface avalon_slave_0 avalon end
set_interface_property avalon_slave_0 addressUnits WORDS
set_interface_property avalon_slave_0 associatedClock clock
set_interface_property avalon_slave_0 associatedReset reset
set_interface_property avalon_slave_0 bitsPerSymbol 8
set_interface_property avalon_slave_0 burstOnBurstBoundariesOnly false
set_interface_property avalon_slave_0 burstcountUnits WORDS
set_interface_property avalon_slave_0 explicitAddressSpan 0
set_interface_property avalon_slave_0 holdTime 0
set_interface_property avalon_slave_0 linewrapBursts false
set_interface_property avalon_slave_0 maximumPendingReadTransactions 0
set_interface_property avalon_slave_0 maximumPendingWriteTransactions 0
set_interface_property avalon_slave_0 readLatency 0
set_interface_property avalon_slave_0 readWaitTime 1
set_interface_property avalon_slave_0 setupTime 0
set_interface_property avalon_slave_0 timingUnits Cycles
set_interface_property avalon_slave_0 writeWaitTime 0
set_interface_property avalon_slave_0 ENABLED true
set_interface_property avalon_slave_0 EXPORT_OF ""
set_interface_property avalon_slave_0 PORT_NAME_MAP ""
set_interface_property avalon_slave_0 CMSIS_SVD_VARIABLES ""
set_interface_property avalon_slave_0 SVD_ADDRESS_GROUP ""

add_interface_port avalon_slave_0 cs_n chipselect_n Input 1
# add_interface_port avalon_slave_0 addr address Input 2
add_interface_port avalon_slave_0 write_n write_n Input 1
add_interface_port avalon_slave_0 read_n read_n Input 1
add_interface_port avalon_slave_0 din writedata Input 32
add_interface_port avalon_slave_0 dout readdata Output 32
set_interface_assignment avalon_slave_0 embeddedsw.configuration.isFlash 0
set_interface_assignment avalon_slave_0 embeddedsw.configuration.isMemoryDevice 0
set_interface_assignment avalon_slave_0 embeddedsw.configuration.isNonVolatileStorage 0
set_interface_assignment avalon_slave_0 embeddedsw.configuration.isPrintableDevice 0


# 
# connection point interrupt_sender
# 
add_interface interrupt_sender interrupt end
set_interface_property interrupt_sender associatedAddressablePoint avalon_slave_0
set_interface_property interrupt_sender associatedClock clock
set_interface_property interrupt_sender associatedReset reset
set_interface_property interrupt_sender bridgedReceiverOffset ""
set_interface_property interrupt_sender bridgesToReceiver ""
set_interface_property interrupt_sender ENABLED true
set_interface_property interrupt_sender EXPORT_OF ""
set_interface_property interrupt_sender PORT_NAME_MAP ""
set_interface_property interrupt_sender CMSIS_SVD_VARIABLES ""
set_interface_property interrupt_sender SVD_ADDRESS_GROUP ""

add_interface_port interrupt_sender p0_irq_out irq Output 1


#
# vector out
#
# add_interface vector conduit end
# set_interface_property vector associatedClock clock
# set_interface_property vector associatedReset reset
# set_interface_property vector ENABLED true
# set_interface_property vector EXPORT_OF ""
# set_interface_property vector PORT_NAME_MAP ""
# set_interface_property vector CMSIS_SVD_VARIABLES ""
# set_interface_property vector SVD_ADDRESS_GROUP ""

# add_interface_port vector vector name Output 1
