`include "FIFO_MEM.sv"
`include "TWO_FF_SYNC.sv"
`include "READ_MODULE.sv"
`include "WRITE_MODULE.sv"

module FIFO_TOP #(parameter DATA_SIZE=8,parameter ADDR_SIZE=4)
  (input [DATA_SIZE-1:0] wdata,
   input wclk,winc,wrst_n,
   input rclk,rinc,rrst_n,
   output [DATA_SIZE-1:0] rdata,
   output wfull,rempty
  );
  
  wire [ADDR_SIZE-1:0] waddr,raddr;
  wire [ADDR_SIZE:0] wptr,rptr,wq2_rptr,rq2_wptr;
  
  TWO_FF_SYNC #(ADDR_SIZE+1) R2W(
    .q2(wq2_rptr),
    .din(rptr),
    .clk(wclk),
    .rst_n(wrst_n)
  );
  
  TWO_FF_SYNC #(ADDR_SIZE+1) W2R(
    .q2(r2q_wptr),
    .din(wptr),
    .clk(rclk),
    .rst_n(rrst_n)
  );
  
  FIFO_MEM #(DATA_SIZE,ADDR_SIZE) MEM(
    .rdata(rdata),
    .wdata(wdata),
    .waddr(waddr),
    .raddr(raddr),
    .wclk_en(winc),
    .wfull(wfull),
    .wclk(wclk)
  );
  
  READ_MODULE #(ADDR_SIZE) rptr_empty(
    .rempty(rempty),
    .raddr(raddr),
    .rptr(rptr),
    .rq2_wptr(rq2_wptr),
    .rinc(rinc),
    .rclk(rclk),
    .rrst_n(rrst_n)
  );
  
  WRITE_MODULE #(ADDR_SIZE) wptr_empty(
    .wfull(wfull),
    .waddr(waddr),
    .wptr(wptr),
    .wq2_rptr(wq2_rptr),
    .winc(winc),
    .wclk(wclk),
    .wrst_n(wrst_n)
  );
  
  
endmodule
