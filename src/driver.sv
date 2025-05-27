class driver;
  mailbox gen2driv;
  virtual intf.driver vif;
  int no_transactions;
  function new(virtual intf.driver vif, mailbox gen2driv);
    this.vif = vif;
    this.gen2driv=gen2driv;
  endfunction
  
  task main();
    transaction trans;
    forever begin
      gen2driv.get(trans);
      @(vif.cb_driver);
      vif.cb_driver.addr <= trans.addr;
      if(trans.wr_en) begin
        vif.cb_driver.wr_en <= trans.wr_en;
        vif.cb_driver.wdata <= trans.wdata;
        @(vif.cb_driver);
        vif.cb_driver.wr_en <= 0;
      end
      if(trans.rd_en) begin
        vif.cb_driver.rd_en <= trans.rd_en;
	    @(vif.cb_driver);
        vif.cb_driver.rd_en <= 0;
        @(vif.cb_driver);
        trans.rdata = vif.cb_driver.rdata;
      end
      trans.display("DRIVER");
      no_transactions++;
      
    end
  endtask
  
endclass
// This class `driver` is responsible for receiving transactions from a generator
// and executing them. It uses a `mailbox` to receive transactions and a virtual interface
// to interact with the DUT (Device Under Test). The `main` task continuously waits for
// transactions from the mailbox, processes them, and updates the virtual interface
// accordingly. It handles both read and write operations, ensuring that the appropriate
// signals are set and cleared at the correct times. The `no_transactions` variable
// keeps track of the number of transactions processed. The `transaction` class is used
// to encapsulate the details of each transaction, including address, read/write enable signals,
// and data. The `display` method formats the transaction information for output, allowing
// for easy debugging and verification of the driver's operations. The `vif` (virtual interface)
// is used to interact with the DUT, allowing the driver to send and receive signals
// in a synchronized manner. The `cb_driver` clocking block is used to define the timing
// for the driver's operations, ensuring that the signals are sampled and driven at the correct clock edges.
// The `gen2driv` mailbox is used for communication between the generator and the driver,
// allowing the driver to receive transactions asynchronously. The `main` task runs indefinitely,
// continuously processing transactions as they are received from the mailbox.
// The `transaction` class is used to encapsulate the details of each transaction,
// including address, read/write enable signals, and data. The `display` method formats
// the transaction information for output, allowing for easy debugging and verification
// of the driver's operations. The `no_transactions` variable keeps track of the number
// of transactions processed, which can be useful for monitoring the driver's activity
// and performance. The `vif` (virtual interface) is used to interact with the DUT,
