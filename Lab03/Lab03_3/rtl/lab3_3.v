module lab3_03
(
    input clk,
    input rst_n,

    output [3:0] q
);

localparam period_1Hz = 1;
localparam bit_num = 30;

wire clk_1Hz;

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
binary_counter u_bycnt 
(
  .clk_in(clk_1Hz),
  .rst_n(rst_n),
  .q(q)
);
endmodule
