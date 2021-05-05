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
`include "data_memory.v"
`include "cont_unit.v"
`include "hazard_unit.v"
`include "forwarding_unit.v"
`include "mux5.v"
module cpu(
	input clock, 
	input reset
);

///// FETCH STAGE WIRES /////
	wire [15:0] if_address_from_pc, if_instruction;
	wire [15:0] if_pc_new_address, if_adder_result_address, ex_if_branch_location_result;
	wire if_pc_stop, if_pc_mux, if_id_buffer_flush, if_id_buffer_hold;

	wire [15:0] id_instruction, id_pc_next_address;
///// EXECUTE STAGE WIRES /////
	//ex_if_branch_location_result coming from EX branch execution to IF                                                                                                            


///// MEMORY STAGE WIRES /////



///// WRITEBACK STAGE WIRES /////



///// FETCH STAGE /////
	
	program_counter IF_PROGRAM_COUNTER(
		.pc_new_address(if_pc_new_address),				//address from IF_MUX
		.instruction_address(if_address_from_pc),	//address from PC
		.pc_stop(if_pc_stop),							//pause pc with PC_pause or halt
		.clock(clock),
		.reset(reset)
		);
	

	adder IF_ADDER(
		.in1(if_address_from_pc),
		.in2(16'h0002),
		.out(if_adder_result_address)
		);
		

	mux2 IF_MUX2(
		.in1(if_adder_result_address),
		.in2(ex_if_branch_location_result),
		.s(if_pc_mux),
		.out(if_pc_new_address)
		);
	

	instruction_memory IF_INSTRUCTION_MEMORY (
		.from_pc(if_address_from_pc),				//adder that increments the address' memory to the next location ie. +2
		.instruction(if_instruction)			//instruction leaving instruction memory and going into IF/ID buffer
	);	
	

///// IF/ID BUFFER /////

	
	buffer #(.N(32)) IF_ID_BUFFER(
		.clock(clock),
		.reset(reset),
		.flush(if_id_buffer_flush),
		.hold(if_id_buffer_hold),
		.buffer_in({
			if_instruction, //16
			if_adder_result_address	//16
		}),
		.buffer_out({
			id_instruction, //16
			id_pc_next_address	//16
		})
		);


///// DECODE STAGE /////
	wire [3:0] id_opcode = id_instruction[15:12];
	wire [3:0] id_op1 = id_instruction[11:8];
	wire [3:0] id_op2 = id_instruction[7:4];
	wire [7:0] id_immediate = id_instruction [7:0];
	wire [3:0] id_function_code = id_instruction [3:0];
	wire [15:0]read_reg1, read_reg2;
	wire [11:0] id_jmp;
	wire [7:0] id_branch;

	wire [3:0] id_mux2_output;
	wire id_mux2_selector;
	wire [3:0] wb_id_write_reg;			//first section of naming scheme deals with the buffer source. wb comes from wb buffer, id comes from id_ buffer
	wire [15:0] wb_id_write_data;
	wire [15:0] wb_id_r0;
	wire [1:0] wb_id_reg_write_control;
	
	wire [15:0] id_read_data_1, id_read_data_2;
	wire [15:0] id_jump_sign_extend, id_branch_sign_extend;
	
	wire id_branch_jump_selector;
	wire [15:0] id_branch_jump_mux2_output;
	wire [15:0] id_branch_jump_left_shift_output;
	wire [15:0] id_pc_branch_result;
	
	wire [15:0]id_zero_extended_immediate, ex_zero_extended_immediate;
	
	wire ctrl_id_ex_buffer_flush, ctrl_id_buffer_flush, ctrl_id_halt, ctrl_id_if_buffer_flush;
	
	wire [1:0] id_ex_mux_a_ctrl, id_ex_mux_b_ctrl;

	
	
	mux2 #(.N(4)) ID_READ_REG_2_MUX2 (
		.in1(id_op2),
		.in2(4'h0),	//location of R0
		.s(id_mux2_selector),
		.out(id_mux2_output)
	);

	registers ID_REGISTERS(
		.read_reg1(id_op1),
		.read_reg2(id_mux2_output),
		.write_reg(wb_id_write_reg),
		.write_data(wb_id_write_data),
		.r0(wb_id_r0),
		.reg_write(wb_id_reg_write_control),
		.reset(reset),
		.read_data1(id_read_data_1),
		.read_data2(id_read_data_2)		
	);
	
	zero_extend #(.N(8))ID_EX_BUFFER_ZERO_EXTEND(
		.in(id_immediate),
		.out(id_zero_extended_immediate)
	);
	
		//jump and branch
	sign_extend #(.N(12))ID_JUMP_LOCATION(
		.in(id_jmp),
		.out(id_jump_sign_extend)
	);
	
	sign_extend #(.N(8))ID_BRANCH_LOCATION(
		.in(id_branch),
		.out(id_branch_sign_extend)
	);
	
	mux2 ID_JUMP_BRANCH_MUX2(
		.in1(id_jump_sign_extend),
		.in2(id_branch_sign_extend),
		.s(id_branch_jump_selector),
		.out(id_branch_jump_mux2_output)
	);

	left_shift ID_JUMP_BRANCH_LEFT_SHIFT(
		.in(id_branch_jump_mux2_output),
		.out(id_branch_jump_left_shift_output)
	);
	
	adder ID_JUMP_BRANCH_ADDER(
		.in1(id_pc_next_address),
		.in2(id_branch_jump_left_shift_output),
		.out(id_pc_branch_result)
	);


///// ID/EX BUFFER /////
	wire [15:0] ex_read_data_1;
	wire [15:0] ex_read_data_2;
	wire [1:0]id_alu_op;
	wire id_ex_data_memory_write_control, ex_mem_data_memory_write_control;
	wire id_ex_data_memory_byte_enable_control, ex_mem_data_memory_byte_enable_control ;
	wire [1:0]id_ex_register_write_control, ex_mem_register_write_control,ctrl_id_ex_alu_op, ctrl_ex_alu_op;
	wire [15:0] ex_pc_branch_result;
	wire [3:0] ex_op1, ex_op2;
	wire [3:0] ex_function_code, ex_opcode;
	/*
	wire [1:0] wb_id_reg_write_control
	wire [3:0] id_opcode         \
	wire [3:0] id_op1 			  \	
	wire [3:0] id_op2 			   > already declared wires that we need for id/ex buffer
	wire [7:0] id_immediate 	  /
	wire [3:0] id_function_code  /
   */                              
	buffer #(.N(82)) ID_EX_BUFFER(
		.clock(clock),
		.reset(reset),
		.buffer_in({
			id_ex_register_write_control,
			id_ex_data_memory_write_control,
			id_ex_data_memory_byte_enable_control, 
			ctrl_id_ex_alu_op,
			id_pc_branch_result,
			id_read_data_1,
			id_read_data_2,
			id_op1,
			id_op2,
			id_function_code,
			id_zero_extended_immediate
		}),
		.buffer_out({
			ex_mem_register_write_control, //2
			ex_mem_data_memory_write_control, //1
			ex_mem_data_memory_byte_enable_control, //1
			ctrl_ex_alu_op, //2
			ex_pc_branch_result, //16
			ex_read_data_1, //16
			ex_read_data_2, //16
			ex_op1, //4
			ex_op2,	//4
			ex_function_code, //4
			ex_zero_extended_immediate //16
		})
		);


///// EXECUTE STAGE /////
	wire [15:0] mem_ex_forwarded_alu_output, wb_ex_write_data, ex_funct_code_sign_extended, ex_mux_a_output, ex_mux_b_output, ex_mem_alu_output, ex_mem_alu_r0_result;
	wire [1:0] ex_ctrl_alu_branch_result, ex_mem_reg_wrt_ctrl_flush;
	wire [2:0] forward_a, forward_b;
	wire ex_ctrl_alu_overflow_flag, ex_mem_data_mem_wrt_ctrl,ex_mem_data_mem_byte_ctrl;
	wire [3:0] ex_alu_op_ctrl;
	wire ctrl_ex_flush;
	
	sign_extend #(.N(4)) EX_FUNC_CODE_SIGN_EXTEND_COMP (
		.in(ex_function_code),
		.out(ex_funct_code_sign_extended)
	);
	
	mux2 #(.N(2)) EX_MUX2_EX_MEM_REG_WRT_CTRL_FLUSH(	//ex_mem_register_write_control		
		.in1(ex_mem_register_write_control),
		.in2(2'b0),
		.s(ctrl_ex_flush),
		.out(ex_mem_reg_wrt_ctrl_flush)
	);
	
	mux2 #(.N(1)) EX_MUX2_EX_MEM_DATA_MEM_WRT_CTRL_FLUSH(	//ex_mem_data_memory_write_control		
		.in1(ex_mem_data_memory_write_control),
		.in2(1'b0),
		.s(ctrl_ex_flush),
		.out(ex_mem_data_mem_wrt_ctrl)	
	);
	
	mux2 #(.N(1)) EX_MUX2_EX_MEM_DATA_MEM_BYTE_ENABLE_FLUSH(	//ex_mem_data_memory_byte_enable_control
		.in1(ex_mem_data_memory_byte_enable_control),
		.in2(1'b0),
		.s(ctrl_ex_flush),
		.out(ex_mem_data_mem_byte_ctrl)	
	);
	wire [15:0] mem_ex_read_data;
	mux5 EX_MUX5_ALU_IN1(
		.in1(ex_read_data_1),
		.in2(mem_ex_forwarded_alu_output),
		.in3(wb_ex_write_data), 
		.in4(ex_funct_code_sign_extended),
		.in5(mem_ex_read_data),//SE IMMEDIATE
		.s(forward_a),
		.out(ex_mux_a_output)
	);
	
	mux5 EX_MUX5_ALU_IN2(
		.in1(ex_read_data_2),
		.in2(mem_ex_forwarded_alu_output),
		.in3(wb_ex_write_data), 
		.in4(ex_zero_extended_immediate),
		.in5(mem_ex_read_data),
		.s(forward_b),
		.out(ex_mux_b_output)
	);
	
	alu_ctrl EX_ALU_CTRL( //ALU CONTROL UNIT
		.func(ex_function_code),
		.op(ctrl_ex_alu_op),
		.out(ex_alu_op_ctrl)
	);
	
	alu EX_ALU(
		.reset(reset),
		.in1(ex_mux_a_output),
		.in2(ex_mux_b_output),
		.out(ex_mem_alu_output),
		.r0(ex_mem_alu_r0_result),
		.overflow_flag(ex_ctrl_alu_overflow_flag),
		.ctrl(ex_alu_op_ctrl)
	);


///// EX/MEM BUFFER /////
	wire [1:0] mem_wb_reg_wrt_ctrl_flush;
	wire mem_wb_data_mem_wrt_ctrl, mem_wb_data_mem_byte_ctrl;
	wire [15:0] mem_wb_alu_r0_result, mem_wb_alu_output;
	wire [3:0] mem_op1;
	
	buffer #(.N(40)) EX_MEM_BUFFER(
		.clock(clock),
		.reset(reset),
		//.flush(flush),
		//.hold(.hold),
		.buffer_in({
			ex_mem_reg_wrt_ctrl_flush,
			ex_mem_data_mem_wrt_ctrl,
			ex_mem_data_mem_byte_ctrl,
			ex_mem_alu_r0_result,
			ex_mem_alu_output,
			ex_op1
		}),
		.buffer_out({
			mem_wb_reg_wrt_ctrl_flush,
			mem_wb_data_mem_wrt_ctrl,
			mem_wb_data_mem_byte_ctrl,
			mem_wb_alu_r0_result,
			mem_wb_alu_output,
			mem_op1
		})
	);


///// MEMORY STAGE /////
	wire [15:0] mem_wb_data_line;
	
	data_memory MEM_DATA_MEMORY(
		.memWrite(mem_wb_data_mem_wrt_ctrl),
		.reset(reset),
		.byte_en(mem_wb_data_mem_byte_ctrl),
		.address(mem_wb_alu_output),
		.writeData(mem_wb_alu_output),
		.readData(mem_wb_data_line)
	);
	
///// MEM/WB BUFFER /////
	wire [15:0] wb_data_line, wb_alu_output;
	wire mux_c_wb_data_ctrl;
	buffer #(.N(54)) MEM_WB_BUFFER (
		.clock(clock),
		.reset(reset),
		.buffer_in({
			mem_wb_reg_wrt_ctrl_flush,
			mem_wb_alu_r0_result, 
			mem_wb_data_line,
			mem_wb_alu_output,
			mem_op1
		}),
		.buffer_out({
			wb_id_reg_write_control, 
			wb_id_r0,
			wb_data_line,
			wb_alu_output,
			wb_id_write_reg
		})
	);
	

///// WRITEBACK STAGE /////
	mux2 WB_MUX2(
		.in1(wb_data_line),
		.in2(wb_alu_output),
		.s(mux_c_wb_data_ctrl),
		.out(wb_id_write_data)
	);


///// CONTROL UNIT /////
	wire overflow_error_warning;
	control_unit CTRL_UNIT(
		.opcode(id_opcode),
		.branch_result(ex_ctrl_alu_branch_result),
		.overflow_flag(overflow_error_warning),
		.reset(reset),
		.ex_flush(ctrl_id_ex_buffer_flush),
		.id_flush(ctrl_id_buffer_flush),
		.halt(ctrl_id_halt),
		.if_flush(ctrl_id_if_buffer_flush),
		.pc_op(if_pc_mux),
		.b_jmp(id_branch_jump_selector),
		.byte_en(id_ex_data_memory_byte_enable_control),
		.mem_write(id_ex_data_memory_write_control),
		.mux_c(id_ex_mux_c_wb_data_ctrl),
		.r0_select(id_mux2_selector),
		.overflow_error_warning(overflow_error_warning),
		.alu_op(ctrl_id_ex_alu_op),
		.mux_a(id_ex_mux_a_ctrl),
		.mux_b(id_ex_mux_b_ctrl), 
		.reg_write(id_ex_register_write_control)
	);


///// FORWARDING UNIT /////
	wire mem_muxc, forward_branch;
	wire [1:0] ex_regwrite, mem_regwrite, wb_regwrite;
	wire [3:0] wb_op1;
	forwarding_unit FORWARDING_UNIT(
		.ex_regwrite(ex_regwrite),
		.mem_regwrite(mem_regwrite),
		.wb_regwrite(wb_regwrite),
		.id_op1(id_op1),
		.ex_op1(ex_op1),
		.wb_op1(wb_op1),
		.mem_op1(mem_op1),
		.id_op2(id_op2),
		.ex_op2(ex_op2),
		.mem_muxc(mem_muxc),
		.forward_a(forward_a),
		.forward_b(forward_b),
		.forward_branch(forward_branch)	
	);


///// HAZARD UNIT /////
	wire mux_c_ex_ctrl;
	
	hazard_unit HAZ_UNIT(
		.ex_memread(mux_c_ex_ctrl),
		.id_op1(id_op1),
		.ex_op1(ex_op1),
		.id_op2(id_op2),
		.ex_op2(ex_op2),
		.id_flush(id_flush),
		.pc_pause(pc_stop),
		.if_id_flush(if_id_buffer_flush)
	);


endmodule