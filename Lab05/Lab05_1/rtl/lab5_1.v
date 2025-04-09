`include "head.v"

module lab5_1
(
    input clk,
    input rst_n, //global reset
    input reset,
    input pause_start_raw,

    output Done,
    output reg [7:0] pattern,
    output reg [3:0] SSD
);

localparam period_1Hz = 1;
localparam period_100Hz = 100;
localparam bit_num = 27;
localparam tens_initial = 1;
localparam units_initial = 0;

wire clk_1Hz, clk_100Hz;
wire pause_start_debounced, pause_start_onepulse;
wire reset_debounced, reset_onepulse;
wire [1:0] state;
wire [3:0] tens, units;

reg [7:0] show_tens, show_units;

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
 .period(period_100Hz),
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
  .pb_in(~reset), //push button input
  .pb_debounced(reset_debounced) // debounced push button output
);

//One_pulse
one_pulse U_op_control
(
  .clk(clk_1Hz),  // clock input
  .rst_n(rst_n), //active low reset
  .in_trig(pause_start_debounced), // input trigger
  .out_pulse(pause_start_onepulse) // output one pulse 
);
one_pulse U_op_reset
(
  .clk(clk_1Hz),  // clock input
  .rst_n(rst_n), //active low reset
  .in_trig(reset_debounced), // input trigger
  .out_pulse(reset_onepulse) // output one pulse 
);

//BCD counter
BCD_down
#(
  .tens_initial(tens_initial),
  .units_initial(units_initial)
)
U_BCD_Down
(
  .clk(clk_1Hz),
  .rst_n(~reset_onepulse & rst_n ),
  .state(state),

  .units(units),
  .tens(tens),
  .Done(Done)
);
//FSM
FSM U_FSM
(
  .clk(clk_1Hz),
  .rst_n(~reset_onepulse & rst_n ),
  .pause_start(pause_start_onepulse),

  .state(state)
);
// *** SSD Controller ***//
//SSD
always @(posedge clk_100Hz or negedge rst_n) begin
  if (~rst_n) begin
    SSD <= 4'b1100;
    pattern <= 0;
  end
  else begin
    SSD <= (SSD == 4'b1101) ? 4'b1110 : 4'b1101;
    pattern <= (SSD == 4'b1101) ? show_units : show_tens; 
  end
end
//Pattern
always @(*) begin
  show_tens = 0;
  show_units = 0 ;

  case (tens)
    0: show_tens = `SS_0;
    1: show_tens = `SS_1;
    2: show_tens = `SS_2;
    3: show_tens = `SS_3;
    4: show_tens = `SS_4;
    5: show_tens = `SS_5;
    6: show_tens = `SS_6;
    7: show_tens = `SS_7;
    8: show_tens = `SS_8;
    9: show_tens = `SS_9;
  endcase

  case (units)
    0: show_units = `SS_0;
    1: show_units = `SS_1;
    2: show_units = `SS_2;
    3: show_units = `SS_3;
    4: show_units = `SS_4;
    5: show_units = `SS_5;
    6: show_units = `SS_6;
    7: show_units = `SS_7;
    8: show_units = `SS_8;
    9: show_units = `SS_9;
  endcase
end
endmodule
