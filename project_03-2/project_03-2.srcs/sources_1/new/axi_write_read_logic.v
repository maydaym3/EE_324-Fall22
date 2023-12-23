`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/06/2022 09:38:19 PM
// Design Name: 
// Module Name: axi_write_read_logic
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


module axi_write_read_logic(
    // Global inputs
    input           axi_clk,
    input           axi_aresetn,
    // Write Address Channel
    input [1:0]    axi_awaddr,
    input           axi_awvalid,
    output reg      axi_awready,
    // Write Data Channel
    input [31:0]    axi_wdata,
    input           axi_wvalid,
    output reg      axi_wready,
    // Write Response Channel
    output reg [1:0]axi_bresp,
    output reg      axi_bvalid,
    input           axi_bready,
    // Read Address Channel
    input [1:0]     axi_araddr,
    input           axi_arvalid,
    output reg      axi_arready,
    // Read Data Channel
    output reg[31:0]axi_rdata,
    output reg      axi_rresp,
    output reg      axi_rvalid,
    input           axi_rready,
    
    //Additional Ports
    output reg[3:0]led,
    output reg[5:0]rgb_led
    );
    
    // registers   
    
    reg aw_en;
    reg [1:0] write_addr_latch;
    reg [1:0] read_addr_latch;
    reg [31:0] data_out;
    reg [31:0] reg0;
    reg [31:0] reg1;
    reg [31:0] reg2;
    reg [31:0] reg3;
    wire write_enable;
    wire read_enable;
    
    // Write Address Handshake
    always @(posedge axi_clk)
        begin
            if(~axi_aresetn)
                begin
                    axi_awready <= 1'b0;
                    aw_en <= 1'b1;
                end
            else
                begin
                    if(~axi_awready && axi_awvalid && axi_wvalid && aw_en)
                        begin
                            axi_awready <=1'b1;
                            aw_en <=1'b0;
                        end
                    else if(axi_bready && axi_bvalid)
                        begin
                            axi_awready <=1'b0;
                            aw_en <=1'b1;
                        end
                    else
                        axi_awready <=1'b0;
                end    
        end
        
    // Write Data Handshake
    always @(posedge axi_clk)
        begin
            if(~axi_aresetn)
                begin
                   write_addr_latch <=0;
                end
            else
                begin
                    if(~axi_awready && axi_awvalid && axi_wvalid && aw_en)
                        begin
                            write_addr_latch <= axi_awaddr;
                        end
                end
        end
           
    // Write Response Handshake
    always @(posedge axi_clk)
        begin
            if(~axi_aresetn)
                begin
                    axi_bvalid <= 1'b0;
                    axi_bresp <= 2'b0;
                end
            else
                begin
                    if(axi_awready && axi_awvalid && ~axi_bvalid && axi_wready && axi_wvalid )
                        begin
                            axi_bvalid <=1'b1;
                            axi_bresp <=2'b0;
                        end
                    else
                        begin
                            axi_bvalid <= 1'b0;
                        end
                end    
        end 
    
    // Write Latching Logic
    assign write_enable = axi_wready && axi_wvalid && axi_awready && axi_awvalid;
    always @(posedge axi_clk)
        begin
            if(~axi_aresetn)
                begin
                    reg0 <=0;
                    reg1 <=0;
                    reg2 <=0;
                    reg3 <=0;
                end
            else
                begin
                    if(write_enable)
                        begin
                            case(write_addr_latch)
                                2'h0 :  reg0 <= axi_wdata;
                                2'h1 :  reg1 <= axi_wdata;
                                2'h2 :  reg2 <= axi_wdata;
                                2'h3 :  reg3 <= axi_wdata;
                            endcase
                        end
                end
        end
    
    // Read Address Handshake
    always @(posedge axi_clk)
        begin
            if(~axi_aresetn )
                begin
                    axi_arready <= 1'b0;
                    read_addr_latch <= 2'b0;
                end
            else
                begin
                    if(~axi_arready && axi_arvalid)
                        begin
                            axi_arready <=1'b1;
                            read_addr_latch <= axi_araddr;
                        end
                    else
                        begin
                            axi_arready <= 1'b0;
                        end
                end                
        end
    
    // Read Data Handshake
    always @(posedge axi_clk)
        begin
            if(~axi_aresetn)
                begin
                    axi_rvalid <= 1'b0;
                    axi_rresp <= 2'b0;
                end
            else
                begin
                    if(axi_arready && axi_arvalid && ~axi_rready )
                        begin
                            axi_rvalid <= 1'b1;
                            axi_rresp <= 2'b0;
                        end
                    else if(axi_rvalid && axi_rready)
                        begin
                            axi_rvalid <= 1'b0;
                        end
                end
        end
        
    // Read Latching logic
    assign read_enable = axi_arready & axi_arvalid & ~axi_rvalid;
    always @(*)
        begin
            case (read_addr_latch)
                2'h0    : data_out <= reg0;
                2'h1    : data_out <= reg1;
                2'h2    : data_out <= reg2;
                2'h3    : data_out <= reg3;
                default : data_out <=0;
            endcase
        end
    
            
    always @(posedge axi_clk)
        begin
            if(~axi_aresetn)
                begin
                    axi_rdata <= 32'b0;
                end
            else
                begin
                    if(read_enable)
                        axi_rdata <= data_out;
                end
        end
        
    //Additional Logic 
    always @(*)
        begin
            led <= reg0[3:0];
            rgb_led <= reg1[5:0]; 
        end
    
endmodule
