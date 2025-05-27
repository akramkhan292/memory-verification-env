class transaction;
  rand bit [3:0] addr;
  rand bit rd_en;
  rand bit wr_en;
  rand bit [15:0] wdata;
  bit [15:0] rdata;
  bit [1:0] cnt;
  
  constraint wr_rd_c { rd_en != wr_en; }
  
  
  function display(string name);
    if(wr_en) begin
      $display("==============%s============",name);
      $display("wr_en = %d\naddr = %0h wdata = %d rdata = %d",wr_en,addr,wdata,rdata);
      $display("============================");
    end
    if(rd_en) begin
      $display("==============%s============",name);
      $display("rd_en = %d\naddr = %0h rdata = %d",rd_en,addr,rdata);
      $display("============================");
    end
  endfunction
  
  
  function transaction do_copy();
    transaction trans;
    trans = new();
    trans.addr  = this.addr;
    trans.wr_en = this.wr_en;
    trans.rd_en = this.rd_en;
    trans.wdata = this.wdata;
    return trans;
  endfunction
  
endclass
// This class defines a transaction with fields for address, read/write enable signals,
// and data. It includes a constraint to ensure that only one of the read or write
// operations is enabled at a time. The `display` function formats the transaction data
// for output, and the `do_copy` function creates a copy of the transaction object. 