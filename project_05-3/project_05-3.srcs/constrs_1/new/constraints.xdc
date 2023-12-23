# Switches
set_property -dict { PACKAGE_PIN R17   IOSTANDARD LVCMOS33 } [get_ports { sw[0] }];
set_property -dict { PACKAGE_PIN U20   IOSTANDARD LVCMOS33 } [get_ports { sw[1] }];
set_property -dict { PACKAGE_PIN R16   IOSTANDARD LVCMOS33 } [get_ports { sw[2] }];
set_property -dict { PACKAGE_PIN N16   IOSTANDARD LVCMOS33 } [get_ports { sw[3] }];
set_property -dict { PACKAGE_PIN R14   IOSTANDARD LVCMOS33 } [get_ports { sw[4] }];
set_property -dict { PACKAGE_PIN P14   IOSTANDARD LVCMOS33 } [get_ports { sw[5] }];
set_property -dict { PACKAGE_PIN L15   IOSTANDARD LVCMOS33 } [get_ports { sw[6] }];
set_property -dict { PACKAGE_PIN M15   IOSTANDARD LVCMOS33 } [get_ports { sw[7] }];
set_property -dict { PACKAGE_PIN T10   IOSTANDARD LVCMOS33 } [get_ports { sw[8] }];
set_property -dict { PACKAGE_PIN T12   IOSTANDARD LVCMOS33 } [get_ports { sw[9] }];
set_property -dict { PACKAGE_PIN T11   IOSTANDARD LVCMOS33 } [get_ports { sw[10] }];
set_property -dict { PACKAGE_PIN T14   IOSTANDARD LVCMOS33 } [get_ports { sw[11] }];

#button
set_property -dict { PACKAGE_PIN W14   IOSTANDARD LVCMOS33 } [get_ports { rst }];
set_property -dict { PACKAGE_PIN W13   IOSTANDARD LVCMOS33 } [get_ports { storeChar }];


#clock
set_property -dict { PACKAGE_PIN H16  IOSTANDARD LVCMOS33 } [get_ports { clk }];

#These constraints are for the Blackboard
set_property -dict { PACKAGE_PIN U19   IOSTANDARD TMDS_33 } [get_ports HDMI_CLK_N]; #IO_L12N_T1_MRCC_34 Sch=HDMI_TX_CLK_N
set_property -dict { PACKAGE_PIN U18   IOSTANDARD TMDS_33 } [get_ports HDMI_CLK_P]; #IO_L12P_T1_MRCC_34 Sch=HDMI_TX_CLK_P

set_property -dict { PACKAGE_PIN V18   IOSTANDARD TMDS_33 } [get_ports HDMI_D_N[0]]; #IO_L21N_T3_DQS_34 Sch=HDMI_TX0_N
set_property -dict { PACKAGE_PIN P18   IOSTANDARD TMDS_33 } [get_ports HDMI_D_N[1]]; #IO_L23N_T3_34 Sch=HDMI_TX1_N
set_property -dict { PACKAGE_PIN P19   IOSTANDARD TMDS_33 } [get_ports HDMI_D_N[2]]; #IO_L13N_T2_MRCC_34 Sch=HDMI_TX2_N

set_property -dict { PACKAGE_PIN V17   IOSTANDARD TMDS_33 } [get_ports HDMI_D_P[0]]; #IO_L21P_T3_DQS_34 Sch=HDMI_TX0_P
set_property -dict { PACKAGE_PIN N17   IOSTANDARD TMDS_33 } [get_ports HDMI_D_P[1]]; #IO_L23P_T3_34 Sch=HDMI_TX1_P
set_property -dict { PACKAGE_PIN N18   IOSTANDARD TMDS_33 } [get_ports HDMI_D_P[2]]; #IO_L13P_T2_MRCC_34 Sch=HDMI_TX2_P