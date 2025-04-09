`include "head.v"

module SSD_controller
#(
  parameter show_0_rst = 0, // Shows in reset state
  parameter show_1_rst = 0,
  parameter show_2_rst = 0,
  parameter show_3_rst = 0
)
(
    input clk,
    input rst_n, //global reset
    input [1:0] state, // state from FSM
    input [3:0] in_0,
    input [3:0] in_1,
    input [3:0] in_2,
    input [3:0] in_3,

    output reg [7:0] pattern,
    output reg [3:0] SSD,
    output [15:0] LED
);

reg [7:0] pattern_n;
reg [3:0] SSD_n;
reg [7:0] show_0, show_1, show_2, show_3;
reg [7:0] show_0_n, show_1_n, show_2_n, show_3_n;

assign LED = (in_0 == 0 & in_1==0 & in_2==0 & in_3 ==0 & state ==`STOP ) ? ~(16'd0) : 16'd0 ;

//SSD decoder
always @(*) begin
  show_0_n = 0;
  show_1_n = 0;
  show_2_n = 0;
  show_3_n = 0;

  case (in_0)
    0: show_0_n = `SS_0;
    1: show_0_n = `SS_1;
    2: show_0_n = `SS_2;
    3: show_0_n = `SS_3;
    4: show_0_n = `SS_4;
    5: show_0_n = `SS_5;
    6: show_0_n = `SS_6;
    7: show_0_n = `SS_7;
    8: show_0_n = `SS_8;
    9: show_0_n = `SS_9;
  endcase

  case (in_1)
    0: show_1_n = `SS_0;
    1: show_1_n = `SS_1;
    2: show_1_n = `SS_2;
    3: show_1_n = `SS_3;
    4: show_1_n = `SS_4;
    5: show_1_n = `SS_5;
    6: show_1_n = `SS_6;
    7: show_1_n = `SS_7;
    8: show_1_n = `SS_8;
    9: show_1_n = `SS_9;
  endcase

  case (in_2)
    0: show_2_n = `SS_0;
    1: show_2_n = `SS_1;
    2: show_2_n = `SS_2;
    3: show_2_n = `SS_3;
    4: show_2_n = `SS_4;
    5: show_2_n = `SS_5;
    6: show_2_n = `SS_6;
    7: show_2_n = `SS_7;
    8: show_2_n = `SS_8;
    9: show_2_n = `SS_9;
  endcase

  case (in_3)
    0: show_3_n = `SS_0;
    1: show_3_n = `SS_1;
    2: show_3_n = `SS_2;
    3: show_3_n = `SS_3;
    4: show_3_n = `SS_4;
    5: show_3_n = `SS_5;
    6: show_3_n = `SS_6;
    7: show_3_n = `SS_7;
    8: show_3_n = `SS_8;
    9: show_3_n = `SS_9;
  endcase
end


//SSD main control
always @(*) begin
  pattern_n = 0;
  SSD_n = 0;
  case (SSD)
    4'b1110: begin
      SSD_n = 4'b1101;
      pattern_n = show_1;
    end
    4'b1101: begin
      SSD_n = 4'b1011;
      pattern_n = show_2;
    end
    4'b1011: begin
      SSD_n = 4'b0111;
      pattern_n = show_3;
    end
    4'b0111: begin
      SSD_n = 4'b1110;
      pattern_n = show_0;
    end
    default: begin
      SSD_n = 4'b1110;
      pattern_n = show_0;
    end 
  endcase
end

always @(posedge clk or negedge rst_n) begin
  if (~rst_n) begin
    pattern <= 0;
    SSD <= 4'b0000;
    show_0 <= show_0_rst;
    show_1 <= show_1_rst;
    show_2 <= show_2_rst;
    show_3 <= show_3_rst;
  end
  else begin
    pattern <= pattern_n;
    SSD <= SSD_n;
    show_0 <= show_0_n;
    show_1 <= show_1_n;
    show_2 <= show_2_n;
    show_3 <= show_3_n;
  end
  
end

endmodule
