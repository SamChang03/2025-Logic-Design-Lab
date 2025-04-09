module FSM
(
    input clk,
    input rst_n,
    input pause_start,
    input lap_reset,

    output reg [1:0] state
);

localparam IDLE = 0;
localparam COUNTING = 1;
localparam STOP = 2;
localparam FREEZE = 3;

reg [1:0] state_n;

always @(*) begin
    state_n = state;
    case (state)
        IDLE: begin
          if (pause_start) begin
            state_n = COUNTING;
          end
        end
        COUNTING: begin
          if (pause_start) begin
            state_n = STOP;
          end
          else if (lap_reset) begin
            state_n = FREEZE;
          end
        end
        STOP: begin
          if (pause_start) begin
            state_n = COUNTING;
          end
          else if (lap_reset) begin
            state_n = IDLE;
          end
        end
        FREEZE: begin
          if (lap_reset) begin
            state_n = COUNTING;
          end
        end
    endcase
end

always @(posedge clk or negedge rst_n) begin
    if (~rst_n) begin
        state <= IDLE;
    end
    else begin
      state <= state_n;
    end
end

endmodule
