`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/06/2022 05:01:35 PM
// Design Name: 
// Module Name: axi_testbench
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


module axi_testbench();

	//clock and reset_n signals
	reg aclk =1'b0;
	reg arstn = 1'b0;

	
	//Write Address channel (AW)
	reg [31:0] write_addr =32'd0;	//Master write address
	reg [2:0] write_prot = 3'd0;	//type of write(leave at 0)
	reg write_addr_valid = 1'b0;	//master indicating address is valid
	wire write_addr_ready;		//slave ready to receive address

	//Write Data Channel (W)
	reg [31:0] write_data = 32'd0;	//Master write data
	reg [3:0] write_strb = 4'd0;	//Master byte-wise write strobe
	reg write_data_valid = 1'b0;	//Master indicating write data is valid
	wire write_data_ready;		//slave ready to receive data

	//Write Response Channel (WR)
	reg write_resp_ready = 1'b0;	//Master ready to receive write response
	wire [1:0] write_resp;		//slave write response
	wire write_resp_valid;		//slave response valid
	
	//Read Address channel (AR)
	reg [31:0] read_addr = 32'd0;	//Master read address
	reg [2:0] read_prot =3'd0;	//type of read(leave at 0)
	reg read_addr_valid = 1'b0;	//Master indicating address is valid
	wire read_addr_ready;		//slave ready to receive address

	//Read Data Channel (R)
	reg read_data_ready = 1'b0;	//Master indicating ready to receive data
	wire [31:0] read_data;		//slave read data
	wire [1:0] read_resp;		//slave read response
	wire read_data_valid;		//slave indicating data in channel is valid

	//LED output of the IPcore
	wire [3:0] LED; 
	
	axi_mapped_registers axi_inst(
	
	.axi_clk(aclk),
	.axi_resetn(arstn),
	
	.axi_write_data(write_data),
	.write_data_valid(write_data_valid),
	.write_data_ready(write_data_ready),
	
	.axi_write_addr(write_addr),
	.write_addr_valid(write_addr_valid),
	.write_addr_ready(write_addr_ready),
	
	.axi_write_resp(write_resp),
	.write_resp_valid(write_resp_valid),
	.write_resp_ready(write_resp_ready),
	
	.axi_read_addr(read_addr),
	.read_addr_valid(read_addr_valid),
	.read_addr_ready(read_addr_ready),
	
	.axi_read_data(read_data),
	.read_data_valid(read_data_valid),
	.read_data_ready(read_data_ready),
	
	.axi_read_resp(read_resp),
	
	.led(LED)
	
	);

    always
        #5 aclk <=~aclk;

    integer i;
    initial 
    begin
        arstn = 0;
        i=0;
        #20 arstn=1;
        for(i=0;i<=32'hF;i=i+1)
            #20 axi_write(32'd0,i);
            $finish;
    end    
    
    task axi_write;
    input [31:0]addr;
    input [31:0] data;
    begin
        #3write_addr <=addr;
        write_data <=data;
        write_addr_valid <= 1'b1;
        write_data_valid <= 1'b1;
        write_resp_ready <= 1'b1;
        write_strb <= 4'hF;
        
        //wait for one slave ready signal or the other
        wait(write_data_ready || write_addr_ready);
        
        @(posedge aclk);
        if(write_data_ready&&write_addr_ready)
        begin
            write_addr_valid<=0;
            write_data_valid<=0;
        end 
        else
        begin
            if(write_data_ready)
            begin
                write_data_valid<=0;
                wait(write_addr_ready);
            end
            else if(write_addr_ready)
            begin
                write_addr_valid<=0;
                wait(write_data_ready);
            end
            @ (posedge aclk);
            write_addr_valid<=0;
            write_data_valid<=0;
        end
        
        write_strb<=0;
        
        wait(write_resp_valid);
        
        @(posedge aclk);
        write_resp_ready<=0;      
    end
    endtask
    
    
endmodule
