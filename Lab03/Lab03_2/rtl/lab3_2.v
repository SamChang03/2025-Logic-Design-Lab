module lab3_2
#(
  parameter period = 1, //default 1Hz period = 1s
  parameter bit_num = 30
)
(
    input clk_in,
    input rst_n,

    output reg clk_out
);

localparam threshold  = 50_000_000 / period;

reg [bit_num-1:0] cnt, cnt_n ;
reg clk_out_n;

//combination
always @(*) begin
    // Default case
    cnt_n = cnt + 1; 
    clk_out_n = clk_out;

    if (cnt == threshold) begin //period = 2* threshold * 10ns = 1s
        cnt_n = 0;
        clk_out_n = ~clk_out;
    end
end

//sequential
always @(posedge clk_in) begin
    if (~rst_n) begin
        cnt <= 0;
        clk_out <= 0;
    end
    else begin
      cnt <= cnt_n;
      clk_out <= clk_out_n;
    end
end

endmodule
