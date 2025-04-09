module one_pulse(
  clk,  // clock input
  rst_n, //active low reset
  button_in, // input trigger
  out_pulse // output one pulse 
);

// Declare I/Os
input clk;  // clock input
input rst_n; //active low reset
input button_in; // input trigger
output out_pulse; // output one pulse 
reg out_pulse; // output one pulse 

// Declare internal nodes
reg button_out_delay;
wire button_out;

debounce_circuit U_dc_reset
(
  .clk(clk), // clock control
  .rst_n(rst_n), // reset
  .pb_in(button_in), //push button input
  .pb_debounced(button_out) // debounced push button output
);

// Buffer input 
always @(posedge clk or negedge rst_n)
  if (~rst_n)
    button_out_delay <= 1'b0; 
  else
    button_out_delay <= button_out;

// Pulse generation
assign out_pulse_next = button_out & (~button_out_delay);

always @(posedge clk or negedge rst_n)
  if (~rst_n)
    out_pulse <=1'b0;
  else
    out_pulse <= out_pulse_next;

endmodule