`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/28/2021 11:12:18 AM
// Design Name: 
// Module Name: aluControl
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


module alu_control(
    input [1:0] ALUop,
    input [3:0] functCode,
    output reg [3:0] ctrlOut
    );
	
    always @(*) begin 
        case(ALUop) 
            2'b00: ctrlOut[3:0] = 4'b1100; 
            2'b01: begin 
                case(functCode) 
                    4'b0001: ctrlOut[3:0] = 4'b0001; // ADD
                    4'b0010: ctrlOut[3:0] = 4'b0010; // SUB
                    4'b0100: ctrlOut[3:0] = 4'b0100; // MUL
                    4'b1000: ctrlOut[3:0] = 4'b1000; // DIV
                endcase
            end 
            2'b10: ctrlOut[3:0] = 4'b1110; 
            2'b11: ctrlOut[3:0] = 4'b1111; 
        endcase 
    end 
endmodule 
