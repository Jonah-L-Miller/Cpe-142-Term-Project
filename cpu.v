`include "insruction_memory.v"

module cpu(
			input clk, 
			input reset
);

///// FETCH STAGE WIRES /////
    wire [15:0] if_from_pc, if_instruction;


///// DECODE STAGE WIRES /////



///// EXECUTE STAGE WIRES /////



///// MEMORY STAGE WIRES /////



///// WRITEBACK STAGE WIRES /////



///// FETCH STAGE /////
	//instruction memory input and output
	instruction_memory if_instruction_memory (
		.if_from_pc(if_from_pc),			//adder that increments the address' memory to the next location ie. +2
		.if_instruction(if_instruction)			//instruction leaving instruction memory and going into IF/ID buffer
	);	


///// IF/ID BUFFER /////



///// DECODE STAGE /////



///// ID/EX BUFFER /////



///// EXECUTE STAGE /////



///// EX/MEM BUFFER /////



///// MEMORY STAGE /////



///// MEM/WB BUFFER /////



///// WRITEBACK STAGE /////



///// CONTROL UNIT /////



///// ALU CONTROL /////



///// FORWARDING UNIT /////



///// BRANCH CONTROL /////



///// HAZARD UNIT /////



endmodule

////////////////////////////////////////////////////////////////////////////////// 
// Engineer: Jonah Miller 
// 
// Create Date: 04/26/2021 9:06 PM
// Design Name: cpu
// Module Name: cpu
// Target Devices: ALL 
// Dependencies: ALL 
// Description: connects all of the individual components toghether with wires	
//////////////////////////////////////////////////////////////////////////////////
