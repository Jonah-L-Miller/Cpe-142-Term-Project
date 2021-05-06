module control_unit(
	input [3:0] opcode, function_code,
	input [1:0] branch_result,
	input overflow_flag, reset,
	
	output reg ex_flush, id_flush, halt, if_flush, pc_op, b_jmp, byte_en, mem_write, mux_c, r0_select, overflow_error_warning,
	output reg [1:0] alu_op, mux_a, mux_b, reg_write,
	output reg alu_src_a, alu_src_b
	);
	
	
	
	always@(*) begin
		if (!reset)
			{ex_flush, id_flush, halt, if_flush, pc_op, b_jmp, byte_en, mem_write, mux_c,alu_op, mux_a, mux_b, reg_write, overflow_error_warning} = 18'h00000;

		case (opcode)
			4'b 1111: begin	//a
				alu_op = 2'b 01;
				mux_a = 2'b00;
				mux_b = 2'b00;
				mux_c = 1'b1;

				r0_select =1'b0;
				
				{ex_flush, id_flush, halt, if_flush, pc_op, b_jmp, byte_en, mem_write} = 8'h00;
				if (function_code == 4'b1000 || function_code == 4'b0100)
					reg_write = 2'b11;
				if (function_code == 4'b0001 || function_code == 4'b0010)
					reg_write = 2'b01;
					
				alu_src_a = 1'b0;
				alu_src_b = 1'b0;
			end
			4'b 0001: begin	//andi
				alu_op = 2'b 00;
				
				mux_a = 2'b00;	//EX MUXA
				mux_b = 2'b11;	//EX MUXB
				mux_c = 1'b1;	//WB MUXC
				reg_write[1] = 1'b1;	
				reg_write[0] = 1'b0;
				r0_select =1'b0;
				
				{ex_flush, id_flush, halt, if_flush, pc_op, b_jmp, byte_en, mem_write} = 8'h00;
				
				alu_src_a = 1'b0;
				alu_src_b = 1'b1;
				
			end
			4'b 0010: begin	//ori
				alu_op = 2'b 10;
				
				mux_a = 2'b00;	//EX MUXA
				mux_b = 2'b11;	//EX MUXB
				
				mux_c = 1'b1;	//WB MUXC
				reg_write[1] = 1'b1;	
				reg_write[0] = 1'b0;	//WB_ID REGWRITE
				r0_select =1'b0;
				
				{ex_flush, id_flush, halt, if_flush, pc_op, b_jmp, byte_en, mem_write} = 8'h00;
				
				alu_src_a = 1'b0;
				alu_src_b = 1'b1;
				
			end
			4'b 1010: begin	//lbu
				alu_op = 2'b 11;
				
				ex_flush = 1'b0;
				id_flush = 1'b0;
				halt = 1'b0;
				if_flush = 1'b0;
				
				pc_op = 1'b0;
				b_jmp = 1'b0;
				
				byte_en = 1'b1;
				mem_write = 1'b0;

				mux_a = 2'b11; 
				mux_b = 2'b00;
				mux_c = 1'b0;
				
				reg_write[1] = 1'b1;	
				reg_write[0] = 1'b0;
				r0_select =1'b0;
				
				alu_src_a = 1'b1;
				alu_src_b = 1'b0;
				
			end
			4'b 1011: begin	//sb
				alu_op = 2'b 11;
				
				ex_flush = 1'b0;
				id_flush = 1'b0;
				halt = 1'b0;
				if_flush = 1'b0;
				
				pc_op = 1'b0;
				b_jmp = 1'b0;
				
				byte_en = 1'b1;
				mem_write = 1'b1;

				mux_a = 2'b11; 
				mux_b = 2'b00;
				mux_c = 1'b0;
				
				reg_write = 2'b00;
				r0_select =1'b0;
				
				alu_src_a = 1'b1;
				alu_src_b = 1'b0;
				
			end
			4'b 1100: begin	//lw
				alu_op = 2'b 11;
				
				ex_flush = 1'b0;
				id_flush = 1'b0;
				halt = 1'b0;
				if_flush = 1'b0;
				
				pc_op = 1'b0;
				b_jmp = 1'b0;
				
				byte_en = 1'b0;
				mem_write = 1'b0;

				mux_a = 2'b11; 
				mux_b = 2'b00;
				mux_c = 1'b0;
				
				reg_write[1] = 1'b1;	
				reg_write[0] = 1'b0;
				r0_select =1'b0;
				
				alu_src_a = 1'b1;
				alu_src_b = 1'b0;
				
			end
			4'b 1101: begin	//sw
				alu_op = 2'b 11;
				
				ex_flush = 1'b0;
				id_flush = 1'b0;
				halt = 1'b0;
				if_flush = 1'b0;
				
				pc_op = 1'b0;
				b_jmp = 1'b0;
				
				byte_en = 1'b0;
				mem_write = 1'b1;

				mux_a = 2'b11; 
				mux_b = 2'b00;
				mux_c = 1'b0;
				
				reg_write = 2'b00;	
				r0_select =1'b0;
				
				alu_src_a = 1'b1;
				alu_src_b = 1'b0;
			end
			4'b 0101: begin	//blt
				if(branch_result == 2'b11) begin
					alu_op = 2'b 00;
					
					ex_flush = 1'b0;
					id_flush = 1'b1;
					halt = 1'b0;
					if_flush = 1'b1;
					
					pc_op = 1'b1;
					b_jmp = 1'b1;
					
					byte_en = 1'b0;
					mem_write = 1'b1;

					mux_a = 2'b00; 
					mux_b = 2'b00;
					mux_c = 1'b0;
					
					reg_write = 2'b00;
					r0_select =1'b1;
					
					alu_src_a = 1'b0;
				alu_src_b = 1'b0;
				end
				else begin
					alu_op = 2'b 00;
					
					ex_flush = 1'b0;
					id_flush = 1'b0;
					halt = 1'b0;
					if_flush = 1'b0;
					
					pc_op = 1'b0;
					b_jmp = 1'b0;
					
					byte_en = 1'b0;
					mem_write = 1'b1;

					mux_a = 2'b00; 
					mux_b = 2'b00;
					mux_c = 1'b0;
					
					reg_write = 2'b00;
					r0_select =1'b0;
					
					alu_src_a = 1'b0;
				alu_src_b = 1'b0;
				end
			end
			4'b 0100: begin	//bgt//
				if(branch_result == 2'b10) begin
					alu_op = 2'b 00;
					
					ex_flush = 1'b0;
					id_flush = 1'b1;
					halt = 1'b0;
					if_flush = 1'b1;
					
					pc_op = 1'b1;
					b_jmp = 1'b1;
					
					byte_en = 1'b0;
					mem_write = 1'b1;

					mux_a = 2'b00; 
					mux_b = 2'b00;
					mux_c = 1'b0;
					
					reg_write = 2'b00;
					r0_select =1'b1;
					
					alu_src_a = 1'b0;
				alu_src_b = 1'b0;
				end
				else begin
					alu_op = 2'b 00;
					
					ex_flush = 1'b0;
					id_flush = 1'b0;
					halt = 1'b0;
					if_flush = 1'b0;
					
					pc_op = 1'b0;
					b_jmp = 1'b0;
					
					byte_en = 1'b0;
					mem_write = 1'b1;

					mux_a = 2'b00; 
					mux_b = 2'b00;
					mux_c = 1'b0;
					
					reg_write = 2'b00;
					r0_select =1'b0;
					
					alu_src_a = 1'b0;
				alu_src_b = 1'b0;
				end
				
			end
			4'b 0110: begin	//beq
				if(branch_result == 2'b01) begin
					alu_op = 2'b 00;
					
					ex_flush = 1'b0;
					id_flush = 1'b1;
					halt = 1'b0;
					if_flush = 1'b1;
					
					pc_op = 1'b1;
					b_jmp = 1'b1;
					
					byte_en = 1'b0;
					mem_write = 1'b1;

					mux_a = 2'b00; 
					mux_b = 2'b00;
					mux_c = 1'b0;
					
					reg_write = 2'b00;
					r0_select =1'b1;
					
					alu_src_a = 1'b0;
				alu_src_b = 1'b0;
				end
				else begin
					alu_op = 2'b 00;
					
					ex_flush = 1'b0;
					id_flush = 1'b0;
					halt = 1'b0;
					if_flush = 1'b0;
					
					pc_op = 1'b0;
					b_jmp = 1'b0;
					
					byte_en = 1'b0;
					mem_write = 1'b1;

					mux_a = 2'b00; 
					mux_b = 2'b00;
					mux_c = 1'b0;
					
					reg_write = 2'b00;	
					r0_select =1'b0;
					
					alu_src_a = 1'b0;
				alu_src_b = 1'b0;
				end
				
			end
			4'b 0111: begin	//jmp
				alu_op = 2'b 00;
				
				ex_flush = 1'b0;
				id_flush = 1'b1;
				
				halt = 1'b0;
				if_flush = 1'b1;
				
				pc_op = 1'b1;
				b_jmp = 1'b0;
				
				byte_en = 1'b0;
				mem_write = 1'b0;

				mux_a = 2'b00; 
				mux_b = 2'b00;
				mux_c = 1'b0;
				
				reg_write = 2'b00;
				r0_select =1'b0;
				
				alu_src_a = 1'b0;
				alu_src_b = 1'b0;
			end
			4'b 0000: begin	//halt
				alu_op = 2'b 00;
				
				ex_flush = 1'b0;
				id_flush = 1'b0;
				
				halt = 1'b1;
				if_flush = 1'b1;
				
				pc_op = 1'b0;
				b_jmp = 1'b0;
				
				byte_en = 1'b0;
				mem_write = 1'b0;

				mux_a = 2'b00; 
				mux_b = 2'b00;
				mux_c = 1'b0;
				
				reg_write = 2'b00;
				r0_select =1'b0;
				
				alu_src_a = 1'b0;
				alu_src_b = 1'b0;
				
			end
			default: {ex_flush, id_flush, halt, if_flush, pc_op, b_jmp, byte_en, mem_write, mux_c,alu_op, mux_a, mux_b, reg_write} = 17'h00000;
		endcase
		
		if (overflow_flag) begin
			halt = 1'b1;
			if_flush = 1'b1;
			overflow_error_warning = 1'b1;
			id_flush = 1'b1;
			ex_flush = 1'b1;
		end
			
		
	end
endmodule
