module WRITE_MODULE #(parameter ADDR_SIZE=4)
  (input winc,wclk,wrst_n,
   input [ADDR_SIZE:0] wq2_rptr,
   output reg wfull,
   output [ADDR_SIZE-1:0] waddr,
   output reg [ADDR_SIZE:0] wptr
  );
  
  reg [ADDR_SIZE:0] wbin;
  wire [ADDR_SIZE:0] wgray_next,wbin_next;
  wire wfull_val;
  
  always @ (posedge wclk or negedge wrst_n)
    begin
      
      if (!wrst_n)
      {wbin,wptr}<=0;
      else
      {wbin,wptr}<={wbin_next,wgray_next};
      
    end
  
  assign waddr=wbin[ADDR_SIZE-1:0];
  assign wbin_next=wbin + (winc & ~wfull);
  assign wgray_net=(wbin_next>>1)^(wbin_next);
  
  assign wfull_val=(wgray_next=={~wq2_rptr[ADDR_SIZE:ADDR_SIZE-1],wq2_rptr[ADDR_SIZE-2:0]}); 
  
  always @ (posedge wclk or negedge wrst_n)
    begin
      
      if (!wrst_n)
        wfull<=0;
      else
        wfull<=wfull_val;
      
    end
  
endmodule
