module quiz1_2_tb();

localparam period = 2;
localparam test_period = 12;
localparam pattern = 12'b0000_0010_1001;

wire [3:0] golden = pattern[3:0] + pattern[7:4];

reg clk, rst_n, shift_control, serial_in;
wire [3:0] shift_reg_A,shift_reg_B;

quiz1_2 u0
(
    .clk(clk),
    .rst_n(rst_n),
    .shift_control(shift_control),
    .serial_in(serial_in),
    
    .shift_reg_A(shift_reg_A),
    .shift_reg_B(shift_reg_B)
);

always begin
    #(period/2) clk = ~clk;
end

integer test_cnt;

initial begin
    clk = 0;
    rst_n = 0;
    shift_control = 0;
    serial_in = 0;
    test_cnt = 0;

    #(period) rst_n = 1;  shift_control = 1;
    
    while (test_cnt < test_period) begin
        serial_in = pattern[test_cnt];

        #(period) test_cnt = test_cnt + 1;
    end

    if (shift_reg_A === golden) begin
        $display("++++++++++++++++++++++++++");
        $display("+++++ Congradulatoin +++++");
        $display("++++++++++++++++++++++++++");
    end
    else begin
      $display("--------------------------");
      $display("------ Wrong Answer ------");
      $display("--------------------------");
    end

    $finish;
end

endmodule