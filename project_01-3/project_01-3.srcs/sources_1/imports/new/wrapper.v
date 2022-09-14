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
module bin_count #(parameter MAX_COUNT = 255, WIDTH = 8)
(
	input rst,
	input clk,
	input cen,
	output reg [WIDTH-1:0] val
);

always @ (posedge(clk), posedge(rst))

begin

if(rst || val >= MAX_COUNT) val <= 0;

else if (cen) val <= val +1;

end

endmodule


module VGA_Controller #(parameter H_Pixels = 823,V_Pixels=600,H_SYNC=96,V_SYNC=2)
(
    input rst,
    input clk,
    input en,
    output A,
    output B
    );
    wire [9:0] a_val;
    wire [9:0] b_val;
    wire a_en,b_en;
        
    bin_count #(.MAX_COUNT(H_Pixels),.WIDTH(10))
    cntrA(.rst(rst),.clk(clk),.cen(a_en),.val(a_val));
    
    bin_count #(.MAX_COUNT(V_Pixels),.WIDTH(10))
    cntrB(.rst(rst),.clk(clk),.cen(b_en),.val(b_val));
    
    assign a_en =en;
    
    assign b_en = (a_val==H_Pixels);
    assign A=(a_val<=H_SYNC);
    assign B=(b_val<=V_SYNC);
    
endmodule

module wrapper(
input rst,
input clk,
input en,
output H_sync,
output V_sync,
output VDE,
output [7:0] R,B,G
);
wire HSYNC,VSYNC;
wire VDE;
wire [7:0] R,G,B;

VGA_Controller #(.H_Pixels(823),.V_Pixels(600),.H_SYNC(96),.V_SYNC(2))
VGA(.rst(rst),.clk(clk),.en(en),.A(H_sync),.B(V_sync));

assign R=511;
assign G=511;
assign B=511;
assign VDE=1;

endmodule