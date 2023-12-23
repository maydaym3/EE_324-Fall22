`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/03/2022 11:42:57 PM
// Design Name: 
// Module Name: axi_mapped_registers
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


module axi_mapped_registers(

input axi_clk,
input axi_resetn,

input [31:0] axi_write_data,
input write_data_valid,
output write_data_ready,

input [1:0] axi_write_addr,
input write_addr_valid,
output write_addr_ready,

output [1:0] axi_write_resp,
input write_resp_ready,
output write_resp_valid,

input read_addr_valid,
output read_addr_ready,
input [1:0] axi_read_addr,

output read_data_valid,
input read_data_ready,
output [31:0] axi_read_data,
output [1:0] axi_read_resp,

output [3:0] led,
output [5:0] rgb_led
);

    //four registers
    reg [31:0] rfile[3:0];
    
    wire [1:0] wraddr;
    wire [31:0] rdata_in;
    wire write_en;

axi_write_read_logic(
    .axi_clk(axi_clk),
    .axi_aresetn(axi_resetn),
    .axi_awaddr(axi_write_addr),
    .axi_awvalid(write_addr_valid),
    .axi_awready(write_data_ready),
    .axi_wdata(axi_write_data),
    .axi_wvalid(write_data_valid),
    .axi_wready(write_data_ready),
    .axi_bresp(axi_write_resp),
    .axi_bvalid(write_resp_valid),
    .axi_bready(write_resp_ready),
    .axi_araddr(axi_read_addr),
    .axi_arvalid(read_addr_valid),
    .axi_arready(read_addr_ready),
    .axi_rdata(axi_read_data),
    .axi_rresp(axi_read_resp),
    .axi_rvalid(read_data_valid),
    .axi_rready(read_data_ready),
    .led(led),
    .rgb_led(rgb_led)
); 

integer i;

    always @(posedge axi_clk)
    begin
        if(~axi_resetn)
        begin
            for(i=0;i<4;i=i+1)
                rfile[i]<=0;
        end
        else if(write_en)
            rfile[wraddr] <= rdata_in;
    end
    


endmodule




