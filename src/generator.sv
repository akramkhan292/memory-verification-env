class generator;
  
  rand transaction trans,tr;
  
  mailbox gen2driv;
  
  int repeat_count;
  event ended;
  
  function new(mailbox gen2driv,event ended);
    this.gen2driv=gen2driv;
    this.ended=ended;
    trans = new();
  endfunction
  
  task main();
    repeat(repeat_count)
      begin
        trans.randomize();
        trans.display("Generator");
        tr = trans.do_copy();
        gen2driv.put(tr);
        
      end
    -> ended;
  endtask
endclass

// This class `generator` is responsible for generating random transactions.
// It uses a `mailbox` to send transactions to a driver and an event to signal when
// the generation is complete. The `main` task randomizes the transaction data,
// displays it, and sends a copy of the transaction to the driver via the mailbox.
// The `repeat_count` variable determines how many transactions will be generated.
// The `ended` event is triggered when all transactions have been generated.
// The `transaction` class is used to encapsulate the details of each transaction,
// including address, read/write enable signals, and data. The `display` method formats
// the transaction information for output, and the `do_copy` method creates a copy of
// the transaction object for sending.
// The `mailbox` is used for communication between the generator and the driver,
// allowing the generator to send transactions asynchronously. The `ended` event
// is used to notify other components that the generation process has completed.
// The `rand` keyword indicates that the fields of the `transaction` class can be randomized,
// allowing for a wide variety of transaction scenarios to be generated.  
  