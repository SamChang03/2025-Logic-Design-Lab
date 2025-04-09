module lab3_4
(
    input clk,
    input rst_n,

    output [7:0] q
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
shift_reg u_shift_reg 
(
  .clk_in(clk_1Hz),
  .rst_n(rst_n),
  .q(q)
);
endmodule
