module READ_MODULE #(parameter ADDR_SIZE=4)
  (input rclk,rinc,rrst_n,
   input [ADDR_SIZE:0] rq2_wptr,
   output reg rempty,
   output reg [ADDR_SIZE-1:0] raddr,
   output reg [ADDR_SIZE:0] rptr
  );
  
  reg [ADDR_SIZE:0] rbin;
  wire [ADDR_SIZE:0] rgray_next,rbin_next;
  wire rempty_val;
  
  
  always @ (posedge rclk or negedge rrst_n)
    begin
      
      if (!rrst_n)
      {rbin,rptr}<=0;
      else
      {rbin,rptr}<={rbin_next,rgray_next};
      
    end
  
  assign raddr=rbin[ADDR_SIZE-1:0];
  assign rbin_next=rbin+(rinc & ~rempty);
  assign rgray_next=(rbin_next>>1)^(rbin_next);
  
  assign rempty_val= (rgray_next==rq2_wptr);
  
  always @ (posedge rclk or negedge rrst_n)
    begin
      
      if (!rrst_n)
        rempty<=1'b1;
      else
        rempty<=rempty_val;
      
    end
  
  
endmodule
