`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/13/2022 10:42:42 PM
// Design Name: 
// Module Name: VGA_wrapper
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


module VGA_wrapper(
    input Pxl_clk,
    input rst,
    output [9:0] PX,
    output [9:0] PY,
    output HS,
    output VS,
    output VDE
    );
   
   wire H_RST;
   wire V_RST;
   wire H_S_P;
   wire H_S_N;
   wire V_S_P;
   wire V_S_N;
   
//Horizontal
assign H_RST =(PX==800);
assign H_S_P =(PX==0);
assign H_S_N =(PX==96);
//Vertical
assign V_RST =(PY==525);
assign V_S_P =(PY==0);
assign V_S_N =(PY==2);
//Video Data Enable
assign VDE=((PX>=144)&&(PX<=784)&&(PY>=35)&&(PY<=515));

   
   count #(.MAX_COUNT(800),.WIDTH(10))
   Horizontal(.rst(rst),.srst(H_RST),.clk(Pxl_clk),.cen(1),.val(PX));
   
   count #(.MAX_COUNT(525),.WIDTH(10))
   Vertical(.rst(rst),.srst(V_RST),.clk(Pxl_clk),.cen(H_RST),.val(PY));
   
   sr_latch H_Sync(.S(H_S_P),.R(H_S_N),.clk(Pxl_clk),.rst(rst),.Q(HS));
   sr_latch V_Sync(.S(V_S_P),.R(H_S_P),.clk(Pxl_clk),.rst(rst),.Q(VS));
   
endmodule

module count #(parameter MAX_COUNT = 255, WIDTH = 8)
(
	input rst,
	input srst,
	input clk,
	input cen,
	output reg [WIDTH-1:0] val
);

always @ (posedge(clk), posedge(rst))
begin
if(rst || val >= MAX_COUNT || srst) val <= 0;
else if (cen) val <= val +1;
end
endmodule

module sr_latch(
input S,
input R,
input clk,
input rst,
output reg Q
);


always @ (posedge(clk), posedge(rst))
begin
if (rst) Q=0;
else if (S) Q=1;
else if (R) Q=0;
end
endmodule