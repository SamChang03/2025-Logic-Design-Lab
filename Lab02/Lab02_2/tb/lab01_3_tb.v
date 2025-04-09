`timescale 1ns/1ps
module lab01_3_tb();

reg [3:0] a,b;
wire [3:0] o;

lab01_3 u0 
(
    .a(a),
    .b(b),

    .o(o)
);

integer i,j;
initial begin
    a = 0; b = 0;
    for (i = 0; i< 15; i = i+1) begin
        for (j = 0 ; j< 15 ; j=j+1 ) begin
            #10 a = a +1 ; b = b;
        end
        #10 a = a; b = b + 1; 
    end
end

initial begin
    if (a===15 & b===15) begin
        $finish;
    end
end

endmodule