// Code your testbench here
// or browse Examples
`include "test.sv"
`include "interface.sv"

module memory_tb;
  
  logic clk;
  logic reset;
  intf mem_intf(clk);
  
  initial clk = 0;
  
  //clock generation
  always #5 clk = ~clk;
  
  //reset Generation
  initial begin
    mem_intf.reset = 1;
    #5 mem_intf.reset =0;
  end
  
  
  test mem_test(mem_intf);
  
  memory mem_dut(.clk(mem_intf.clk),
                 .reset(mem_intf.reset),
                 .addr(mem_intf.addr),
                 .rd_en(mem_intf.rd_en),
                 .wr_en(mem_intf.wr_en),
                 .wdata(mem_intf.wdata),
                 .rdata(mem_intf.rdata)
                );
  initial begin
    $dumpfile("dmp.vcd");
    $dumpvars();
  end
  
endmodule