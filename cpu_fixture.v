`include "cpu.v"

module cpu_fixture();

    reg clock, reset;
    integer clock_cycles;
    
    initial 
        $vcdpluson;
    
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
    	$display("\n clock cycles = %d,   reset = %h",clock_cycles, reset);
	//IF-----
		$display("-----IF-----\n");
		$display("IF_ADDRESS_FROM_PC           = %h", CPU.if_address_from_pc);
		$display("IF_INSTRUCTION       = %h", CPU.if_instruction);
		$display("IF_PC_NEW_ADDRESS    = %h", CPU.if_pc_new_address);
		$display("IF_PC_STOP  	   = %h",CPU.if_pc_stop);
		$display("IF_ADDER_RESULT_ADDRESS = %h", CPU.if_adder_result_address);	  
		$display("EX_IF_BRANCH_LOCATION_RESULT  	   = %h",CPU.ex_if_branch_location_result);
		$display("IF_PC_MUX  	   = %h",CPU.if_pc_mux);
	//ID-----
		$display("-----ID-----\n");
		$display("IF_ID_BUFFER_FLUSH       				= %h",CPU.if_id_buffer_flush);
		$display("IF_ID_BUFFER_HOLD        				= %h",CPU.if_id_buffer_hold);
		$display("ID_INSTRUCTION  	       				= %h",CPU.id_intruction);
		$display("ID_PC_NEXT_ADDRESS  	   				= %h",CPU.id_pc_next_address);
		$display("ID_OPCODE  		  	   				= %h",CPU.id_opcode);
		$display("ID_OP1  		  	   	   				= %h",CPU.id_op1);
		$display("ID_OP2				   				= %h",CPU.id_op2);
		$display("ID_IMMEDIATE			   				= %h",CPU.id_immdediate);
		$display("ID_FUNCTION_CODE         				= %h",CPU.id_function_code);
		$display("ID_MUX2_OUTPUT		   				= %h",CPU.id_mux2_output);
		$display("ID_MUX2_SELECTOR         				= %h",CPU.id_mux2_selector);
		$display("WB_ID_WRITE_REG          				= %h",CPU.wb_id_write_reg);
		$display("WB_ID_WRITE_DATA         				= %h",CPU.wb_id_write_data);
		$display("WB_ID_WRITE_R0           				= %h",CPU.wb_id_write_r0);
		$display("ID_READ_DATA_1           				= %h",CPU.id_read_data_1);
		$display("ID_READ_DATA_2           				= %h",CPU.id_read_data_2);
		$display("ID_ALU_OP				   				= %h",CPU.id_alu_op);
		$display("ID_ZERO_EXTENDED_IMMEDIATE			= %h",CPU.id_zero_extended_immediate);
		$display("ID_EX_DATA_MEMORY_WRITE_CONTROL		= %h",CPU.id_ex_data_memory_write_control);
		$display("ID_EX_DATA_MEMORY_BYTE_ENABLE_CONTROL	= %h",CPU.id_ex_data_memory_byte_enable_control);
		$display("ID_EX_REGISTER_WRITE_CONTROL			= %h",CPU.id_ex_register_write_control);
		$display("ID_PC_BRANCH_RESULT					= %h",CPU.id_pc_branch_result);
		
		
		
		
		
    $display("-----EX-----");
    
    
    $display("-----M-----");
    
    
    $display("-----WB-----");
    
    
    $display("-----CONTROL_UNIT-----");
    
    
    $display("-----ALU_CONTROL-----");
    
    
    $display("-----FORWARDING_UNIT-----");
    
    
    $display("-----BRANCH_CONTROL-----");
    
    
    $display("-----HAZARD_UNIT-----");
    
    
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
        
        #60
        //#620
        $finish;
    end
                   
endmodule
