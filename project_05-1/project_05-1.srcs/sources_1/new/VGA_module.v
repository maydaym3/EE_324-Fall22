`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/12/2022 06:37:21 PM
// Design Name: 
// Module Name: VGA_module
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


module VGA_module #(
    parameter HAP = 640,
    parameter HTP = 800,
    parameter HFP = 16, 
    parameter HSW = 96,
    parameter HBP = 48,
    parameter VAP = 480,
    parameter VTP = 525,
    parameter VFP = 10,
    parameter VSW = 2,
    parameter VBP = 33
)
(
    input clk,
    input rst,
    output [9:0] PX,
    output [9:0] PY,
    output HS,
    output VS,
    output VDE
    );
    
    reg [9:0] Horizontal_Count;
    reg Horizontal_EOR;
    reg Horizontal_Sync;
    reg [9:0] Vertical_Count;
    reg Vertical_EOF;
    reg Vertical_Sync;
    reg Video_Data_Enable;
    
    assign PX = Horizontal_Count;
    assign PY = Vertical_Count;
    assign VS = Vertical_Sync;
    assign HS = Horizontal_Sync;
    assign VDE = Video_Data_Enable;
    
    // Horizontal Counter
    always @(posedge clk or posedge rst)
    begin
        if(rst)
            Horizontal_Count = 0;
        else if(Horizontal_EOR)
            Horizontal_Count = 0;
        else
            Horizontal_Count = Horizontal_Count + 1'b1;
    end
    
    // Vertical Counter
    always @(posedge clk or posedge rst)
    begin
        if (rst)
            Vertical_Count = 0;
        else if(Vertical_EOF)
            Vertical_Count = 0;
        else if(Horizontal_EOR)
            Vertical_Count = Vertical_Count + 1'b1;
    end
       
    // Horizontal Sync Comparator
    // Vertical Sync Comparator
    always @(posedge clk or posedge rst)
    begin
        if(rst)
        begin
            Horizontal_Sync = 1'b0;
            Vertical_Sync = 1'b0;
        end     
        else
        begin
            Horizontal_Sync = ((Horizontal_Count < (HAP + HFP)) || (Horizontal_Count > (HTP - HBP))); 
            Vertical_Sync = ((Vertical_Count < (VAP + VFP)) || (Vertical_Count > (VTP - VBP)));
        end
    end
    
    // Horizontal End of Row Comparator
    // Vertical End of Frame Comparator
    // Video Data Enable Comparators
    always @(*)
    begin
        Horizontal_EOR = (Horizontal_Count == (HTP-1));
        Vertical_EOF = (Vertical_Count == (VTP-1));
        Video_Data_Enable = ((Horizontal_Count < HAP) && (Vertical_Count < VAP));
    end
    
endmodule
