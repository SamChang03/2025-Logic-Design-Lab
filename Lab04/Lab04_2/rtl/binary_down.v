module binary_down
(
    input clk_in,
    input rst_n,

    output reg [3:0] q
);

wire [3:0] q_n = q - 1;

always @(posedge clk_in) begin
    if (~rst_n) begin
      q <= 4'b1111;
    end
    else begin
      q <= q_n;
    end
end

endmodule