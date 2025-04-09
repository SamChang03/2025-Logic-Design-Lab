module lab4_4
(
    input clk,
    input rst_n,

    output reg [3:0] position,
    output [7:0] pattern,
    output carry //for debugging
);

localparam period_1Hz = 1;
localparam period_10KHz = 10_000;
localparam bit_num = 30;

wire clk_1Hz,clk_10KHz;
wire [3:0] q_high, q_low;
wire [7:0] pattern_high, pattern_low;

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

//10KHz clock generater
clk_gen 
#(
 .period(period_10KHz),
 .bit_num(bit_num)
)
u_clk_10KHz
(
  .clk_in(clk),
  .rst_n(rst_n),

  .clk_out(clk_10KHz)
);

//BCD counter_high
BCD_up u_BCDdown_high
(
  .clk_in(clk_1Hz),
  .rst_n(rst_n),
  .carry_in(carry),
  .mode(1), // 0: driven by clk ; 1:driven by previos bit
 
  .q(q_high),
  .carry_out()
);

//BCD counter_low
BCD_up u_BCDdown_low
(
  .clk_in(clk_1Hz),
  .rst_n(rst_n),
  .carry_in(0),
  .mode(0), // 0: driven by clk ; 1:driven by previos bit

  .q(q_low),
  .carry_out(carry)
);

binary_to_SSD u_by2SSD_high
(
  .q(q_high),
  .pattern(pattern_high)
);

binary_to_SSD u_by2SSD_low
(
  .q(q_low),
  .pattern(pattern_low)
);

//SSD controll logic
reg [3:0] position_n;

assign pattern = (position == 4'b1110) ? pattern_low : pattern_high ;

always @(*) begin
  position_n = 4'b0000; // default
  if (position == 4'b1101) begin
    position_n = 4'b1110;
  end
  else if (position == 4'b1110) begin
    position_n =  4'b1101;
  end
end

always @(posedge clk_10KHz) begin
  if (~rst_n) begin
    position <= 4'b1101;
  end
  else begin
    position <= position_n;
  end
end
endmodule
