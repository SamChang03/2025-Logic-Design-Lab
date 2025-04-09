`include "head.v"

module SSD_controller
#(
  parameter show_0_rst = 0, 
  parameter show_1_rst = 0,
  parameter show_2_rst = 0,
  parameter show_3_rst = 0
)
(
    input clk,
    input clk_slow,
    input rst_n, //global reset
    input [1:0] state, // state from FSM
    input [7:0] code_in,
    input [2:0] load_position, //set as a pointer

    output reg [7:0] pattern,
    output reg [3:0] SSD
);

reg [7:0] input_register [0:7];
reg [7:0] input_register_n [0:7];

reg [7:0] pattern_n;
reg [3:0] SSD_n;
reg [2:0] show_pnt, show_pnt_n; // Show SSD pointer
reg [2:0] rotate_cnt, rotate_cnt_n;

//********** Register Configuration **********//
integer i;
always @(*) begin
  //Default Case: Register remain the same
  for ( i=0 ; i<8 ; i=i+1 ) begin
    input_register_n[i] = input_register[i];
  end

  if (state == `LOAD) begin
    input_register_n[7-load_position] = code_in; // Load the code from high to low <- (7-load position)
  end
end

//Sequential for Register
always @(posedge clk or negedge rst_n) begin
  if (~rst_n) begin
    for ( i=0 ; i<8 ; i=i+1 ) begin
      input_register[i] <= `SS_0;
    end
  end
  else begin
    for ( i=0 ; i<8 ; i=i+1 ) begin
      input_register[i] <= input_register_n[i];
    end
  end
end

//********** SSD Control **********//
wire [2:0] position;
assign position = show_pnt + rotate_cnt;

always @(*) begin
  pattern_n = input_register[show_pnt];
  SSD_n = 4'b0000;
  show_pnt_n = 0;
  rotate_cnt_n = 0;
  case (state)
    `IDLE: begin
      pattern_n = `SS_0;
      SSD_n = 4'b0000;
      show_pnt_n = 0;
    end 
    `LOAD: begin
      if (load_position<4) begin
        show_pnt_n = (show_pnt == 4) ? 7 : show_pnt - 1 ; //Load and Show the first 4 char (NTHU)
      end
      else begin
        show_pnt_n = (show_pnt == 0) ? 3 : show_pnt - 1 ; //Load and Show the last 4 char (EECS)
      end

      case (show_pnt) // Consistent Showing
        0: SSD_n = 4'b1110;
        1: SSD_n = 4'b1101;
        2: SSD_n = 4'b1011;
        3: SSD_n = 4'b0111;
        4: SSD_n = 4'b1110;
        5: SSD_n = 4'b1101;
        6: SSD_n = 4'b1011;
        7: SSD_n = 4'b0111;
      endcase
    end
    `ROTATE: begin
      rotate_cnt_n = rotate_cnt - 1; // Roll from left to right
      show_pnt_n = show_pnt + 1;

      case (show_pnt)
        0: begin SSD_n = 4'b1110; pattern_n = input_register[position]; end
        1: begin SSD_n = 4'b1101; pattern_n = input_register[position]; end
        2: begin SSD_n = 4'b1011; pattern_n = input_register[position]; end
        3: begin SSD_n = 4'b0111; pattern_n = input_register[position]; end
        4: begin SSD_n = 4'b1110; pattern_n = input_register[position+4]; end //Should be the same as case: 0
        5: begin SSD_n = 4'b1101; pattern_n = input_register[position+4]; end //Should be the same as case: 1
        6: begin SSD_n = 4'b1011; pattern_n = input_register[position+4]; end //Should be the same as case: 2
        7: begin SSD_n = 4'b0111; pattern_n = input_register[position+4]; end //Should be the same as case: 3
      endcase
    end
  endcase
end

always @(posedge clk or negedge rst_n) begin
  if (~rst_n) begin
    pattern = `SS_0;
    SSD = 4'b0000;
    show_pnt = 0;
  end
  else begin
    pattern = pattern_n;
    SSD = SSD_n;
    show_pnt = show_pnt_n;
  end
end

always @(negedge clk_slow) begin
  if(~rst_n)begin
    rotate_cnt <= 0;
  end
  else begin
    rotate_cnt <= rotate_cnt_n;
  end
end

endmodule
