`include "head.v"

module binary_to_SSD(
    input [3:0] q,    

    output reg [7:0] pattern
);

always @(*) begin
    case (q)
        4'd0: pattern = `SS_0
        4'd1: pattern = `SS_1
        4'd2: pattern = `SS_2
        4'd3: pattern = `SS_3
        4'd4: pattern = `SS_4
        4'd5: pattern = `SS_5
        4'd6: pattern = `SS_6
        4'd7: pattern = `SS_7
        4'd8: pattern = `SS_8
        4'd9: pattern = `SS_9
        4'd10: pattern = `SS_a
        4'd11: pattern = `SS_b
        4'd12: pattern = `SS_c
        4'd13: pattern = `SS_d
        4'd14: pattern = `SS_e
        4'd15: pattern = `SS_f
        default: pattern = `SS_N
    endcase
end

endmodule
