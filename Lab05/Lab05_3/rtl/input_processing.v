module input_processing

(
    input clk,
    input rst_n,
    input start_stop_raw,
    input pause_resume_raw, 
    input set_min_raw, 
    input set_sec_raw,

    output start_stop,
    output pause_resume, 
    output set_min, 
    output set_sec
);

one_pulse U_op_start_stop
(
  .clk(clk),  // clock input
  .rst_n(rst_n), //active low reset
  .in_trig(start_stop_raw), // input trigger
  .out_pulse(start_stop) // output one pulse 
);
one_pulse U_op_pause_resume
(
  .clk(clk),  // clock input
  .rst_n(rst_n), //active low reset
  .in_trig(pause_resume_raw), // input trigger
  .out_pulse(pause_resume) // output one pulse 
);
one_pulse U_op_set_min
(
  .clk(clk),  // clock input
  .rst_n(rst_n), //active low reset
  .in_trig(set_min_raw), // input trigger
  .out_pulse(set_min) // output one pulse 
);
one_pulse U_op_set_sec
(
  .clk(clk),  // clock input
  .rst_n(rst_n), //active low reset
  .in_trig(set_sec_raw), // input trigger
  .out_pulse(set_sec) // output one pulse 
);

endmodule