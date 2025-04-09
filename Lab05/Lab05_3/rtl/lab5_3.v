`include "head.v"

module lab5_3
(
    input clk,
    input rst_n, //global reset
    input setting,
    input start_stop_raw,
    input pause_resume_raw,
    input set_min_raw,
    input set_sec_raw,

    output [15:0] LED,
    output [7:0] pattern,
    output [3:0] SSD
);

localparam period_1Hz = 1;
localparam period_10kHz = 10000;
localparam bit_num = 27;
localparam tens_initial = 1;
localparam units_initial = 0;

wire clk_1Hz, clk_10kHz;
wire [`state_bits: 0] state ;
wire done;

///**************** Clock Generators ****************///
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

//10kHz clock generater
clk_gen 
#(
 .period(period_10kHz),
 .bit_num(bit_num)
)
u_clk_10kHz
(
  .clk_in(clk),
  .rst_n(rst_n),

  .clk_out(clk_10kHz)
);

///**************** Input Processing ****************///
input_processing U_input_processing
(
    .clk(clk_10kHz),
    .rst_n(rst_n),
    .start_stop_raw(start_stop_raw),
    .pause_resume_raw(pause_resume_raw), 
    .set_min_raw(set_min_raw), 
    .set_sec_raw(set_sec_raw),

    .start_stop(start_stop),
    .pause_resume(pause_resume), 
    .set_min(set_min), 
    .set_sec(set_sec)
);

///**************** Load_Control ****************///
wire [3:0] load_sec_units, load_sec_tens, load_min_units, load_min_tens;

load_control
#(
  .sec_tens_limit(5),
  .sec_units_limit(9),
  .min_tens_limit(5),
  .min_units_limit(9)
)
U_load_control
(
  .clk(clk_10kHz),
  .rst_n(rst_n), 
  .state(state),
  .set_min(set_min),
  .set_sec(set_sec),
  
  .load_sec_units(load_sec_units),
  .load_sec_tens(load_sec_tens),
  .load_min_units(load_min_units),
  .load_min_tens(load_min_tens)
);

///**************** Timer ****************///
wire [3:0] sec_units, sec_tens, min_units, min_tens;

timer U_timer
(
  .clk_fast(clk_10kHz),
  .clk_slow(clk_1Hz),
  .rst_n(rst_n),
  .state(state),
  .load_sec_units(load_sec_units),
  .load_sec_tens(load_sec_tens),
  .load_min_units(load_min_units),
  .load_min_tens(load_min_tens),

  .sec_units(sec_units),
  .sec_tens(sec_tens),
  .min_units(min_units),
  .min_tens(min_tens),
  .done(done)
);


///**************** Finite State Machine ****************///
FSM U_FSM
(
  .clk(clk_10kHz),
  .rst_n(rst_n),
  .setting(setting),
  .start_stop(start_stop),
  .pause_resume(pause_resume),
  .done(done),

  .state(state)
);

///**************** Output Processing ****************///
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
  .clk(clk_10kHz),
  .rst_n(rst_n), //global reset
  .state(state), // state from FSM
  .in_0(sec_units),
  .in_1(sec_tens),
  .in_2(min_units),
  .in_3(min_tens),
  .LED(LED),

  .pattern(pattern),
  .SSD(SSD)
);

endmodule
