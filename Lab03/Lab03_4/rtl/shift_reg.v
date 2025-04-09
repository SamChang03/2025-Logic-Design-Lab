module shift_reg #(
  parameter DFF_num = 8
)
(
  input clk_in,
  input rst_n,

  output reg [DFF_num-1:0] q
);

wire [DFF_num-1:0] q_n = q + 1;

integer  i;
always @(posedge clk_in) begin
    if (~rst_n) begin
      q <= 8'b01010101;
    end
    else begin
      q[0] <= q[DFF_num-1];
      for ( i=0 ; i< DFF_num-1 ; i=i+1 ) begin
        q[i+1] <= q[i];
      end   
    end
end

endmodule
