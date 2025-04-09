`include "head.v"
module DIP_decoder //Look-up Table
(
    input [2:0] DIP,

    output reg [7:0] DIP_decoded
);

//Look-up Table Here
always @(*) begin
  DIP_decoded = `SS_0;
  case (DIP)
    3'd0: DIP_decoded = `SS_N;
    3'd1: DIP_decoded = `SS_T;
    3'd2: DIP_decoded = `SS_H;
    3'd3: DIP_decoded = `SS_U;
    3'd4: DIP_decoded = `SS_E;
    3'd5: DIP_decoded = `SS_C;
    3'd6: DIP_decoded = `SS_S;
  endcase
end

endmodule