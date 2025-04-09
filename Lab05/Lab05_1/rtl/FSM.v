module FSM
(
    input clk,
    input rst_n,
    input pause_start,

    output reg [1:0] state
);

localparam IDLE = 0;
localparam STOP = 1;
localparam COUNTING = 2;

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
        end
        STOP: begin
          if (pause_start) begin
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
