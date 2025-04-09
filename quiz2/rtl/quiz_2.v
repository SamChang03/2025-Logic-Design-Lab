`include "head.v"

module quiz_2
(
    input clk,
    input rst_n, //global reset
    input reset,
    input load_rotate_raw,
    input [2:0] DIP, //DIP -> pattern

    output [7:0] pattern,
    output [3:0] SSD
);

localparam period_1Hz = 1;
localparam period_10Hz = 10;
localparam period_10kHz = 10000;
localparam bit_num = 27;

wire clk_1Hz, clk_10Hz;
wire load_rotate_debounced, load_rotate_onepulse;
wire reset_debounced, reset_onepulse;
wire [1:0] state;
wire [3:0] tens, units;
wire [7:0] DIP_decoded;
wire [2:0] load_position;

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

//10Hz clock generater
clk_gen 
#(
 .period(period_10Hz),
 .bit_num(bit_num)
)
u_clk_10Hz
(
  .clk_in(clk),
  .rst_n(rst_n),

  .clk_out(clk_10Hz)
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

//One_pulse
one_pulse U_op_control
(
  .clk(clk_10Hz),  // clock input
  .rst_n(rst_n), //active low reset
  .button_in(load_rotate_raw), // input trigger
  .out_pulse(load_rotate_onepulse) // output one pulse 
);
one_pulse U_op_reset
(
  .clk(clk_10Hz),  // clock input
  .rst_n(rst_n), //active low reset
  .button_in(reset), // input trigger
  .out_pulse(reset_onepulse) // output one pulse 
);

//FSM
FSM U_FSM
(
  .clk(clk_10Hz),
  .rst_n(~reset_onepulse & rst_n ),
  .load_rotate(load_rotate_onepulse),

  .state(state),
  .load_position(load_position)
);
//DIP Decoder
DIP_decoder U_decoder
(
  .DIP(DIP),
  .DIP_decoded(DIP_decoded)
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
  .clk(clk_10kHz),
  .clk_slow(clk_1Hz),
  .rst_n(rst_n), //global reset
  .state(state), // state from FSM
  .load_position(load_position),
  .code_in(DIP_decoded),

  .pattern(pattern),
  .SSD(SSD)
);
endmodule
