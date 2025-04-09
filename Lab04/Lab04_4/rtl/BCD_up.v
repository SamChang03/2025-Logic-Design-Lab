module BCD_up
(
    input clk_in,
    input rst_n,
    input carry_in,
    input mode, // 0: driven by clk ; 1:driven by previos bit

    output reg [3:0] q,
    output carry_out
);

reg [3:0] q_n;

assign carry_out = (q == 4'd9);

always @(*) begin
  q_n = q;
  if (mode) begin
    q_n = (carry_in) ? ((q == 4'd9)? 4'd0 : q+1 ): q;
  end
  else begin
    q_n = (q == 4'd9) ? 4'd0 : q+1 ;
  end
end

always @(posedge clk_in) begin
    if (~rst_n) begin
      q <= 4'b0000;
    end
    else begin
      q <= q_n;
    end
end

endmodule