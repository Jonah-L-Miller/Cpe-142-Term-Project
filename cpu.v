`include "instruction_memory.v"
`include "program_counter.v"
`include "adder.v"


module cpu(
	input clock, 
	input reset
);

///// FETCH STAGE WIRES /////
	wire [15:0] if_from_pc, if_instruction;
	wire [15:0] if_pc_new_address, if_instruction_address, if_adder_result_address;
	wire if_pc_stop;
	

///// DECODE STAGE WIRES /////



///// EXECUTE STAGE WIRES /////



///// MEMORY STAGE WIRES /////



///// WRITEBACK STAGE WIRES /////



///// FETCH STAGE /////

	
	//program counter
	program_counter if_program_counter(
		.pc_new_address(if_pc_new_address),				//address from IF_MUX
		.instruction_address(if_instruction_address),	//address from PC
		.pc_stop(if_pc_stop),							//pause pc with PC_pause or halt
		.clock(clock),
		.reset(reset)
		);
	
	//adder
	adder if_adder(
		.in1(if_instruction_address),
		.in2(16'h0002),
		.out(if_adder_result_address)
		);

	 
	



	//instruction memory input and output
	instruction_memory if_instruction_memory (
		.from_pc(if_from_pc),				//adder that increments the address' memory to the next location ie. +2
		.instruction(if_instruction)			//instruction leaving instruction memory and going into IF/ID buffer
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
