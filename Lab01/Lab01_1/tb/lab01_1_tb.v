module lab01_1_tb();

wire w,x,y,z;
reg a,b,c,d;

lab01_1_top u0 
(
    .a(a),
    .b(b),
    .c(c),
    .d(d),
    .w(w),
    .x(x),
    .y(y),
    .z(z)
);

initial begin
    a = 0; b = 0; c = 0; d = 0;
    #10 a = 0; b = 0; c = 0; d = 1;
    #10 a = 0; b = 0; c = 1; d = 0;
    #10 a = 0; b = 0; c = 1; d = 1;
    #10 a = 0; b = 1; c = 0; d = 0;
    #10 a = 0; b = 1; c = 0; d = 1;
    #10 a = 0; b = 1; c = 1; d = 0;
    #10 a = 0; b = 1; c = 1; d = 1;
    #10 a = 1; b = 0; c = 0; d = 0;
    #10 a = 1; b = 0; c = 0; d = 1;
end

endmodule