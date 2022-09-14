`timescale 10ns / 100ps
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
reg rst, clk_in1; 
wire [9:0] a_val , b_val ;
reg en;
//Outputs
wire A, B;
wire clk_out1;

// Instantiate Wrapper Module
    clk_wiz_0 inst
  (
  // Clock out ports  
  .clk_out1(clk_out1),
  // Status and control signals               
  .reset(reset), 
  .locked(locked),
 // Clock in ports
  .clk_in1(clk_in1)
  );
count_wrap counter (.rst(rst),.clk(clk_out1),.a_val(a_val),.b_val(b_val),.en(en),.A(A),.B(B));


always #0.5 clk_in1 = ~clk_in1;

initial begin
    clk_in1 = 0;
    rst=1;
    en=1;
    
    #10 rst =0;
        
end

endmodule
