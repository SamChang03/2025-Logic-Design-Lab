`timescale 1ns / 1ps
`define SS_N  8'b1101_0101
`define SS_T  8'b11100001
`define SS_H  8'b10010001
`define SS_U  8'b10000011
`define SS_E  8'b01100001

`define SS_0  8'b00000011
`define SS_1  8'b10011111
`define SS_2  8'b00100101
`define SS_3  8'b00001101
`define SS_4  8'b10011001
`define SS_5  8'b01001001
`define SS_6  8'b01000001
`define SS_7  8'b00011111
`define SS_8  8'b00000001
`define SS_9  8'b00001001

//Define state
`define state_bits 1 // 2^(State_bits+1) >= #states
`define IDLE 0
`define SETTING 1
`define COUNTING 2
`define STOP 3
