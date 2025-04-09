module binary_counter
(
    input clk_in,
    input rst_n,

    output reg [3:0] q
);

wire [3:0] q_n = q + 1;

always @(posedge clk_in) begin
    if (~rst_n) begin
      q <= 4'b0000;
    end
    else begin
      q <= q_n;
    end
end

endmodule
