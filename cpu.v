`include "instruction_memory.v"
`include "program_counter.v"
`include "adder.v"
`include "mux2.v"
`include "buffer.v"


module cpu(
	input clock, 
	input reset
);

///// FETCH STAGE WIRES /////
	wire [15:0] if_address_from_pc, if_instruction;
	wire [15:0] if_pc_new_address, if_adder_result_address, ex_if_branch_location_result;
	wire if_pc_stop, if_pc_mux;
		
	wire if_id_buffer_flush, if_id_buffer_hold;

///// DECODE STAGE WIRES /////
	wire [15:0] id_intruction, id_pc_next_address;


///// EXECUTE STAGE WIRES /////
	//ex_if_branch_location_result coming from EX branch execution to IF 


///// MEMORY STAGE WIRES /////



///// WRITEBACK STAGE WIRES /////



///// FETCH STAGE /////
	assign if_pc_mux = 0;
	assign if_pc_stop = 0;
	
	//program counter
	program_counter if_program_counter(
		.pc_new_address(if_pc_new_address),				//address from IF_MUX
		.instruction_address(if_address_from_pc),	//address from PC
		.pc_stop(if_pc_stop),							//pause pc with PC_pause or halt
		.clock(clock),
		.reset(reset)
		);
	
	//adder
	adder if_adder(
		.in1(if_address_from_pc),
		.in2(16'h0002),
		.out(if_adder_result_address)
		);
		
	//if_mux2
	mux2 if_mux2(
		.in1(if_adder_result_address),
		.in2(ex_if_branch_location_result),
		.s(if_pc_mux),
		.out(if_pc_new_address)
		);
	
	//instruction memory input and output
	instruction_memory if_instruction_memory (
		.from_pc(if_address_from_pc),				//adder that increments the address' memory to the next location ie. +2
		.instruction(if_instruction)			//instruction leaving instruction memory and going into IF/ID buffer
	);	
	

///// IF/ID BUFFER /////
	buffer #(.N(32)) if_id_buffer(
		.clock(clock),
		.reset(reset),
		.flush(if_id_buffer_flush),
		.hold(if_id_buffer_hold),
		.buffer_in({if_instruction, if_adder_result_address}),
		.buffer_out({id_intruction, id_pc_next_address})
		);


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
