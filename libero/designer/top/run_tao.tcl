set_device -family {PolarFireSoC} -die {MPFS095T} -speed {-1}
read_verilog -mode system_verilog {D:\TN.KTS\Libero\Connter\hdl\clock_divider.v}
read_verilog -mode system_verilog {D:\TN.KTS\Libero\Connter\hdl\counter.v}
read_verilog -mode system_verilog {D:\TN.KTS\Libero\Connter\hdl\debounce.v}
read_verilog -mode system_verilog {D:\TN.KTS\Libero\Connter\hdl\edge_detect.v}
read_verilog -mode system_verilog {D:\TN.KTS\Libero\Connter\hdl\fsm.v}
read_verilog -mode system_verilog {D:\TN.KTS\Libero\Connter\hdl\seven_segment_decoder.v}
read_verilog -mode system_verilog {D:\TN.KTS\Libero\Connter\hdl\top.v}
set_top_level {top}
map_netlist
check_constraints {D:\TN.KTS\Libero\Connter\constraint\synthesis_sdc_errors.log}
write_fdc {D:\TN.KTS\Libero\Connter\designer\top\synthesis.fdc}
