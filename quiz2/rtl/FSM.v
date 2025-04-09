`include "head.v"

module FSM
(
    input clk,
    input rst_n,
    input load_rotate,

    output reg [1:0] state,
    output reg [2:0] load_position
);

reg [1:0] state_n;
reg [2:0] load_position_n;

always @(*) begin
  state_n = state;
  load_position_n = load_position;
  case (state)
    `IDLE: begin
      if (load_rotate) begin
        state_n = `LOAD;
        load_position_n = 0;
      end
    end
    `LOAD: begin
      if(load_rotate) begin
        state_n = (load_position == 3'd7) ? `ROTATE : `LOAD;
        load_position_n = load_position + 1; 
      end
    end 
    `ROTATE: begin
      load_position_n = 0;
    end
  endcase
end


always @(posedge clk or negedge rst_n) begin
    if (~rst_n) begin
        state <= `IDLE;
        load_position <= 0;
    end
    else begin
      state <= state_n;
      load_position <= load_position_n;
    end
end

endmodule
