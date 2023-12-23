`timescale 1ns/1ps

module axi_write_logic(
	input axi_clk,
	input aresetn, //axi is reset low


	//write address channel
	input [1:0] awaddr,
	input awvalid,
	output reg awready,


	//write data channel
	input [31:0] wddata ,
	input wdvalid,
	output reg wdready,

	//write response channel	
	output [1:0] bresp,
	input bready,
	output reg bvalid,


	
	output [31:0] data_out, //data output to external logic
	output [1:0] addr_out, //address output to external logic
	output data_valid		//signal indicating output data and address are valid
);


	reg addr_done;
	reg data_done;
    

	//flip flops for latching data
	reg [31:0] data_latch;
	reg [1:0] addr_latch;
    
    wire write_enable;
    reg write_en;

	assign data_out = data_latch;
	assign addr_out = addr_latch;

	assign data_valid = data_done & addr_done;

	assign bresp = 2'd0; //always indicate OKAY status for writes

	//write address handshake
	//axi_write_ready
	always @(posedge axi_clk)
	begin
	   if (aresetn==1'b0)
	   begin
	       awready <= 1'b0;
	       write_en <=1'b1;
	   end
	   else
	       begin
	       if (~awready && awvalid && wdvalid && write_en)
	           begin
	               awready <=1'b1;
	               write_en <=1'b0;
	           end
	       else if(bready && bvalid)
	           begin
	               awready <=1'b0;
	               write_en <=1'b1;
	           end
	       else
	           begin
	               awready <= 1'b0;
	           end
	       end
	       
	       
	end

	//write data handshake
	//axi_write_ready
	always @(posedge axi_clk)
	begin
	   if (aresetn==1'b0)
	       begin
	           wdready <= 1'b0;
	       end
	   else
	       begin
	           if(~wdready && wdvalid && awvalid && write_en)
	               begin
	                   wdready <=1'b1;
	               end
	           else
	               begin
	                   wdready <=1'b0;
	               end
	       end
	end
	
	//keep track of which handshakes completed
	always @(posedge axi_clk)
	begin
		if(~aresetn || (addr_done & data_done) ) //reset or both phases done
		begin
			addr_done<=0;
			data_done<=0;
		end
		else
		begin	

			if(awvalid & awready) //look for addr handshake
				addr_done<=1;
		
			if(wdvalid & wdready) //look for data handshake
				data_done<=1;	
		end
	end

	//latching logic
	always @(posedge axi_clk)
	begin
		if(aresetn==0)
		begin
			data_latch<=32'd0;
			addr_latch<=2'd0;
		end
		else
		begin
			if(wdvalid & wdready) //look for data handshake
				data_latch<=wddata;
			
			if(awvalid & awready)
				addr_latch<=awaddr;
		end
	end


	//write response logic
	always @(posedge axi_clk)
	begin	
		if( ~aresetn | (bvalid & bready) )
			bvalid<=0;
		else if(~bvalid & (data_done & addr_done) )
			bvalid<=1;	
	end



endmodule