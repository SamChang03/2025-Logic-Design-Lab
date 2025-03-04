module shift_reg //shift from high to low
(
    input clk,
    input rst_n,
    input shift_control,
    input serial_in, 
    
    output reg [3:0] reg_state
);

wire [3:0] reg_state_n; // next register state

// 0: no change; 1: shift
assign reg_state_n = (shift_control) ? {serial_in, reg_state[3:1]} : reg_state;

always @(posedge clk ) begin
    if (~rst_n) begin
        reg_state <= 0;
    end
    else begin
        reg_state <= reg_state_n;
    end
end

endmodule