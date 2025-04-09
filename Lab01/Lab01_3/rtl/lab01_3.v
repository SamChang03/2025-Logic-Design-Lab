module lab01_3
(
    input [3:0] a,
    input [3:0] b,

    output [3:0] o
);

assign o = (a>b)? a : b;

endmodule