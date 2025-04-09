`include "head.v"

module stopwatch
#(
  parameter sec_tens_limit = 5,
  parameter sec_units_limit = 9,
  parameter min_tens_limit = 5,
  parameter min_units_limit = 9
)
(
    input clk,
    input rst_n,
    input [1:0] state,

    output reg [3:0] sec_units,
    output reg [3:0] sec_tens,
    output reg [3:0] min_units,
    output reg [3:0] min_tens
);

reg [3:0] sec_units_n, sec_tens_n, min_units_n, min_tens_n;
wire stop_counting;
wire sec_unit_touch, sec_tens_touch, min_unit_touch, min_tens_touch;

assign sec_tens_touch = (sec_tens == sec_tens_limit); // touch the limit
assign sec_unit_touch = (sec_units == sec_units_limit); // touch the limit
assign min_tens_touch = (min_tens == min_tens_limit); // touch the limit
assign min_unit_touch = (min_units == min_units_limit); // touch the limit

assign stop_counting = sec_tens_touch & sec_unit_touch & min_tens_touch & min_unit_touch;

always @(*) begin
  sec_units_n = sec_units;
  sec_tens_n = sec_tens;
  min_units_n = min_units;
  min_tens_n = min_tens;
  case (state)
    `IDLE: begin
      sec_units_n = 0;
      sec_tens_n = 0;
      min_units_n = 0;
      min_tens_n = 0;
    end
    `COUNTING: begin
      //Default
      sec_units_n = sec_unit_touch ? 0 : sec_units+1;
      sec_tens_n = sec_unit_touch ? sec_tens_touch ? 0 : sec_tens+1 : sec_tens;
      min_units_n = (sec_tens_touch & sec_unit_touch) ? min_unit_touch ? 0 : min_units+1 : min_units;
      min_tens_n = (min_unit_touch & sec_tens_touch & sec_unit_touch) ? min_tens_touch ? 0 : min_tens+1 : min_tens;

      if (stop_counting) begin
        sec_units_n = sec_units_limit;
        sec_tens_n = sec_tens_limit;
        min_units_n = min_units_limit;
        min_tens_n = min_tens_limit;
      end
    end
    `FREEZE: begin //Same as COUNTING
      //Default
      sec_units_n = sec_unit_touch ? 0 : sec_units+1;
      sec_tens_n = sec_unit_touch ? sec_tens_touch ? 0 : sec_tens+1 : sec_tens;
      min_units_n = (sec_tens_touch & sec_unit_touch) ? min_unit_touch ? 0 : min_units+1 : min_units;
      min_tens_n = (min_unit_touch & sec_tens_touch & sec_unit_touch) ? min_tens_touch ? 0 : min_tens+1 : min_tens;

      if (stop_counting) begin
        sec_units_n = sec_units_limit;
        sec_tens_n = sec_tens_limit;
        min_units_n = min_units_limit;
        min_tens_n = min_tens_limit;
      end
    end
    `STOP:begin
      sec_units_n = sec_units;
      sec_tens_n = sec_tens;
      min_units_n = min_units;
      min_tens_n = min_tens;
    end
  endcase
end

always @(posedge clk or negedge rst_n) begin
  if (~rst_n) begin
    sec_units <= 0;
    sec_tens <= 0;
    min_units <= 0;
    min_tens <= 0;
  end
  else begin
    sec_units <= sec_units_n;
    sec_tens <= sec_tens_n;
    min_units <= min_units_n;
    min_tens <= min_tens_n;
  end
end

endmodule