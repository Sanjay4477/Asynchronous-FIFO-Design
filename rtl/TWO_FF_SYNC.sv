module TWO_FF_SYNC #(parameter SIZE=4)
  (output reg[SIZE-1:0] q2,
   input clk,rst_n,
   input [SIZE-1:0] din
  );
  
  reg [SIZE-1:0] q1;
  
  always @ (posedge clk or negedge rst_n)
    begin
      
      if (!rst_n)
      {q2,q1}<=0;
      else
      {q2,q1}<={q1,din};
      
    end
  
endmodule
