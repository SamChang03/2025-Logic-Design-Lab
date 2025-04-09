module lab3_1
#(
  parameter bits_num = 27
)
(
  input clk_in,
  input rst_n,

  output clk_out
);

reg [bits_num-1:0] register;
wire [bits_num-1:0] register_n;

assign clk_out = register[bits_num-1];
assign register_n = register + 1;

always @(posedge clk_in) begin
  if (~rst_n) begin
    register <= 0;
  end
  else begin
    register <= register_n;
  end
end

endmodule
