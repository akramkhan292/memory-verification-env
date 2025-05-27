class monitor1;
  virtual intf.monitor vif;
  mailbox mon1scb;
  function new(virtual intf.monitor vif, mailbox mon1scb);
    this.vif = vif;
    this.mon1scb=mon1scb;
  endfunction
  
  task main();
    
    forever begin
      
      transaction trans;
      trans = new();
      @(vif.cb_monitor);
      wait(vif.cb_monitor.rd_en || vif.cb_monitor.wr_en);
      trans.wr_en = vif.cb_monitor.wr_en;
      trans.addr = vif.cb_monitor.addr;
      trans.wdata = vif.cb_monitor.wdata;
      if(vif.cb_monitor.wr_en) @(vif.cb_monitor);
      if(vif.cb_monitor.rd_en) begin
        trans.rd_en = vif.cb_monitor.rd_en;
		@(vif.cb_monitor);
		@(vif.cb_monitor);
      end
      trans.display("MONITOR1");
      
      mon1scb.put(trans);
      
      
    end
    
  endtask
  
endclass

// This class `monitor1` is responsible for monitoring the signals from the DUT (Device Under Test)
// and capturing the transactions that occur. It uses a virtual interface to interact with
// the DUT and a mailbox to send the captured transactions to a scorecard for verification.
// The `main` task runs indefinitely, waiting for transactions to occur. When a transaction
// is detected, it creates a new `transaction` object, captures the relevant signals from
// the virtual interface, and displays the transaction details. The transaction is then
// sent to the scorecard via the `mon1scb` mailbox.