interface intf(input logic clk);
  logic reset;
  logic rd_en;
  logic wr_en;
  
  logic [3:0] addr;
  logic [15:0] wdata;
  logic [15:0] rdata;
  
  clocking cb_driver @(posedge clk);
    default input #1 output #1;
    output wr_en, rd_en, addr, wdata;
    input rdata;
  endclocking
  
  clocking cb_monitor @(posedge clk);
    default input #1 output #1;
    input wr_en, rd_en, addr, wdata, rdata;
  endclocking
  
  modport driver (clocking cb_driver, input clk,reset);
  modport monitor (clocking cb_monitor, input clk,reset);

endinterface
// This interface defines the communication protocol for a transaction system.
// It includes signals for read and write operations, address, and data.
// The clocking blocks define the timing for driver and monitor operations.
// The `driver` modport is used for driving signals, while the `monitor` modport    

