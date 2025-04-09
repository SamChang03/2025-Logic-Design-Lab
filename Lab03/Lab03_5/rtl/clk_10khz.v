module clk_10khz
(
    output reg clk_out,

    input clk,
    input rst_n
);
    

reg [25:0] cnt, cnt_n ;
reg clk_out_n;

//combination
always @(*) begin
    // Default case
    cnt_n = cnt + 1; 
    clk_out_n = clk_out;

    if (cnt == 26'd5_000) begin //period = 2*5K * (10)ns
        cnt_n = 0;
        clk_out_n = ~clk_out;
    end
end

//sequential
always @(posedge clk) begin
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
