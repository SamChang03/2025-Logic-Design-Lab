module one_pulse(
  input clk,
  input rst_n,
  input in_trig,
  
  output reg out_pulse
);

wire in_debounced;

debounce_circuit U0(.clk(clk), .rst_n(rst_n), .pb_in(in_trig), .pb_debounced(in_debounced));

// internal registers
reg out_next;
reg in_debounced_delay;

always @(*) begin
  out_next = in_debounced & ~in_debounced_delay;
end

always @(posedge clk or negedge rst_n) begin
  if (~rst_n) begin
    out_pulse <= 1'b0; 
    in_debounced_delay <= 1'b0; 
  end 
  else begin
    out_pulse <= out_next;
    in_debounced_delay <= in_debounced;
  end
end

endmodule