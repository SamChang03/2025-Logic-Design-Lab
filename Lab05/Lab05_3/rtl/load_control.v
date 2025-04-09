`include "head.v"

module load_control
#(
  parameter sec_tens_limit = 5,
  parameter sec_units_limit = 9,
  parameter min_tens_limit = 5,
  parameter min_units_limit = 9
)
(
    input clk,
    input rst_n, //global reset
    input [`state_bits:0] state, // state from FSM
    input set_min,
    input set_sec,

    output reg [3:0] load_sec_units,
    output reg [3:0] load_sec_tens,
    output reg [3:0] load_min_units,
    output reg [3:0] load_min_tens
);

reg [3:0] load_sec_units_n,load_sec_tens_n,
          load_min_units_n,load_min_tens_n;

wire sec_units_touch, min_units_touch;

assign sec_units_touch = (load_sec_units == sec_units_limit);
assign min_units_touch = (load_min_units == min_units_limit);

always @(*) begin
  load_sec_units_n = load_sec_units;
  load_sec_tens_n = load_sec_tens;
  load_min_units_n = load_min_units;
  load_min_tens_n = load_min_tens;
  case (state)
    `IDLE: begin
      load_sec_units_n = 0;
      load_sec_tens_n = 0;
      load_min_units_n = 0;
      load_min_tens_n = 0;
    end 
    `SETTING: begin
      load_sec_units_n = (set_sec) ? ((sec_units_touch) ? 0 : load_sec_units+1 ): load_sec_units ;
      load_sec_tens_n = (set_sec & sec_units_touch ) ? ((load_sec_tens == sec_tens_limit) ? 0 : load_sec_tens+1 ): load_sec_tens ;
      load_min_units_n = (set_min) ? ((min_units_touch) ? 0 : load_min_units+1 ): load_min_units ;
      load_min_tens_n = (set_min & min_units_touch ) ? ((load_min_tens == min_tens_limit) ? 0 : load_min_tens+1 ): load_min_tens ;
    end
  endcase
  
end

always @(posedge clk) begin
  if (~rst_n) begin
    load_sec_units <= 0;
    load_sec_tens <= 0;
    load_min_units <= 0;
    load_min_tens <= 0;
  end
  else begin
    load_sec_units <= load_sec_units_n;
    load_sec_tens <= load_sec_tens_n;
    load_min_units <= load_min_units_n;
    load_min_tens <= load_min_tens_n;
  end
end

endmodule
