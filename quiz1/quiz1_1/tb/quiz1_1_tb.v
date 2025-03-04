module quiz1_1_tb();

wire [3:0] square;
reg [2:0] a,b;

quiz1_1 u0 
(
    .a(a),
    .b(b),
    
    .square(square)
);

integer cnt;

initial begin
    a = 0;
    b = 0;
    cnt = 0;

    while (cnt < 65) begin
        #10 {a,b} = cnt;
        cnt = cnt + 1;
    end
    $finish;

end

endmodule