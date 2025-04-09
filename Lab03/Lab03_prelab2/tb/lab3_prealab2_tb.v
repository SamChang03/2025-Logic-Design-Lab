`timescale 1ns / 1ps

module lab3_prelab2_tb();

localparam period = 2;
localparam stoptime = 30*period;
localparam test_num = 16;
localparam DFF_num = 8;

reg clk, rst_n;
reg [4:0] cnt;
reg [4:0] error;
reg [DFF_num-1:0] golden;
wire [DFF_num-1:0] q;

lab3_prelab2 
#(.DFF_num(DFF_num))
u0
(
    .clk(clk),
    .rst_n(rst_n),

    .q(q)
);

always begin
    #(period/2) clk = ~clk;
end

initial begin
    clk = 0;
    rst_n = 0;
    cnt = 0;
    error = 0;
    golden = 8'b01010101;

    #(2*period) rst_n = 1;
    while (cnt < test_num) begin
        @(negedge clk) 
        if (q !== golden) begin
            error = error + 1;
        end
        cnt = cnt + 1;
        golden = ~golden;
    end

    #(period)
    if (error === 0) begin
        $display("############################################");
        $display("### Congraguate All Patterns Are Correct ###");
        $display("############################################");
    end
    else begin
        $display("xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx");
        $display("xxxxxxxxxxxxxxx Wrong Answer xxxxxxxxxxxxxxx");
        $display("xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx");
    end
    $finish;
end

//stop simulation (too long time)
initial begin
    #(stoptime)
    $display("xxx Simulation is too long xxx");
    $finish;
end

endmodule
