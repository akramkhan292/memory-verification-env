`include "transaction.sv"
`include "generator.sv"
`include "driver.sv"
`include "monitor1.sv"
`include "monitor2.sv"
`include "scorecard.sv"

class environment;
  generator gen;
  driver driv;
  monitor1 mon1;
  monitor2 mon2;
  scorecard scb;
  
  mailbox gen2driv;
  mailbox mon2scb1;
  mailbox mon2scb2;
  
  event gen_ended;
  
  virtual intf vif;
  
  function new(virtual intf vif);
    this.vif=vif;
    
    gen2driv = new();
    mon2scb1 = new();
    mon2scb2 = new();
    
    gen = new(gen2driv,gen_ended);
    driv = new(vif.driver,gen2driv);
    mon1 = new(vif.monitor,mon2scb1);
    mon2 = new(vif.monitor,mon2scb2);
    scb = new(mon2scb1,mon2scb2);
    
  endfunction
  
  task test();
    fork
      gen.main();
      driv.main();
      mon1.main();
      mon2.main();
      scb.main();
    join_any
  endtask
  
  task post_test();
    wait(gen_ended.triggered);
    wait(gen.repeat_count == driv.no_transactions);
    wait(gen.repeat_count == scb.no_transactions);
  endtask
  
  task run();
    test();
    post_test();
    $finish;
  endtask
  
endclass
// This `environment` class orchestrates the entire testbench setup.
// It initializes the generator, driver, monitors, and scorecard,
// and manages the flow of the testbench execution. The `run` method
// starts the test by invoking the `test` task, which runs all components
// concurrently. The `post_test` task ensures that all components have
// completed their operations and that the expected conditions are met,
// such as the number of transactions generated matching those processed
// by the driver and scorecard. The `gen2driv`, `mon2scb1`, and `mon2scb2`
// mailboxes facilitate communication between the generator and driver,
// and between the monitors and scorecard, respectively. The `gen_ended`
// event signals when the generator has finished producing transactions.
// The `vif` (virtual interface) is used to interact with the DUT,
// allowing the driver and monitors to send and receive signals
// in a synchronized manner.