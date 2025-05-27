class scorecard;
  
  mailbox mon2scb1;
  mailbox mon2scb2;
  int no_transactions;
  reg [15:0] mem [15:0];
  
  function new(mailbox mon2scb1,mailbox mon2scb2);
    this.mon2scb1=mon2scb1;
    this.mon2scb2=mon2scb2;
    foreach(mem[i]) mem[i] = '0;
  endfunction
  
  task main();
    transaction trans1;
    transaction trans2;
    forever begin
      mon2scb1.get(trans1);
      mon2scb2.get(trans2);
      if(trans1.rd_en) begin
        if(mem[trans1.addr]==trans2.rdata) begin
          $display("PASSED!, Addr = %0h rdata = %d memory data = %d",trans1.addr, trans2.rdata, mem[trans1.addr]);
          //trans1.display("Scoreboard from monitor 1");
          //trans2.display("Scoreboard from monitor 2");
        end
        else begin
          $display("FAILED!, Addr = %0h rdata = %d memory data = %d",trans1.addr, trans2.rdata, mem[trans1.addr]);
          //trans1.display("Scoreboard from monitor 1");
          //trans2.display("Scoreboard from monitor 2");
        end
      end
      else if(trans1.wr_en) begin
        mem[trans1.addr]=trans2.wdata;
      end
      else begin
        $display("environment failed");
      end
      $display("scorecard %d",no_transactions);
      no_transactions++;
    end
  endtask
endclass

// This class `scorecard` is responsible for verifying the transactions processed by the monitors.
// It uses two mailboxes to receive transactions from two different monitors.
// The `main` task continuously waits for transactions from both mailboxes, compares the read data
// from the second monitor with the expected data stored in memory, and updates the memory
// when a write operation is detected. If the read data matches the expected data, it prints a
// "PASSED!" message; otherwise, it prints a "FAILED!" message. The `no_transactions` variable
// keeps track of the number of transactions processed, which can be useful for monitoring
// the scoreboard's activity and performance. The memory is implemented as an array of 16 elements,
// initialized to zero, and it is used to store the data written by the first monitor.
// The `transaction` class is used to encapsulate the details of each transaction, including address,
// read/write enable signals, and data. The `display` method formats the transaction information
// for output, allowing for easy debugging and verification of the scoreboard's operations.
// The `mon2scb1` and `mon2scb2` mailboxes are used for communication between the monitors and the scoreboard,
// allowing the scoreboard to receive transactions asynchronously. The `main` task runs indefinitely,
// continuously processing transactions as they are received from the mailboxes.

