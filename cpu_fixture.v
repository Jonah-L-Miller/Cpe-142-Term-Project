`include "cpu.v"

module cpu_fixture();

    reg clock, reset;
    integer clock_cycles;
    
   // initial 
       // $vcdpluson;
    
    cpu CPU (
        .clock(clock),
        .reset(reset)
    );
    
    initial 
    begin
        clock_cycles = 0;
        clock = 0;
        forever
        begin
            #10 clock = ~clock;
            if(reset == 0 && clock == 1)
                clock_cycles = clock_cycles + 1;
        end
    end
    
    always@(negedge clock)
    begin
    	$display("\n clock cycles = %d,   reset = % h",clock_cycles, reset);
	//IF-----
		$display("-----IF-----\n");
		$display("IF_ADDRESS_FROM_PC           			= % h", CPU.if_address_from_pc);
		$display("IF_INSTRUCTION       					= % h", CPU.if_instruction);
		$display("IF_PC_NEW_ADDRESS    					= % h", CPU.if_pc_new_address);
		$display("IF_PC_STOP  	   						= % h",CPU.if_pc_stop);
		$display("IF_ADDER_RESULT_ADDRESS 				= % h", CPU.if_adder_result_address);	  
		$display("EX_IF_BRANCH_LOCATION_RESULT  	   	= % h",CPU.ex_if_branch_location_result);
		$display("IF_PC_MUX  	   						= % h",CPU.if_pc_mux);
	//ID-----
		$display("-----ID-----\n");
		$display("IF_ID_BUFFER_FLUSH					= % h",CPU.if_id_buffer_flush);
		$display("IF_ID_BUFFER_HOLD        				= % h",CPU.if_id_buffer_hold);
		$display("ID_INSTRUCTION  	       				= % h",CPU.id_instruction);
		$display("ID_PC_NEXT_ADDRESS  	   				= % h",CPU.id_pc_next_address);
		$display("ID_OPCODE  		  	   				= % h",CPU.id_opcode);
		$display("ID_OP1  		  	   	   				= % h",CPU.id_op1);
		$display("ID_OP2				   				= % h",CPU.id_op2);
		$display("ID_IMMEDIATE			  				= % h",CPU.id_immediate);
		$display("ID_FUNCTION_CODE 						= % h",CPU.id_function_code);
		$display("ID_MUX2_OUTPUT		 				= % h",CPU.id_mux2_output);
		$display("ID_MUX2_SELECTOR         				= % h",CPU.id_mux2_selector);
		$display("WB_ID_WRITE_REG          				= % h",CPU.wb_id_write_reg);
		$display("WB_ID_WRITE_DATA         				= % h",CPU.wb_id_write_data);
		$display("ID_READ_DATA_1          				= % h",CPU.id_read_data_1);
		$display("ID_READ_DATA_2           				= % h",CPU.id_read_data_2);
		$display("ID_ALU_OP				   				= % h",CPU.id_alu_op);
		$display("ID_ZERO_EXTENDED_IMMEDIATE			= % h",CPU.id_zero_extended_immediate);
		$display("ID_EX_DATA_MEMORY_WRITE_CONTROL		= % h",CPU.id_ex_data_memory_write_control);
		$display("ID_EX_DATA_MEMORY_BYTE_ENABLE_CONTROL	= % h",CPU.id_ex_data_memory_byte_enable_control);
		$display("ID_EX_REGISTER_WRITE_CONTROL			= % h",CPU.id_ex_register_write_control);
		$display("ID_PC_BRANCH_RESULT					= % h",CPU.id_pc_branch_result);
	

	$display("-----ID/EX Buffer-----");	
		$display("EX_READ_DATA_1						=% h",CPU.ex_read_data_1);
		$display("EX_READ_DATA_2						=% h",CPU.ex_read_data_2);
		$display("ID_ALU_OP								=% h",CPU.id_alu_op);
		$display("ID_EX_DATA_MEMORY_WRITE_CONTROL		=% h",CPU.id_ex_data_memory_write_control);
		$display("EX_MEM_DATA_MEMORY_WRITE_CONTROL		=% h",CPU.ex_mem_data_memory_write_control);
		$display("ID_EX_DATA_MEMORY_BYTE_ENABLE_CONTROL	=% h",CPU.id_ex_data_memory_byte_enable_control);
		$display("ID_EX_REGISTER_WRITE_CONTROL			=% h",CPU.id_ex_register_write_control);
		$display("EX_MEM_REGISTER_WRITE_CONTROL			=% h",CPU.ex_mem_register_write_control);
		$display("CTRL_ID_EX_ALU_OP						=% h",CPU.ctrl_id_ex_alu_op);
		$display("CTRL_EX_ALU_OP						=% h",CPU.ctrl_ex_alu_op);
		$display("EX_PC_BRANCH_RESULT					=% h",CPU.ex_pc_branch_result);
		$display("EX_OP1								=% h",CPU.ex_op1);
		$display("EX_OP2								=% h",CPU.ex_op2);
		$display("EX_FUNCTION_CODE						=% h",CPU.ex_function_code);
		$display("EX_OPCODE								=% h",CPU.ex_opcode);
		
		
				
    $display("-----EX-----");
		//$display("			=% h",CPU.);
		$display("MEM_EX_FORWARDED_ALU_OUTPUT			=% h",CPU.mem_ex_forwarded_alu_output);
		$display("WB_EX_WRITE_DATA						=% h",CPU.wb_ex_write_data);
		$display("EX_FUNCT_CODE_SIGN_EXTENDED			=% h",CPU.ex_funct_code_sign_extended);
		$display("EX_MUX_A_OUTPUT						=% h",CPU.ex_mux_a_output);
		$display("EX_MUX_B_OUTPUT						=% h",CPU.ex_mux_b_output);
		$display("EX_MEM_ALU_OUTPUT						=% h",CPU.ex_mem_alu_output);
		$display("EX_MEM_ALU_R0_RESULT					=% h",CPU.ex_mem_alu_r0_result);
		$display("FORWARD_A								=% h",CPU.forward_a);
		$display("FORWARD_B								=% h",CPU.forward_b);
		$display("EX_CTRL_ALU_BRANCH_RESULT				=% h",CPU.ex_ctrl_alu_branch_result);
		$display("EX_MEM_REG_WRT_CTRL_FLUSH				=% h",CPU.ex_mem_reg_wrt_ctrl_flush);
		$display("EX_CTRL_ALU_OVERFLOW_FLAG				=% h",CPU.ex_ctrl_alu_overflow_flag);
		$display("EX_MEM_DATA_MEM_WRT_CTRL				=% h",CPU.ex_mem_data_mem_wrt_ctrl);
		$display("EX_MEM_DATA_MEM_BYTE_CTRL				=% h",CPU.ex_mem_data_mem_byte_ctrl);
		$display("EX_ALU_OP_CTRL						% h",CPU.ex_alu_op_ctrl);
		$display("CTRL_EX_FLUSH							=% h",CPU.ctrl_ex_flush);

    
    
	$display("-----EX/MEM buffer-----");
		$display("MEM_WB_REG_WRT_CTRL_FLUSH				=% h",CPU.mem_wb_reg_wrt_ctrl_flush);
		$display("MEM_WB_DATA_MEM_WRT_CTRL				=% h",CPU.mem_wb_data_mem_wrt_ctrl);
		$display("MEM_WB_ALU_R0_RESULT					=% h",CPU.mem_wb_alu_r0_result);
		$display("MEM_WB_ALU_OUTPUT						=% h",CPU.mem_wb_alu_output);
		$display("MEM_OP1								=% h",CPU.mem_op1);	
	
	$display("-----M-----");
		$display("MEM_WB_DATA_LINE						=% h",CPU.mem_wb_data_line);
		
		
	$display("-----MEM/WB buffer-----");
		$display("WB_DATA_LINE							=% h",CPU.wb_data_line);
		$display("WB_ALU_OUTPUT							=% h",CPU.wb_alu_output);
		$display("MUX_C_WB_DATA_CTRL					=% h",CPU.mux_c_wb_data_ctrl);
	
    
    $display("-----WB-----");
		$display("WB_DATA_LINE							=% h",CPU.wb_data_line);
		$display("wb_alu_output							=% h",CPU.wb_alu_output);
		$display("MUX_C_WB_DATA_CTRL					=% h",CPU.mux_c_wb_data_ctrl);
		$display("WB_ID_WRITE_DATA						=% h",CPU.wb_id_write_data);

    
    $display("-----CONTROL_UNIT-----");
    
    
    $display("-----ALU_CONTROL-----");
    
    
    $display("-----FORWARDING_UNIT-----");
    
    
    $display("-----BRANCH_CONTROL-----");
    
    
    $display("-----HAZARD_UNIT-----");
		$display("MUX_C_EX_CTRL							=% h",CPU.mux_c_ex_ctrl);
		$display("ID_OP1								=% h",CPU.id_op1);
		$display("EX_OP1								=% h",CPU.ex_op1);
		$display("ID_OP2								=% h",CPU.id_op2);
		$display("ED_OP2								=% h",CPU.ed_op2);
		$display("ID_FLUSH								=% h",CPU.id_flush);
		$display("PC_STOP								=% h",CPU.pc_stop);
		$display("IF_ID_BUFFER_FLUSH					=% h",CPU.if_id_buffer_flush);
;
		
    
    //if(function code error)
    //  display "ERROR unknown function code"
    //if(operation code error)
    //  display "ERROR unknown opcode" 
    //if(HALT)
    //  display "Program HALT"      
    end
    
    initial begin
        reset = 1;
        #20
        reset = 0;
        #40 
        
        #40
        //#620
        $finish;
    end
                   
endmodule
