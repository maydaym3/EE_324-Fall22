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
    input [6:0] char,
    input [9:0] PX,
    input [9:0] PY,
    input [5:0] H_SW,
    input [5:0] V_SW,
    output reg Output_Enable    
    );
    reg OE;
    wire [15:0] data;
    
    always @(PX[9:4])
    begin
        Output_Enable = (OE && data[~PX[3:0]]);
    end
    
    
    always @(*)
    begin
//        OE = 1'b1;
        OE = ((PX[9:4] == H_SW) && (PY[9:4] == V_SW));
    end
    
    char_rom ascii_rom(
    .DO(data),       // Output data, width defined by READ_WIDTH parameter
    .ADDR({char[6:0],~PY[3:0]}),   // Input address, width defined by read/write port depth
    .CLK(clk),     // 1-bit input clock
    .DI(16'h0),       // Input data port, width defined by WRITE_WIDTH parameter
    .EN(1'b1),       // 1-bit input RAM enable
    .REGCE(1'b0), // 1-bit input output register enable
    .RST(1'b0),     // 1-bit input reset
    .WE(2'd0)        // Input write enable, width defined by write port depth
    );
    
endmodule