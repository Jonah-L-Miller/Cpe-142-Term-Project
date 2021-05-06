`include "cont_unit.v"
module fixture_control_unit();
	reg [3:0] opcode, function_code;
	reg [1:0] branch_result;
	reg overflow_flag, reset;
	
	wire ex_flush, id_flush, halt, if_flush, pc_op, b_jmp, byte_en, mem_write, mux_c, r0_select, overflow_error_warning, alu_src_a, alu_src_b;
	
	wire [1:0] alu_op, reg_write;
	
	control_unit uut(
		.opcode(opcode),
		.function_code(function_code),
		.branch_result(branch_result),
		.overflow_flag(overflow_flag),
		.reset(reset),
		.ex_flush(ex_flush),
		.id_flush(id_flush),
		.halt(halt),
		.if_flush(if_flush),
		.pc_op(pc_op),
		.b_jmp(b_jmp),
		.byte_en(byte_en),
		.mem_write(mem_write),
		.mux_c(mux_c),
		.r0_select(r0_select),
		.overflow_error_warning(overflow_error_warning),
		.alu_src_a(alu_src_a),
		.alu_src_b(alu_src_b),
		.alu_op(alu_op),
		.reg_write(reg_write)
	);
	
	initial
		{opcode, function_code, branch_result, overflow_flag, reset} = 0;
		
	always@(*)begin
		#3;
		$display("\n====INPUT========\n");
		$display("reset = %h", uut.reset);
		$display("opcode = %b", uut.opcode);
		$display("function_code = %b", uut.function_code);
		$display("branch_result = %b", uut.branch_result);
		$display("overflow_flag = %h", uut.overflow_flag);
	
		$display("\n====OUTPUT========\n");
		$display("ex_flush = %h", uut.ex_flush);
		$display("id_flush = %h", uut.id_flush);
		$display("halt = %h", uut.halt);
		$display("if_flush = %h", uut.if_flush);
		$display("pc_op = %h", uut.pc_op);
		$display("b_jmp = %h", uut.b_jmp);
		$display("byte_en = %h", uut.byte_en);
		$display("mem_write = %h", uut.mem_write);
		$display("mux_c = %h", uut.mux_c);
		$display("r0_select = %h", uut.r0_select);
		$display("overflow_error_warning = %h", uut.overflow_error_warning);
		$display("alu_src_a = %h", uut.alu_src_a);
		$display("alu_src_b = %h", uut.alu_src_b);
		$display("alu_op = %h", uut.alu_op);
		$display("reg_write = %h", uut.reg_write);
		
	end
	
	initial begin
		reset = 1;
		#10 reset = 0;
		#10 reset = 1;
		//{opcode, function_code, branch_result, overflow_flag, reset} = 0;
		#10 opcode = 4'b 1111;
			#10 function_code = 4'b 1000;
			#10 function_code = 4'b 0001;
			#10 function_code = 4'b 0100;
			#10 function_code = 4'b 0000;
			#10 function_code = 4'b 0010;
			#10 function_code = 4'b 0000;
		#10 opcode = 4'b 0001;
		#10 opcode = 4'b 0010;
		#10 opcode = 4'b 1010;
		#10 opcode = 4'b 1011;
		#10 opcode = 4'b 1100;
		#10 opcode = 4'b 1101;
		#10 opcode = 4'b 0101;
			#10 branch_result = 2'b11;
			#10 branch_result = 2'b01;
			#10 branch_result = 2'b10;
			#10 branch_result = 2'b00;
		#10 opcode = 4'b 0100;
			#10 branch_result = 2'b11;
			#10 branch_result = 2'b01;
			#10 branch_result = 2'b10;
			#10 branch_result = 2'b00;
		#10 opcode = 4'b 0110;
			#10 branch_result = 2'b11;
			#10 branch_result = 2'b01;
			#10 branch_result = 2'b10;
			#10 branch_result = 2'b00;
		#10 opcode = 4'b 0111;
		#10 opcode = 4'b 0000;
		
	end
endmodule