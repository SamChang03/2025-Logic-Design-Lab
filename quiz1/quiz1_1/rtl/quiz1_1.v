module quiz1_1
(
    input [2:0] a,
    input [2:0] b,
    
    output [3:0] square
);

wire [2:0] max,min;

assign max = (a>b) ? a : b;
assign min = (a<b) ? a : b;

assign square = max + (min >> 1);

endmodule