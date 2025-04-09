`include "head.v"
module BCD_down
#(
  parameter limit = 9
)
(
    input clk_fast, // for load
    input clk_slow, // for 1Hz down counter
    input rst_n,
    input carry_in,
    input [3:0] load_in, // number from 0 to 9
    input [`state_bits:0] state,
    
    output reg [3:0] output_num,
    output carry_out
);

reg [`state_bits:0] state_n;
reg [3:0] output_num_n;
reg [3:0] output_num_load, output_num_counting;
wire [3:0] output_num_load_n, output_num_counting_n;

assign output_num_counting_n = (state != `COUNTING) ? output_num : 
        (carry_in) ? ((output_num == 0) ? limit : output_num - 1) : output_num ; 

assign output_num_load_n = load_in;
assign carry_out = (carry_in & (output_num == 0));

always @(*) begin
  output_num_n = output_num;
  if (state == `SETTING) begin
    output_num_n = output_num_load;
  end
  else if (state == `COUNTING) begin
    output_num_n = output_num_counting;
  end
end

always @(posedge clk_fast) begin
  if (~rst_n) begin
    output_num <= 0;
    output_num_load <= 0;
  end
  else begin
    output_num <= output_num_n;
    output_num_load <= output_num_load_n;
  end
end

always @(posedge clk_slow) begin
  if (~rst_n) begin
    output_num_counting <= 0;
  end
  else begin
    output_num_counting <= output_num_counting_n;
  end
end

endmodule