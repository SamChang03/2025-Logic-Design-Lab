module BCD_down
#(
  parameter tens_initial = 5,
  parameter units_initial = 0
)
(
    input clk,
    input rst_n,
    input [1:0] state,

    output reg [3:0] units,
    output reg [3:0] tens,
    output reg Done
);

//state declaration
localparam IDLE = 0;
localparam STOP = 1;
localparam COUNTING = 2;

reg [3:0] units_n, tens_n;
wire stop_counting;

assign stop_counting = (units==0) & (tens == 0);

always @(*) begin
  units_n = units;
  tens_n = tens;
  Done = 0;
  case (state)
    IDLE: begin
      units_n = units_initial;
      tens_n = tens_initial;
    end
    COUNTING: begin
      units_n = (units==0) ? 9 : units-1;
      tens_n = (units==0) ? tens-1 : tens;
      if (stop_counting) begin
        units_n = 0;
        tens_n = 0;
        Done = 1;
      end
    end
    STOP:begin
      units_n = units;
      tens_n = tens;
    end
  endcase
end

always @(posedge clk or negedge rst_n) begin
  if (~rst_n) begin
    units <= units_initial;
    tens <= tens_initial;
  end
  else begin
    units <= units_n;
    tens <= tens_n;
  end
end

endmodule