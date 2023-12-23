`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/12/2022 10:56:20 PM
// Design Name: 
// Module Name: Video_Data_Module
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


module Video_Data_Module(
    input clk,
    input [9:0] PX,
    input [9:0] PY,
    input [5:0] H_SW,
    input [5:0] V_SW,
    output reg Output_Enable    
    );
    
    always @(posedge clk)
    begin
        Output_Enable = ((PX[9:4] == H_SW) && (PY[9:4] == V_SW));
    end
    
endmodule