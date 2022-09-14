`timescale 10ps / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/06/2022 11:16:58 PM
// Design Name: 
// Module Name: testbench
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


module testbench;
//Inputs
reg rst, clk; 
wire [9:0] a_val , b_val ;
reg en;
//Outputs
wire A, B;

// Instantiate Wrapper Module
count_wrap counter (.rst(rst),.clk(clk),.a_val(a_val),.b_val(b_val),.en(en),.A(A),.B(B));


always #5 clk = ~clk;

initial begin
    clk = 0;
    rst=1;
    en=1;
    
    #10 rst =0;
        
end

endmodule
