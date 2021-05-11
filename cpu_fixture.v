`include "cpu.v"
module fixture_cpu();
    reg clock, reset;
    integer clock_cycles;
    	

    cpu CPU (
        .clock(clock),
        .reset(reset)
    );

	initial begin
		clock_cycles = 0;
		clock = 0;
		forever begin
			#10 clock = ~clock;

			if(clock == 1)
				clock_cycles = clock_cycles + 1;
			if(reset == 0)
				clock_cycles = 0;
		end
	end

	

    always@(negedge clock) begin
		$display("\n------------------------------------------");
    	$display("\nclock_cycles = %d  reset = %h",clock_cycles,reset);
		$display("\n------------------------------------------");
		
 		$display("\n----------IF/ID BUFFER-----------");
			$display("\nInputs");
			$display("------");
			$display("IF_INSTRUCTION					=%h",CPU.if_instruction);
			$display("IF_ADDER_RESULT_ADDRESS				=%h",CPU.if_adder_result_address);
			$display("\nOutputs");
			$display("------");
			$display("ID_INSTRUCTION					=%h",CPU.id_instruction);
			$display("ID_PC_NEXT_ADDRESS				=%h",CPU.id_pc_next_address);
			
		$display("\n----------ID/EX BUFFER-----------");
			$display("\nInputs");
			$display("------");
			$display("ID_EX_REGISTER_WRITE_CONTROL			=%h",CPU.id_ex_register_write_control);
			$display("ID_EX_DATA_MEMORY_WRITE_CONTROL			=%h",CPU.id_ex_data_memory_write_control);
			$display("ID_EX_DATA_MEMORY_BYTE_ENABLE_CONTROL		=%h",CPU.id_ex_data_memory_byte_enable_control);
			$display("CTRL_ID_EX_ALU_OP				=%h",CPU.ctrl_id_ex_alu_op);
			$display("ID_PC_BRANCH_RESULT				=%h",CPU.id_pc_branch_result);
			$display("ID_READ_DATA_1					=%h",CPU.id_read_data_1);
			$display("ID_READ_DATA_2					=%h",CPU.id_read_data_2);
			$display("ID_OP1						=%h",CPU.id_op1);
			$display("ID_OP2						=%h",CPU.id_op2);
			$display("ID_FUNCTION_CODE				=%h",CPU.id_function_code);
			$display("ID_ZERO_EXTENDED_IMMEDIATE			=%h",CPU.id_zero_extended_immediate);				
			$display("\nOutputs");
			$display("------");		
			$display("EX_MEM_REGISTER_WRITE_CONTROL			=%h",CPU.ex_mem_register_write_control);
			$display("EX_MEM_DATA_MEMORY_WRITE_CONTROL		=%h",CPU.ex_mem_data_memory_write_control);
			$display("EX_MEM_DATA_MEMORY_BYTE_ENABLE_CONTROL		=%h",CPU.ex_mem_data_memory_byte_enable_control);
			$display("CTRL_EX_ALU_OP					=%h",CPU.ctrl_ex_alu_op);
			$display("EX_READ_DATA_1					=%h",CPU.ex_read_data_1);
			$display("EX_READ_DATA_2					=%h",CPU.ex_read_data_2);
			$display("EX_OP1						=%h",CPU.ex_op1);
			$display("EX_OP2						=%h",CPU.ex_op2);
			$display("EX_FUNCTION_CODE				=%h",CPU.ex_function_code);
			$display("EX_ZERO_EXTENDED_IMMEDIATE			=%h",CPU.ex_zero_extended_immediate);
	
 		$display("\n----------EX/MEM BUFFER----------");
			$display("\nInputs");
			$display("------");
			$display("EX_MEM_REG_WRT_CTRL_FLUSH			=%h",CPU.ex_mem_reg_wrt_ctrl_flush);
			$display("EX_MEM_DATA_MEM_WRT_CTRL			=%h",CPU.ex_mem_data_mem_wrt_ctrl);
			$display("EX_MEM_DATA_MEM_BYTE_CTRL			=%h",CPU.ex_mem_data_mem_byte_ctrl);
			$display("EX_MEM_ALU_R0_RESULT				=%h",CPU.ex_mem_alu_r0_result);
			$display("EX_MEM_ALU_OUTPUT				=%h",CPU.ex_mem_alu_output);
			$display("EX_OP1						=%h",CPU.ex_op1);			
			$display("\nOutputs");
			$display("------");
			$display("MEM_WB_REG_WRT_CTRL_FLUSH			=%h",CPU.mem_wb_reg_wrt_ctrl_flush);
			$display("MEM_WB_DATA_MEM_WRT_CTRL			=%h",CPU.mem_wb_data_mem_wrt_ctrl);
			$display("MEM_WB_DATA_MEM_BYTE_CTRL			=%h",CPU.mem_wb_data_mem_byte_ctrl);
			$display("MEM_WB_ALU_R0_RESULT				=%h",CPU.mem_wb_alu_r0_result);
			$display("MEM_WB_ALU_OUTPUT				=%h",CPU.mem_wb_alu_output);
			$display("MEM_OP1						=%h",CPU.mem_op1);
			
		// $display("\n----------MEM/WB BUFFER----------");
			// $display("\nInputs");
			// $display("------");
			// $display("MEM_WB_REG_WRT_CTRL_FLUSH			=%h",CPU.mem_wb_reg_wrt_ctrl_flush);
			// $display("MEM_WB_ALU_R0_RESULT				=%h",CPU.mem_wb_alu_r0_result);
			// $display("MEM_WB_DATA_LINE				=%h",CPU.mem_wb_data_line);
			// $display("MEM_WB_ALU_OUTPUT				=%h",CPU.mem_wb_alu_output);
			// $display("MEM_OP1						=%h",CPU.mem_op1);
			// $display("\nOutputs");
			// $display("------");
			// $display("WB_ID_REG_WRITE_CONTROL			=%h",CPU.wb_id_reg_write_control);
			// $display("WB_ID_R0				=%h",CPU.wb_id_r0);
			// $display("WB_DATA_LINE				=%h",CPU.wb_data_line);
			// $display("WB_ALU_OUTPUT				=%h",CPU.wb_alu_output);
			// $display("WB_ID_WRITE_REG						=%h",CPU.wb_id_write_reg);
			
		
		// $display("\n-----IF-----\n");
			// $display("IF_ADDRESS_FROM_PC           			= %h", CPU.if_address_from_pc);
			// $display("IF_INSTRUCTION       				= %h", CPU.if_instruction);
			// $display("IF_PC_NEW_ADDRESS    				= %h", CPU.if_pc_new_address);
			// $display("IF_PC_STOP  	   				= %h",CPU.if_pc_stop);
			// $display("IF_ADDER_RESULT_ADDRESS 			= %h", CPU.if_adder_result_address);	  
			// $display("EX_IF_BRANCH_LOCATION_RESULT  	   		= %h",CPU.ex_if_branch_location_result);
			// $display("IF_PC_MUX  	   				= %h",CPU.if_pc_mux); 

		$display("\n-----ID-----\n");
			$display("IF_ID_BUFFER_FLUSH				= %h",CPU.if_id_buffer_flush);
			$display("IF_ID_BUFFER_HOLD        			= %h",CPU.if_id_buffer_hold);
			$display("ID_INSTRUCTION  	       			= %h",CPU.id_instruction);
			$display("ID_PC_NEXT_ADDRESS  	   			= %h",CPU.id_pc_next_address);
			$display("ID_OPCODE  		  	   		= %h",CPU.id_opcode);
			$display("ID_OP1  		  	   	   	= %h",CPU.id_op1);
			$display("ID_OP2				   		= %h",CPU.id_op2);
			$display("ID_IMMEDIATE			  		= %h",CPU.id_immediate);
			$display("ID_FUNCTION_CODE 				= %h",CPU.id_function_code);
			$display("ID_MUX2_OUTPUT		 			= %h",CPU.id_mux2_output);
			$display("ID_MUX2_SELECTOR         			= %h",CPU.id_mux2_selector);
			$display("WB_ID_WRITE_REG          			= %h",CPU.wb_id_write_reg);
			$display("WB_ID_WRITE_DATA         			= %h",CPU.wb_id_write_data);
			$display("ID_READ_DATA_1          			= %h",CPU.id_read_data_1);
			$display("ID_READ_DATA_2           			= %h",CPU.id_read_data_2);
			$display("ID_ALU_OP				   	= %h",CPU.id_alu_op);
			$display("ID_ZERO_EXTENDED_IMMEDIATE			= %h",CPU.id_zero_extended_immediate);
			$display("ID_EX_DATA_MEMORY_WRITE_CONTROL			= %h",CPU.id_ex_data_memory_write_control);
			$display("ID_EX_DATA_MEMORY_BYTE_ENABLE_CONTROL		= %h",CPU.id_ex_data_memory_byte_enable_control);
			$display("ID_EX_REGISTER_WRITE_CONTROL			= %h",CPU.id_ex_register_write_control);
			$display("ID_PC_BRANCH_RESULT				= %h",CPU.id_pc_branch_result);	
			
			$display("ID_JMP                           = %h", CPU.id_jmp);
			$display("ID_BRANCH                        = %h", CPU.id_branch);
			$display("ID_BRANCH_JUMP_LEFT_SHIFT_OUTPUT = %h", CPU.id_branch_jump_left_shift_output);


				
      	$display("\n-----EX-----");
			$display("MEM_EX_FORWARDED_ALU_OUTPUT			=%h",CPU.mem_ex_forwarded_alu_output);
			$display("WB_EX_WRITE_DATA				=%h",CPU.wb_ex_write_data);
			$display("EX_FUNCT_CODE_SIGN_EXTENDED			=%h",CPU.ex_funct_code_sign_extended);
			$display("EX_MUX_A_OUTPUT					=%h",CPU.ex_mux_a_output);
			$display("EX_MUX_B_OUTPUT					=%h",CPU.ex_mux_b_output);
			$display("ex_alu_src_a			=%h",CPU.ex_alu_src_a);
			$display("ex_alu_src_b			=%h",CPU.ex_alu_src_b);
			$display("ex_alu_src_a_output			=%h",CPU.ex_alu_src_a_output);
			$display("ex_alu_src_b_output			=%h",CPU.ex_alu_src_b_output);
			$display("EX_MEM_ALU_OUTPUT				=%h",CPU.ex_mem_alu_output);
			$display("EX_MEM_ALU_R0_RESULT				=%h",CPU.ex_mem_alu_r0_result);
			$display("FORWARD_A					=%h",CPU.forward_a);
			$display("FORWARD_B					=%h",CPU.forward_b);
			$display("EX_CTRL_ALU_BRANCH_RESULT			=%h",CPU.ex_ctrl_alu_branch_result);
			$display("EX_MEM_REG_WRT_CTRL_FLUSH			=%h",CPU.ex_mem_reg_wrt_ctrl_flush);
			$display("EX_CTRL_ALU_OVERFLOW_FLAG			=%h",CPU.ex_ctrl_alu_overflow_flag);
			$display("EX_MEM_DATA_MEM_WRT_CTRL			=%h",CPU.ex_mem_data_mem_wrt_ctrl);
			$display("EX_MEM_DATA_MEM_BYTE_CTRL			=%h",CPU.ex_mem_data_mem_byte_ctrl);
			$display("EX_ALU_OP_CTRL					=%h",CPU.ex_alu_op_ctrl);
			$display("CTRL_EX_FLUSH					=%h",CPU.ctrl_ex_flush);
	 
    
 
		// $display("\n-----MEM-----");
			// $display("MEM_WB_DATA_LINE				=%h",CPU.mem_wb_data_line);
				
		// $display("\n-----WB-----");
			// $display("WB_DATA_LINE					=%h",CPU.wb_data_line);
			// $display("wb_alu_output					=%h",CPU.wb_alu_output);
			// $display("MUX_C_WB_DATA_CTRL				=%h",CPU.mux_c_wb_data_ctrl);
			// $display("WB_ID_WRITE_DATA				=%h",CPU.wb_id_write_data);

		
		$display("\n-----CONTROL_UNIT-----");
			// $display("ID_OPCODE					=%h",CPU.id_opcode);
			// $display("EX_CTRL_ALU_BRANCH_RESULT			=%h",CPU.ex_ctrl_alu_branch_result);
			$display("OVERFLOW_FLAG					=%h",CPU.overflow_error_warning);
			// $display("CTRL_ID_EX_BUFFER_FLUSH				=%h",CPU.ctrl_id_ex_buffer_flush);
			// $display("CTRL_ID_BUFFER_FLUSH				=%h",CPU.ctrl_id_buffer_flush);
			$display("CTRL_ID_HALT					=%h",CPU.ctrl_id_halt);
			// $display("CTRL_ID_IF_BUFFER_FLUSH				=%h",CPU.ctrl_id_if_buffer_flush);
			// $display("IF_PC_MUX					=%h",CPU.if_pc_mux);
			// $display("ID_BRANCH_JUMP_SELECTOR				=%h",CPU.id_branch_jump_selector);
			// $display("ID_EX_DATA_MEMORY_BYTE_ENABLE_CONTROL		=%h",CPU.id_ex_data_memory_byte_enable_control);
			$display("ID_EX_DATA_MEMORY_WRITE_CONTROL			=%h",CPU.id_ex_data_memory_write_control);
			$display("ID_EX_MUX_C_WB_DATA_CTRL			=%h",CPU.id_ex_mux_c_wb_data_ctrl);
			// $display("ID_MUX2_SELECTOR				=%h",CPU.id_mux2_selector);
			// $display("CTRL_ID_EX_ALU_OP				=%h",CPU.ctrl_id_ex_alu_op);
			$display("ID_EX_REGISTER_WRITE_CONTROL			=%h",CPU.id_ex_register_write_control);
		
		// $display("\n-----ALU_CONTROL-----");
			// $display("ex_function_code				=%h",CPU.ex_function_code);
			// $display("ctrl_ex_alu_op					=%h",CPU.ctrl_ex_alu_op);
			// $display("ex_alu_op_ctrl					=%h",CPU.ex_alu_op_ctrl);	
		
		// $display("\n-----FORWARDING_UNIT-----");
			// $display("EX_REGWRITE					=%h",CPU.ex_regwrite);
			// $display("MEM_REGWRITE					=%h",CPU.mem_regwrite);
			// $display("ID_OP1						=%h",CPU.id_op1);
			// $display("EX_OP1						=%h",CPU.ex_op1);
			// $display("MEM_OP1						=%h",CPU.mem_op1);
			// $display("ID_OP2						=%h",CPU.id_op2);
			// $display("EX_OP2EX_OP2					=%h",CPU.ex_op2);
			// $display("MEM_MUXC					=%h",CPU.mem_muxc);
			// $display("FORWARD_A					=%h",CPU.forward_a);
			// $display("FORWARD_B					=%h",CPU.forward_b);
			// $display("FORWARD_BRANCH					=%h",CPU.forward_branch);		
		
		// $display("\n-----BRANCH_CONTROL-----");
		  
		$display("\n-----HAZARD_UNIT-----");
			$display("ex_mem_data_memory_write_control					=%h",CPU.ex_mem_data_memory_write_control);
			$display("ID_OP1						=%h",CPU.id_op1);
			$display("EX_OP1						=%h",CPU.ex_op1);
			$display("ID_OP2						=%h",CPU.id_op2);
			$display("Ex_OP2						=%h",CPU.ex_op2);
			$display("ID_FLUSH					=%h",CPU.id_flush);
			$display("hazard_pc_stop						=%h",CPU.hazard_pc_stop);
			$display("IF_ID_BUFFER_FLUSH				=%h",CPU.if_id_buffer_flush);
			$display("if_id_buffer_hold			=%h",CPU.if_id_buffer_hold);

    end
    
	initial begin
			reset = 1;
			#10
			reset = 0;
			#20
			reset = 1;
			#40 

			
			#620
			$finish;
		end
                   
endmodule
