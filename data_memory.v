`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/27/2021 03:50:17 PM
// Design Name: 
// Module Name: data_memory
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


module data_memory(
	input memWrite, memRead, clk, reset,
	input [15:0] address, writeData,
	output reg [15:0] readData
	);
	reg [7:0] memory [0:255];
	
	always@(*)begin 
		if(reset) begin 
			memory[(16'h3856)] <= 8'h00;
            memory[(16'h0000)] <= 8'h02;
            memory[(16'h4312)] <= 8'h04;
            memory[(16'hBEDE)] <= 8'h06;
            memory[(16'hADEF)] <= 8'h08;
		end 
	end  
	
	always@(posedge clk) begin 
        if(memWrite)begin 
            memory[address] <= writeData; 
            memory[address + 1] <= writeData;
        end 
        
        if(memRead) begin 
            readData <= memory[address];
            readData <= memory[address + 1]; 
        end 
    end 
endmodule
