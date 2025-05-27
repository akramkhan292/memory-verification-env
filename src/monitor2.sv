class monitor2;
  virtual intf.monitor vif;
  mailbox mon2scb;
  function new(virtual intf.monitor vif, mailbox mon2scb);
    this.vif = vif;
    this.mon2scb=mon2scb;
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
        trans.rdata = vif.cb_monitor.rdata;
      end
      trans.display("MONITOR2");
      
      mon2scb.put(trans);
      
      
    end
    
  endtask
  
endclass
// This class `monitor2` is responsible for monitoring the signals from the DUT (Device Under Test)
