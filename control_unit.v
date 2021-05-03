`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/02/2021 02:33:54 PM
// Design Name: 
// Module Name: control_unit
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


module control_unit( 
    input [3:0] opcode,
    output reg [1:0] ALUOp,
	output reg regWrite, memReg, memWrite, memRead, ALUSrc, branch, flush, jump
    );

    always@(*)
    case(opcode)
        4'b1111: //A type (add, sub, mul, div)
        begin 
            branch = 1'b0;
            jump = 1'b0; 
            flush = 1'b1;
            regWrite = 1'b1; 
            ALUOp = 2'b00;
            ALUSrc = 1'b0;
            memRead = 1'b0;
            memWrite = 1'b0;
            memReg = 1'b0;
        end 
        
        4'b0001: //C type ANDi
        begin 
            branch = 1'b0;
            jump = 1'b0; 
            flush = 1'b1;
            regWrite = 1'b1; 
            ALUOp = 2'b01;
            ALUSrc = 1'b1;
            memRead = 1'b0;
            memWrite = 1'b0;
            memReg = 1'b0;
        end 
        
        4'b0010: //C type  ORi
        begin 
            branch = 1'b0;
            jump = 1'b0; 
            flush = 1'b1;
            regWrite = 1'b1; 
            ALUOp = 2'b10;
            ALUSrc = 1'b1;
            memRead = 1'b0;
            memWrite = 1'b0;
            memReg = 1'b0;
        end 
        
        4'b1010: //B type lbu 
        begin 
            branch = 1'b0;
            jump = 1'b0; 
            flush = 1'b1;
            regWrite = 1'b1; 
            ALUOp = 2'b11;
            ALUSrc = 1'b1;
            memRead = 1'b1;
            memWrite = 1'b0;
            memReg = 1'b1;
        end 
        
        4'b1011: //B type sb 
        begin 
            branch = 1'b0;
            jump = 1'b0; 
            flush = 1'b1;
            regWrite = 1'b0; 
            ALUOp = 2'b11;
            ALUSrc = 1'b1;
            memRead = 1'b0;
            memWrite = 1'b1;
            memReg = 1'b0;
        end 
        
        4'b1100: //B type lw
        begin 
            branch = 1'b0;
            jump = 1'b0; 
            flush = 1'b1;
            regWrite = 1'b1; 
            ALUOp = 2'b11;
            ALUSrc = 1'b1;
            memRead = 1'b1;
            memWrite = 1'b0;
            memReg = 1'b1;
        end 
        
        4'b1101: //B type sw
        begin  
            branch = 1'b0;
            jump = 1'b0; 
            flush = 1'b1;
            regWrite = 1'b0; 
            ALUOp = 2'b11;
            ALUSrc = 1'b1;
            memRead = 1'b0;
            memWrite = 1'b1;
            memReg = 1'b0;
        end 
        
        4'b0101: //C type blt 
        begin 
            branch = 1'b1;
            jump = 1'b0; 
            flush = 1'b1;
            regWrite = 1'b0; 
            ALUOp = 2'b00;
            ALUSrc = 1'b1;
            memRead = 1'b1;
            memWrite = 1'b0;
            memReg = 1'b0;
        end 
        
        4'b0100: 
        begin //C type bgt
            branch = 1'b1;
            jump = 1'b0; 
            flush = 1'b1;
            regWrite = 1'b0; 
            ALUOp = 2'b00;
            ALUSrc = 1'b1;
            memRead = 1'b1;
            memWrite = 1'b0;
            memReg = 1'b0;
        end 
        
        4'b0110: //C type beq 
        begin 
            branch = 1'b1;
            jump = 1'b0; 
            flush = 1'b1;
            regWrite = 1'b0; 
            ALUOp = 2'b00;
            ALUSrc = 1'b1;
            memRead = 1'b1;
            memWrite = 1'b0;
            memReg = 1'b0;
        end 
        
        4'b0111: //D type jump 
        begin 
            branch = 1'b0;
            jump = 1'b1; 
            flush = 1'b1;
            regWrite = 1'b00; 
            ALUOp = 2'b00;
            ALUSrc = 1'b0;
            memRead = 1'b0;
            memWrite = 1'b0;
            memReg = 1'b0;
        end 
        
        4'b0000: //D type halt
        begin  
            branch = 1'b0;
            jump = 1'b0; 
            flush = 1'b1;
            regWrite = 1'b0; 
            ALUOp = 2'b00;
            ALUSrc = 1'b0;
            memRead = 1'b0;
            memWrite = 1'b0;
            memReg = 1'b0;
        end 
    endcase
endmodule
