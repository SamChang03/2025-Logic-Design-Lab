module lab4_2
(
    input clk,
    input rst_n,

    output [3:0] position,
    output [7:0] pattern
);

localparam period_1Hz = 1;
localparam bit_num = 30;

wire clk_1Hz;
wire [3:0] q;

assign position = 4'b1110;

//1Hz clock generater
clk_gen 
#(
 .period(period_1Hz),
 .bit_num(bit_num)
)
u_clk_1Hz
(
  .clk_in(clk),
  .rst_n(rst_n),

  .clk_out(clk_1Hz)
);

//binary counter
binary_down u_bydown 
(
  .clk_in(clk_1Hz),
  .rst_n(rst_n),
  .q(q)
);

binary_to_SSD u_by2SSD
(
  .q(q),
  .pattern(pattern)
);
endmodule
