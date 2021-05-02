`include "instruction_memory.v"
`include "program_counter.v"
`include "adder.v"
`include "mux2.v"
`include "buffer.v"
`include "registers.v"
`include "zero_extend_parameter.v"
`include "sign_extend_parameter.v"
`include "left_shift.v"
`include "mux4.v"
`include "alu.v"
`include "alu_op.v"


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
	wire [15:0] id_instruction, id_pc_next_address;
	
	buffer #(.N(32)) if_id_buffer(
		.clock(clock),
		.reset(reset),
		.flush(if_id_buffer_flush),
		.hold(if_id_buffer_hold),
		.buffer_in({if_instruction, if_adder_result_address}),
		.buffer_out({id_instruction, id_pc_next_address})
		);


///// DECODE STAGE /////
	wire [3:0] id_opcode = id_instruction[15:12];
	wire [3:0] id_op1 = id_instruction[11:8];
	wire [3:0] id_op2 = id_instruction[7:4];
	wire [7:0] id_immediate = id_instruction [7:0];
	wire [3:0] id_function_code = id_instruction [3:0];
	wire [15:0]read_reg1, read_reg2;

	wire [3:0] id_mux2_output;
	wire id_mux2_selector;
	wire [3:0] wb_id_write_reg;			//first section of naming scheme deals with the buffer source. wb comes from wb buffer, id comes from id_ buffer
	wire [15:0] wb_id_write_data;
	wire [15:0] wb_id_r0;
	wire wb_id_reg_write_control;
	wire wb_id_write_r0;
	
	wire [15:0] id_read_data_1, id_read_data_2;
	wire [15:0] id_jump_sign_extend, id_branch_sign_extend;
	
	wire id_branch_jump_selector;
	wire [15:0] id_branch_jump_mux2_output;
	wire [15:0] id_branch_jump_left_shift_output;
	wire [15:0] id_pc_branch_result;
	
	wire [7:0]id_zero_extended_immediate, ex_zero_extended_immediate;

	
	mux2 id_read_reg_2_mux2 (
		.in1(id_op2),
		.in2(4'h0),	//location of R0
		.s(id_mux2_selector),
		.out(id_mux2_output)
	);

	registers id_registers(
		.read_reg1(id_op1),
		.read_reg2(id_mux2_output),
		.write_reg(wb_id_write_reg),
		.write_data(wb_id_write_data),
		.r0(wb_id_r0),
		.reg_write(wb_id_reg_write_control),
		.reset(reset),
		.write_r0(wb_id_write_r0),
		.read_data1(id_read_data_1),
		.read_data2(id_read_data_2)		
	);
	
	zero_extend #(.N(8))id_ex_buffer_zero_extend(
		.in(id_immediate),
		.out(id_zero_extended_immediate)
	);
	
		//jump and branch
	sign_extend #(.N(4))id_jump_location(
		.in(id_op1),
		.out(id_jump_sign_extend)
	);
	
	sign_extend #(.N(8))id_branch_location(
		.in(id_op2),
		.out(id_branch_sign_extend)
	);
	
	mux2 id_jump_branch_mux2(
		.in1(id_jump_sign_extend),
		.in2(id_branch_sign_extend),
		.s(id_branch_jump_selector),
		.out(id_branch_jump_mux2_output)
	);

	left_shift id_jump_branch_left_shift(
		.in(id_branch_jump_mux2_output),
		.out(id_branch_jump_left_shift_output)
	);
	
	adder id_jump_branch_adder(
		.in1(id_pc_next_address),
		.in2(id_jump_branch_location),
		.out(id_pc_branch_result)
	);


///// ID/EX BUFFER /////
	wire [3:0]id_read_data_1,ex_read_data_1;
	wire [3:0]id_read_data_2,ex_read_data_2;
	wire [1:0]id_alu_op;
	wire id_ex_data_memory_write_control, ex_mem_data_memory_write_control;
	wire id_ex_data_memory_byte_enable_control, ex_mem_data_memory_byte_enable_control ;
	wire [1:0]id_ex_register_write_control, ex_mem_register_write_control,ctrl_id_ex_alu_op, ctrl_ex_alu_op;
	wire [15:0] ex_pc_branch_result;
	wire [15:0] ex_op1, ex_op2;
	wire [3:0] ex_function_code;
	/*
	wire [1:0] wb_id_reg_write_control
	wire [3:0] id_opcode         \
	wire [3:0] id_op1 			  \	
	wire [3:0] id_op2 			   > already declared wires that we need for id/ex buffer
	wire [7:0] id_immediate 	  /
	wire [3:0] id_function_code  /
   */                              
	buffer #(.N(84)) id_ex_buffer(
		.clock(clock),
		.reset(reset),
		.buffer_in({id_ex_register_write_control,id_ex_data_memory_write_control,id_ex_data_memory_byte_enable_control, ctrl_id_ex_alu_op,
					id_pc_branch_result,id_opcode,id_read_data_1,id_read_data_2,id_op1,id_op2,id_function_code,
					id_zero_extended_immediate}),
		.buffer_out({ex_mem_register_write_control,ex_mem_data_memory_write_control,ex_mem_data_memory_byte_enable_control, ctrl_ex_alu_op,
					ex_pc_branch_result,ex_opcode,ex_read_data_1,ex_read_data_2,ex_op1,ex_op2,ex_function_code,ex_zero_extended_immediate})
		);


///// EXECUTE STAGE /////
	wire [15:0] mem_ex_forwarded_alu_output, wb_ex_write_data, ex_funct_code_sign_extended, ex_mux_a_output, ex_mux_b_output, ex_mem_alu_output, ex_mem_alu_r0_result;
	wire [1:0] forward_a, forward_b, ex_ctrl_alu_branch_result;
	wire ex_ctrl_alu_overflow_flag;
	wire [3:0] ex_alu_op_ctrl;
	
	sign_extend #(.N(4)) ex_func_code_sign_extend_comp (
		.in(ex_function_code),
		.out(ex_funct_code_sign_extended)
	);
	
	mux4 ex_mux4_alu_in1(
		.in1(ex_read_data_1),
		.in2(mem_ex_forwarded_alu_output),
		.in3(wb_ex_write_data), 
		.in4(ex_funct_code_sign_extended),
		.s(forward_a),
		.out(ex_mux_a_output)
	);
	
	mux4 ex_mux4_alu_in2(
		.in1(ex_read_data_2),
		.in2(mem_ex_forwarded_alu_output),
		.in3(wb_ex_write_data), 
		.in4(ex_zero_extended_immediate),
		.s(forward_b),
		.out(ex_mux_b_output)
	);
	
	alu_ctrl ex_alu_ctrl( //ALU CONTROL UNIT
		.func(ex_function_code),
		.op(ctrl_ex_alu_op),
		.out(ex_alu_op_ctrl)
	);
	
	alu ex_alu(
		.in1(ex_mux_a_output),
		.in2(ex_mux_b_output),
		.out(ex_mem_alu_output),
		.r0(ex_mem_alu_r0_result),
		.branch_result(ex_ctrl_alu_branch_result),
		.overflow_flag(ex_ctrl_alu_overflow_flag),
		.ctrl(ex_alu_op_ctrl)
	);


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
