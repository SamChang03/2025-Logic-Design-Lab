`include "head.v"

module lab5_2
(
    input clk,
    input rst_n, //global reset
    input lap_reset_raw,
    input pause_start_raw,

    output [7:0] pattern,
    output [3:0] SSD
);

localparam period_1Hz = 1;
localparam period_10kHz = 10000;
localparam bit_num = 27;

wire clk_1Hz, clk_100Hz;
wire pause_start_debounced, pause_start_onepulse;
wire lap_reset_debounced, lap_reset_onepulse;
wire [1:0] state;
wire [3:0] sec_tens, sec_units, min_tens, min_units;

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

//100Hz clock generater
clk_gen 
#(
 .period(period_10kHz),
 .bit_num(bit_num)
)
u_clk_100Hz
(
  .clk_in(clk),
  .rst_n(rst_n),

  .clk_out(clk_100Hz)
);

//Debounce
debounce_circuit U_dc_control
(
  .clk(clk_100Hz), // clock control
  .rst_n(rst_n), // reset
  .pb_in(pause_start_raw), //push button input
  .pb_debounced(pause_start_debounced) // debounced push button output
);
debounce_circuit U_dc_reset
(
  .clk(clk_100Hz), // clock control
  .rst_n(rst_n), // reset
  .pb_in(lap_reset_raw), //push button input
  .pb_debounced(lap_reset_debounced) // debounced push button output
);

//One_pulse
one_pulse U_op_control
(
  .clk(clk_100Hz),  // clock input
  .rst_n(rst_n), //active low reset
  .in_trig(pause_start_debounced), // input trigger
  .out_pulse(pause_start_onepulse) // output one pulse 
);
one_pulse U_op_reset
(
  .clk(clk_100Hz),  // clock input
  .rst_n(rst_n), //active low reset
  .in_trig(lap_reset_debounced), // input trigger
  .out_pulse(lap_reset_onepulse) // output one pulse 
);

//BCD counter
stopwatch
#(
  .sec_tens_limit(),
  .sec_units_limit(),
  .min_tens_limit(),
  .min_units_limit()
)
U_stopwatch
(
  .clk(clk_1Hz),
  .rst_n(rst_n),
  .state(state),

  .sec_units(sec_units),
  .sec_tens(sec_tens),
  .min_units(min_units),
  .min_tens(min_tens)
);
//FSM
FSM U_FSM
(
  .clk(clk_100Hz),
  .rst_n(rst_n),
  .lap_reset(lap_reset_onepulse),
  .pause_start(pause_start_onepulse),

  .state(state)
);
//SSD
SSD_controller
#(
  .show_0_rst(),
  .show_1_rst(),
  .show_2_rst(),
  .show_3_rst()
)
u_SSD
(
  .clk(clk_100Hz),
  .rst_n(rst_n), //global reset
  .state(state), // state from FSM
  .in_0(sec_units),
  .in_1(sec_tens),
  .in_2(min_units),
  .in_3(min_tens),

  .pattern(pattern),
  .SSD(SSD)
);

endmodule
