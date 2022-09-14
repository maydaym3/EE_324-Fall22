# Switches
set_property -dict { PACKAGE_PIN R17   IOSTANDARD LVCMOS33 } [get_ports { en }];
set_property -dict { PACKAGE_PIN U20   IOSTANDARD LVCMOS33 } [get_ports { rst }];
# Flag Leds
set_property -dict { PACKAGE_PIN N20  IOSTANDARD LVCMOS33 } [get_ports { H_SYNC }];
set_property -dict { PACKAGE_PIN P20  IOSTANDARD LVCMOS33 } [get_ports { V_SYNC }];
#clock
set_property -dict { PACKAGE_PIN H16  IOSTANDARD LVCMOS33 } [get_ports { clk }];
