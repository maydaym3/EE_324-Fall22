`timescale 10ns / 100ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/30/2022 07:31:45 PM
// Design Name: 
// Module Name: count_wrap
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////



module wrapper(
input [11:0] sw,
input rst,
input clk,
input storeChar,
output HDMI_CLK_N,
output HDMI_CLK_P,
output [2:0] HDMI_D_P,
output [2:0] HDMI_D_N
);

wire clk_25MHz;
wire clk_125Mhz;
wire locked;
wire HSYNC,VSYNC;
wire VDE;
wire [7:0] R,G,B;
wire [9:0] PX,PY;
wire Output_Enable;
wire [6:0] char_sel;

VGA_module VGA(
    .clk(clk_25MHz),
    .rst(rst),
    .PX(PX),
    .PY(PY),
    .HS(HSYNC),
    .VS(VSYNC),
    .VDE(VDE)
);

clk_wiz_0 inst
  (
  // Clock out ports  
  .clk_out1(clk_25MHz),
  .clk_out2(clk_125MHz),
  // Status and control signals               
  .reset(rst), 
  .locked(locked),
 // Clock in ports
  .clk_in1(clk)
  );




//Real Digital VGA to HDMI converter
hdmi_tx_0 vga_to_hdmi (
    //Clocking and Reset
    .pix_clk(clk_25MHz),
    .pix_clkx5(clk_125MHz),
    .pix_clk_locked(locked),
    //Reset is active HIGH
    .rst(rst),
    
    //Color and Sync Signals
    .red(R),
    .green(G),
    .blue(B),
    .hsync(HSYNC),
    .vsync(VSYNC),
    .vde(VDE),
    
    //aux Data (unused)
    .aux0_din(4'b0),
    .aux1_din(4'b0),
    .aux2_din(4'b0),
    .ade(1'b0),
    
    //Differential outputs
    .TMDS_CLK_P(HDMI_CLK_P),          
    .TMDS_CLK_N(HDMI_CLK_N),          
    .TMDS_DATA_P(HDMI_D_P),         
    .TMDS_DATA_N(HDMI_D_N)          
	);

 Video_Data_Module Data(
    .clk(clk_25MHz),
    .char(char_sel),
    .PX(PX),
    .PY(PY),
    .H_SW(sw[5:0]),
    .V_SW(sw[11:6]),
    .Output_Enable(Output_Enable)
 );

char_mem char_sel(
    .clk(clk_25MHz),
    .store(storeChar),
    .sw(sw[6:0]),
    .addr(char_sel)
    );

assign R = (VDE && Output_Enable) ? 255:0;
assign G = (VDE && Output_Enable) ? 255:0;
assign B = (VDE && Output_Enable) ? 255:0;



endmodule