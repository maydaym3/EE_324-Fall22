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
    reg OE;
    wire [15:0] data;
    
    always @(*)
    begin
        Output_Enable = (OE && data[PX[3:0]]);
    end
    
    
    always @(*)
    begin
        OE = ((PX[9:4] == H_SW) && (PY[9:4] == V_SW));
    end
    
    char_gen char(
    .line_addr(PY[3:0]),
    .line_data(data)
    );
    
endmodule

module char_gen(
	input [3:0] line_addr,
	output [15:0] line_data
);

	reg [15:0] mini_rom[15:0];

	assign line_data = mini_rom[line_addr];

	initial
	begin
		mini_rom[0] =  16'b1111111111111111;
		mini_rom[1] =  16'b1000000000000001;
		mini_rom[2] =  16'b1000110000000001;
		mini_rom[3] =  16'b1000110000000001;
		mini_rom[4] =  16'b1000110011111101;
		mini_rom[5] =  16'b1000110111111001;
		mini_rom[6] =  16'b1000110000000001;
		mini_rom[7] =  16'b1000000000000001;
		mini_rom[8] =  16'b1000000000000001;
		mini_rom[9] =  16'b1001000000001001;
		mini_rom[10] = 16'b1000100000010001;
		mini_rom[11] = 16'b1000010000100001;
		mini_rom[12] = 16'b1000001010000001;
		mini_rom[13] = 16'b1000000100000001;
		mini_rom[14] = 16'b1000000000000001;
		mini_rom[15] = 16'b1111111111111111;
	end

endmodule