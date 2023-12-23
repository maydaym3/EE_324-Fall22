`timescale 1ns/1ps

module axi_read_logic(
	input axi_clk,
	input aresetn, //axi is reset low
    
    //read address channel
    input arvalid,
    output reg arready,
    input [31:0] araddr,
    
    //read data channel
    output reg rvalid,
    input rready,
    output reg [31:0] rdata,
    output reg [1:0] rresp
);
    
    
    //flip flops for latching data
    reg [31:0] data_latch;
    reg [1:0] addr_latch;

    wire read_enable;
    
    //read address handshake
    // axi_read_ready
    always @(posedge axi_clk)
    
    begin
        if(aresetn==1'b0)
            begin
                arready <=1'b0;
                addr_latch <=32'b0;
            end
        else
            begin
                if(~arready && arvalid )
                    begin
                        arready <=1'b1;
                        addr_latch <=araddr;
                    end
                else
                    begin
                        arready <= 1'b0;
                    end
            end                   
    end
        
    //read data handshake
    //axi_read_valid
    always @(posedge axi_clk )
    begin
        if(aresetn==1'b0)
            begin
                rvalid <= 1'b0;
                rresp  <= 2'b0;
            end
        else
            begin
                if (arready && arvalid && ~rvalid)
                    begin
                        rvalid <=1'b1;
                        rresp  <=2'b0;
                    end
                else if (rvalid && rready)
                    begin
                        rvalid <= 1'b0;
                    end
            end    
    end

  
    
    //latching logic
    always @(*)
    begin
        case(araddr)
            2'h0 :  data_latch <= 32'b0;
            2'h1 :  data_latch <= 32'b1;
            2'h2 :  data_latch <= 32'b10;
            2'h3 :  data_latch <= 32'b11;
        endcase
    end
    
    
    assign read_enable = arready & arvalid & ~rvalid;
    always @(posedge axi_clk)
    begin
        if (aresetn==1'b0)
            begin
                rdata <= 32'b0;
            end
        else
            begin
                if(read_enable)
                    begin
                        rdata <= data_latch;
                    end
            end    
    end
        

endmodule