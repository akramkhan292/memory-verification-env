// Code your design here
module memory 
  #(
  parameter ADDR_WIDTH=4,
  parameter DATA_WIDTH=16
  )
  (
    input clk,
    input reset,
    
    input [ADDR_WIDTH-1:0] addr,
    input rd_en,
    input wr_en,
    
    input [DATA_WIDTH-1:0] wdata,
    output logic [DATA_WIDTH-1:0] rdata
  );
  
  reg [DATA_WIDTH-1:0] mem [2**ADDR_WIDTH];
  
  always @(posedge clk) begin
    if(reset) begin
      foreach ( mem[i]) begin
        mem[i] <= '0;
      end
    end
    else begin
      if(wr_en) begin
        mem [addr] <= wdata;
      end
      if(rd_en) begin
        rdata <= mem [addr];
      end
    end
  end
endmodule
// This module implements a simple memory system with read and write capabilities.
// It uses a parameterized address and data width, allowing for flexible memory sizes.
// The memory is implemented as a register array, and it supports synchronous reset.
// The `clk` input is used to synchronize the read and write operations.
// The `addr` input specifies the address for read/write operations, while `rd_en` and `wr_en`
// signals control the read and write operations, respectively. The `wdata` input is used
// for writing data to the memory, and the `rdata` output provides the data read from the memory.
// The memory is initialized to zero on reset, and the read data is updated on the rising edge of the clock.
// The memory module is designed to be simple and efficient, suitable for use in various applications
// where a small memory is needed. It can be easily integrated into larger systems
// and can be extended or modified to support additional features such as error checking,
// multi-port access, or different data types. The use of parameters allows for easy customization
// of the memory size and data width, making it adaptable to different requirements.