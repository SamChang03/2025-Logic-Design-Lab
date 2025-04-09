module lab02_2
(
    input [3:0] i,

    output [3:0] d,
    output reg [7:0] SSD
);
localparam  symble_0 = 8'b0000_0011;
localparam  symble_1 = 8'b1001_1111;
localparam  symble_2 = 8'b0010_0101;
localparam  symble_3 = 8'b0000_1101;

localparam  symble_4 = 8'b1001_1001;
localparam  symble_5 = 8'b0100_1001;
localparam  symble_6 = 8'b0100_0001;
localparam  symble_7 = 8'b0001_1111;

localparam  symble_8 = 8'b0000_0001;
localparam  symble_9 = 8'b0000_1001;
localparam  symble_a = 8'b0001_0001;
localparam  symble_b = 8'b1100_0001;

localparam  symble_c = 8'b0110_0011;
localparam  symble_d = 8'b1000_0101;
localparam  symble_e = 8'b0110_0001;
localparam  symble_f = 8'b0111_0001;


assign d = i;

always @(*) begin
    SSD = 8'b0000_0000;
    case (i)
        0: SSD = symble_0;
        1: SSD = symble_1;
        2: SSD = symble_2;
        3: SSD = symble_3;
        4: SSD = symble_4;
        5: SSD = symble_5;
        6: SSD = symble_6;
        7: SSD = symble_7;
        8: SSD = symble_8;
        9: SSD = symble_9;
        10: SSD = symble_a;
        11: SSD = symble_b;
        12: SSD = symble_c;
        13: SSD = symble_d;
        14: SSD = symble_e;
        15: SSD = symble_f;   
    endcase
end


endmodule