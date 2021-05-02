`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/01/2021 08:32:25 PM
// Design Name: 
// Module Name: mux4
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module mux4(
    input [15:0] in1, in2, in3, in4,
    input [1:0] s,
    output reg [15:0] out
    );

    always@(*)
        case (s)
            2'b 00: out = in1;
            2'b 01: out = in2;
            2'b 10: out = in3;
            2'b 11: out = in4;
            default: out = out;
        endcase
endmodule
