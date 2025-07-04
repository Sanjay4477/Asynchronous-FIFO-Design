module FIFO_MEM # (parameter DATA_SIZE=8,parameter ADDR_SIZE=4)
  (output [DATA_SIZE-1:0] rdata,
   input [DATA_SIZE-1:0] wdata,
   input [ADDR_SIZE-1:0] waddr,raddr,
   input wclk,wfull,wclk_en
  );
  
  localparam DEPTH=1<<ADDR_SIZE;
  
  reg [DATA_SIZE-1:0] mem [0:DEPTH-1];
  
  assign rdata=mem[raddr];
  
  always @ (posedge wclk)
    begin
      if (wclk_en && !wfull)
        mem[waddr]<=wdata;
    end  

endmodule
