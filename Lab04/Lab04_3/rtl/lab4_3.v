module lab4_3
(
    input clk,
    input rst_n,

    output [3:0] position,
    output [7:0] pattern
);

localparam period_2Hz = 2;
localparam bit_num = 30;

wire clk_1Hz;
wire [3:0] q;

assign position = 4'b1110;

//1Hz clock generater
clk_gen 
#(
 .period(period_2Hz),
 .bit_num(bit_num)
)
u_clk_1Hz
(
  .clk_in(clk),
  .rst_n(rst_n),

  .clk_out(clk_1Hz)
);

//binary counter
BCD_down u_BCDdown 
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
