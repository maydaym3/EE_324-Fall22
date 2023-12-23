
set_property -dict { PACKAGE_PIN W14   IOSTANDARD LVCMOS33 } [get_ports { start }];
set_property -dict { PACKAGE_PIN W13   IOSTANDARD LVCMOS33 } [get_ports { stop }];
set_property -dict { PACKAGE_PIN P15   IOSTANDARD LVCMOS33 } [get_ports { incr }];
set_property -dict { PACKAGE_PIN M14   IOSTANDARD LVCMOS33 } [get_ports { rst }];

set_property -dict { PACKAGE_PIN H16  IOSTANDARD LVCMOS33 } [get_ports { clk }];


set_property -dict { PACKAGE_PIN K19  IOSTANDARD LVCMOS33 } [get_ports { SSDA[0] }];
set_property -dict { PACKAGE_PIN H17  IOSTANDARD LVCMOS33 } [get_ports { SSDA[1] }];
set_property -dict { PACKAGE_PIN M18  IOSTANDARD LVCMOS33 } [get_ports { SSDA[2] }];
set_property -dict { PACKAGE_PIN L16  IOSTANDARD LVCMOS33 } [get_ports { SSDA[3] }];

set_property -dict { PACKAGE_PIN K14  IOSTANDARD LVCMOS33 } [get_ports { SSDC[0] }];
set_property -dict { PACKAGE_PIN H15  IOSTANDARD LVCMOS33 } [get_ports { SSDC[1] }];
set_property -dict { PACKAGE_PIN J18  IOSTANDARD LVCMOS33 } [get_ports { SSDC[2] }];
set_property -dict { PACKAGE_PIN J15  IOSTANDARD LVCMOS33 } [get_ports { SSDC[3] }];
set_property -dict { PACKAGE_PIN M17  IOSTANDARD LVCMOS33 } [get_ports { SSDC[4] }];
set_property -dict { PACKAGE_PIN J16  IOSTANDARD LVCMOS33 } [get_ports { SSDC[5] }];
set_property -dict { PACKAGE_PIN H18  IOSTANDARD LVCMOS33 } [get_ports { SSDC[6] }];
set_property -dict { PACKAGE_PIN K18  IOSTANDARD LVCMOS33 } [get_ports { SSDC[7] }];