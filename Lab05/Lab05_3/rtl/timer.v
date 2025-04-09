`include "head.v"
module timer
#(
  parameter sec_tens_initial = 5,
  parameter sec_units_initial = 9,
  parameter min_tens_initial = 5,
  parameter min_units_initial = 9
)
(
    input clk_fast,
    input clk_slow,
    input rst_n,
    input [1:0] state,
    input [3:0] load_sec_units,
    input [3:0] load_sec_tens,
    input [3:0] load_min_units,
    input [3:0] load_min_tens,

    output [3:0] sec_units,
    output [3:0] sec_tens,
    output [3:0] min_units,
    output [3:0] min_tens,
    output done
);

wire carry_sec_units_2_tens, carry_tens_2_units, carry_min_units_2_tens;
assign done = (sec_units==0 & sec_tens==0 & min_units==0 & min_tens==0 & state[1] == 1'd1);

BCD_down
#(
  .limit(sec_units_initial)
)
U_BCD_sec_units
(
  .clk_fast(clk_fast),
  .clk_slow(clk_slow),
  .rst_n(rst_n),
  .carry_in(1'b1),
  .load_in(load_sec_units),
  .state(state),

  .output_num(sec_units),
  .carry_out(carry_sec_units_2_tens)
);

BCD_down
#(
  .limit(sec_tens_initial)
)
U_BCD_sec_tens
(
  .clk_fast(clk_fast),
  .clk_slow(clk_slow),
  .rst_n(rst_n),
  .carry_in(carry_sec_units_2_tens),
  .load_in(load_sec_tens),
  .state(state),

  .output_num(sec_tens),
  .carry_out(carry_tens_2_units)
);

BCD_down
#(
  .limit(min_units_initial)
)
U_BCD_min_units
(
  .clk_fast(clk_fast),
  .clk_slow(clk_slow),
  .rst_n(rst_n),
  .carry_in(carry_tens_2_units),
  .load_in(load_min_units),
  .state(state),

  .output_num(min_units),
  .carry_out(carry_min_units_2_tens)
);

BCD_down
#(
  .limit(min_tens_initial)
)
U_BCD_min_tens
(
  .clk_fast(clk_fast),
  .clk_slow(clk_slow),
  .rst_n(rst_n),
  .carry_in(carry_min_units_2_tens),
  .load_in(load_min_tens),
  .state(state),

  .output_num(min_tens),
  .carry_out()
);

endmodule