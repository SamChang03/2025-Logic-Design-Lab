module quiz1_2
(
    input clk,
    input rst_n,
    input shift_control,
    input serial_in,
    
    output [3:0] shift_reg_A,
    output [3:0] shift_reg_B
);

reg D_out;
wire D_in, sum, carry;

//shift from high to low
shift_reg reg_A
(
    .clk(clk),
    .rst_n(rst_n),
    .shift_control(shift_control), // 0: no change; 1: shift
    .serial_in(sum), 
    
    .reg_state(shift_reg_A)
);

//shift from high to low
shift_reg reg_B
(
    .clk(clk),
    .rst_n(rst_n),
    .shift_control(shift_control), // 0: no change; 1: shift
    .serial_in(serial_in), 
    
    .reg_state(shift_reg_B)
);

//full adder
FA adder
(
    .x(shift_reg_A[0]),
    .y(shift_reg_B[0]),
    .z(D_out),

    .s(sum),
    .c(carry)
);

//MUX
assign D_in = (shift_control) ? carry : D_out;

//D-FF
always @(posedge clk) begin
    if (~rst_n) begin
        D_out <= 0;
    end
    else begin
        D_out <= D_in;
    end
end
    
endmodule