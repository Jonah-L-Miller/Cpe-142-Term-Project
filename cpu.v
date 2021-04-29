`include "instruction_memory.v"
`include "program_counter.v"
`include "adder.v"
`include "mux2.v"
`include "buffer.v"
`include "registers.v"


module cpu(
	input clock, 
	input reset
);

///// FETCH STAGE WIRES /////





///// EXECUTE STAGE WIRES /////
	//ex_if_branch_location_result coming from EX branch execution to IF 


///// MEMORY STAGE WIRES /////



///// WRITEBACK STAGE WIRES /////



///// FETCH STAGE /////
	assign if_pc_mux = 0;
	assign if_pc_stop = 0;
	
	wire [15:0] if_address_from_pc, if_instruction;
	wire [15:0] if_pc_new_address, if_adder_result_address, ex_if_branch_location_result;
	wire if_pc_stop, if_pc_mux, if_id_buffer_flush, if_id_buffer_hold;
	
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
	wire [15:0] id_intruction, id_pc_next_address;
	
	buffer #(.N(32)) if_id_buffer(
		.clock(clock),
		.reset(reset),
		.flush(if_id_buffer_flush),
		.hold(if_id_buffer_hold),
		.buffer_in({if_instruction, if_adder_result_address}),
		.buffer_out({id_intruction, id_pc_next_address})
		);


///// DECODE STAGE /////
	wire [3:0] id_opcode = id_instruction[15:12];
	wire [3:0] id_op1 = id_instruction[11:8];
	wire [3:0] id_op2 = id_instruction[7:4];
	wire [7:0] id_immediate = id_instruction [7:0];
	wire [3:0] id_function_code = id_instruction [3:0];
	
	wire [3:0] id_mux2_output;
	wire id_mux2_selector;
	wire [3:0] wb_id_write_reg;			//first section of naming scheme deals with the buffer source. wb comes from wb buffer, id comes from id_ buffer
	wire [15:0] wb_id_write_data;
	wire [15:0] wb_id_r0;
	wire wb_id_reg_write_control;
	wire wb_id_write_r0;
	
	wire [15:0] id_read_data_1, id_read_data_2;
	
	mux2 id_read_reg_2_mux2 (
		.in1(id_op2),
		.in2(4'h0),	//location of R0
		.s(id_mux2_selector),
		.out(id_mux2_output)
	);
	
	registers id_registers(
		.read_reg_1(id_op1),
		.read_reg_2(id_mux2_output),
		.write_reg(wb_id_write_reg),
		.write_data(wb_id_write_data),
		.r0(wb_id_r0),
		.reg_write(wb_id_reg_write_control),
		.reset(reset),
		.write_r0(wb_id_write_r0),
		.read_data1(id_read_data_1),
		.read_data2(id_read_data_2)		
	);



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
