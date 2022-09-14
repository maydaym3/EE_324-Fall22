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



module count_wrap(
    input rst,
    input clk,
    output [9:0] a_val,
    output [9:0] b_val,
    input en,
    output A,
    output B
    );
    wire a_en,b_en;
    
    
    bin_count #(.MAX_COUNT(823),.WIDTH(10))
    cntrA(.rst(rst),.clk(clk),.cen(a_en),.val(a_val));
    
    bin_count #(.MAX_COUNT(600),.WIDTH(10))
    cntrB(.rst(rst),.clk(clk),.cen(b_en),.val(b_val));
    
    assign a_en =en;
    
    assign b_en = (a_val==823);
    
    assign A=(a_val<=412);
    assign B=(b_val<=300);
    
endmodule
