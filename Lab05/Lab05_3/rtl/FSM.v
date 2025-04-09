`include "head.v"

module FSM
(
    input clk,
    input rst_n,
    input setting, // 1:setting; 0: no change
    input start_stop,
    input pause_resume,
    input done,

    output reg [`state_bits:0] state
);

reg [`state_bits:0] state_n;

always @(*) begin
    state_n = (done) ? `STOP :state;
    case (state)
      `IDLE: begin
        if (setting) begin
          state_n = `SETTING;
        end
      end
      `SETTING: begin
        if (~setting) begin
          state_n = `IDLE;
        end
        else if(start_stop) begin
          state_n = `COUNTING;
        end
      end
      `COUNTING: begin
        if (start_stop) begin
          state_n = `SETTING;
        end
        else if (pause_resume) begin
          state_n = `STOP;
        end
      end
      `STOP: begin
        if (start_stop) begin
          state_n = `SETTING;
        end
        else if (pause_resume) begin
          state_n = `COUNTING;
        end
      end
    endcase
end

always @(posedge clk or negedge rst_n) begin
    if (~rst_n) begin
        state <= `IDLE;
    end
    else begin
      state <= state_n;
    end
end

endmodule
