# Switches
set_property -dict {PACKAGE_PIN R17 IOSTANDARD LVCMOS33} [get_ports en]
set_property -dict {PACKAGE_PIN U20 IOSTANDARD LVCMOS33} [get_ports rst]
# Flag Leds
set_property -dict {PACKAGE_PIN N20 IOSTANDARD LVCMOS33} [get_ports H_sync]
set_property -dict {PACKAGE_PIN P20 IOSTANDARD LVCMOS33} [get_ports V_sync]
#clock
set_property -dict {PACKAGE_PIN H16 IOSTANDARD LVCMOS33} [get_ports clk]


create_debug_core u_ila_0 ila
set_property ALL_PROBE_SAME_MU true [get_debug_cores u_ila_0]
set_property ALL_PROBE_SAME_MU_CNT 1 [get_debug_cores u_ila_0]
set_property C_ADV_TRIGGER false [get_debug_cores u_ila_0]
set_property C_DATA_DEPTH 16384 [get_debug_cores u_ila_0]
set_property C_EN_STRG_QUAL false [get_debug_cores u_ila_0]
set_property C_INPUT_PIPE_STAGES 0 [get_debug_cores u_ila_0]
set_property C_TRIGIN_EN false [get_debug_cores u_ila_0]
set_property C_TRIGOUT_EN false [get_debug_cores u_ila_0]
set_property port_width 1 [get_debug_ports u_ila_0/clk]
connect_debug_port u_ila_0/clk [get_nets [list clk_IBUF_BUFG]]
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe0]
set_property port_width 10 [get_debug_ports u_ila_0/probe0]
connect_debug_port u_ila_0/probe0 [get_nets [list {VGA/a_val[0]} {VGA/a_val[1]} {VGA/a_val[2]} {VGA/a_val[3]} {VGA/a_val[4]} {VGA/a_val[5]} {VGA/a_val[6]} {VGA/a_val[7]} {VGA/a_val[8]} {VGA/a_val[9]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe1]
set_property port_width 10 [get_debug_ports u_ila_0/probe1]
connect_debug_port u_ila_0/probe1 [get_nets [list {VGA/b_val[0]} {VGA/b_val[1]} {VGA/b_val[2]} {VGA/b_val[3]} {VGA/b_val[4]} {VGA/b_val[5]} {VGA/b_val[6]} {VGA/b_val[7]} {VGA/b_val[8]} {VGA/b_val[9]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA [get_debug_ports u_ila_0/probe2]
set_property port_width 1 [get_debug_ports u_ila_0/probe2]
connect_debug_port u_ila_0/probe2 [get_nets [list H_sync_OBUF]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA [get_debug_ports u_ila_0/probe3]
set_property port_width 1 [get_debug_ports u_ila_0/probe3]
connect_debug_port u_ila_0/probe3 [get_nets [list V_sync_OBUF]]
set_property C_CLK_INPUT_FREQ_HZ 300000000 [get_debug_cores dbg_hub]
set_property C_ENABLE_CLK_DIVIDER false [get_debug_cores dbg_hub]
set_property C_USER_SCAN_CHAIN 1 [get_debug_cores dbg_hub]
connect_debug_port dbg_hub/clk [get_nets clk_IBUF_BUFG]
