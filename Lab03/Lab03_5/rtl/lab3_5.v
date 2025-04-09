`include "head.v"

module lab3_5(
    input clk,
    input rst,    

    output reg [7:0] pattern,
    output reg [3:0] LED
);

reg [7:0]show_1, show_1_n;
reg [7:0]show_2, show_2_n;
reg [7:0]show_3, show_3_n;
reg [7:0]show_4, show_4_n;
reg [9:0] scrolling_pattern, scrolling_pattern_n;

wire clk_1hz;
wire clk_10khz;

clk_1hz U0(.clk_out(clk_1hz),.clk(clk),.rst_n(rst));
clk_10khz U1(.clk_out(clk_10khz),.clk(clk),.rst_n(rst));

//***Rolling Screen***//
always @(*) begin
    //keeping scrolling
    scrolling_pattern_n[0] = scrolling_pattern[9];
    scrolling_pattern_n[9:1] = scrolling_pattern [8:0];

    //determin the pattern
    //default
    show_1_n = 0; show_2_n = 0; show_3_n = 0; show_4_n = 0;

    case(scrolling_pattern)
        10'b0000000001 : begin show_1_n =`SS_N show_2_n =`SS_T show_3_n =`SS_H show_4_n =`SS_U  end
        10'b0000000010 : begin show_1_n =`SS_T show_2_n =`SS_H show_3_n =`SS_U show_4_n =`SS_E  end
        10'b0000000100 : begin show_1_n =`SS_H show_2_n =`SS_U show_3_n =`SS_E show_4_n =`SS_E  end
        10'b0000001000 : begin show_1_n =`SS_U show_2_n =`SS_E show_3_n =`SS_E show_4_n =`SS_2  end
        10'b0000010000 : begin show_1_n =`SS_E show_2_n =`SS_E show_3_n =`SS_2 show_4_n =`SS_0  end
        10'b0000100000 : begin show_1_n =`SS_E show_2_n =`SS_2 show_3_n =`SS_0 show_4_n =`SS_2  end
        10'b0001000000 : begin show_1_n =`SS_2 show_2_n =`SS_0 show_3_n =`SS_2 show_4_n =`SS_3  end
        10'b0010000000 : begin show_1_n =`SS_0 show_2_n =`SS_2 show_3_n =`SS_3 show_4_n =`SS_N  end
        10'b0100000000 : begin show_1_n =`SS_2 show_2_n =`SS_3 show_3_n =`SS_N show_4_n =`SS_T  end
        10'b1000000000 : begin show_1_n =`SS_3 show_2_n =`SS_N show_3_n =`SS_T show_4_n =`SS_H  end
    endcase
    
end

always@(posedge clk_1hz) //change pattern
begin
    if (~rst) begin
        scrolling_pattern <= 10'b0000000001;
        show_1<=0; show_2<=0; show_3<=0; show_4<=0;
    end
    else begin
        scrolling_pattern <= scrolling_pattern_n;
        show_1 <= show_1_n; 
        show_2 <= show_2_n; 
        show_3 <= show_3_n; 
        show_4 <= show_4_n;
    end
end

//***Persistence of vision***//
reg [3:0] LED_n;
reg [7:0] pattern_n;
always @(*) begin
    LED_n[0] = LED[3];
    LED_n[3:1] = LED[2:0];
        
    pattern_n = 0;
    case(LED)
        4'b1110 : pattern_n = show_3;
        4'b1101 : pattern_n = show_2;
        4'b1011 : pattern_n = show_1;
        4'b0111 : pattern_n = show_4;
    endcase
end

always@(posedge clk_10khz)begin
  if (~rst) begin
    LED <= 4'b1110;
  end
  else begin
    LED <= LED_n;
  end

  pattern <=  pattern_n;
end
endmodule
