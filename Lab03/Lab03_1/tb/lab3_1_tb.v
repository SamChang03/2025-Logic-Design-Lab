`timescale 1ns / 1ps

module lab3_1_tb();

localparam period = 2;
localparam stoptime = 30*period;
localparam bits_num = 27;

reg clk_in, rst_n;
wire clk_out;

lab3_1
#(
 .bits_num(bits_num)
)
u0
(
    .clk_in(clk_in),
    .rst_n(rst_n),

    .clk_out(clk_out)
);

always begin
    #(period/2) clk_in = ~clk_in;
end

initial begin
    clk_in = 0;
    rst_n = 0;

    #(period) rst_n = 1;
end

//stop simulation (too long time)
initial begin
    #(stoptime)
    $display("xxx Simulation is too long xxx");
    $finish;
end

endmodule
