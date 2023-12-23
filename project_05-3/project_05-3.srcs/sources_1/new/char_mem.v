`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/13/2022 09:03:26 PM
// Design Name: 
// Module Name: char_mem
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


module char_mem(
    input clk,
    input store,
    input [6:0] sw,
    output [6:0] addr
    );
    
    reg [6:0]sw_state;
    
    assign addr = sw_state;
    
    always @(posedge clk)
    begin
        if(store)
        begin
            sw_state = sw;
        end
                
    end
endmodule
