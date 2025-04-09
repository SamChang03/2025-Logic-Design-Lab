module lab01_1_top
(
    input a,
    input b,
    input c,
    input d,
    output w,
    output x,
    output y,
    output z
);

assign w = a| b&d | b&c;
assign x = (~b) & c& d | b & (~c);
assign y = b|c;
assign z = c&d | ~a & ~b & d | ~a&~b&c | a&~c&~d;


endmodule