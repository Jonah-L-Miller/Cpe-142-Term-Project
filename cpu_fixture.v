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
    $display("-----IF-----");
		$display("IF_ADDRESS_FROM_PC           = %h", CPU.if_address_from_pc);
		$display("IF_INSTRUCTION       = %h", CPU.if_instruction);
		$display("IF_PC_NEW_ADDRESS    = %h", CPU.if_pc_new_address);
		$display("IF_PC_STOP  	   = %h",CPU.if_pc_stop);
		$display("IF_ADDER_RESULT_ADDRESS = %h", CPU.if_adder_result_address);	  
		$display("EX_IF_BRANCH_LOCATION_RESULT  	   = %h",CPU.ex_if_branch_location_result);
		$display("IF_PC_MUX  	   = %h",CPU.if_pc_mux);
	//ID-----
    $display("-----ID-----");
		$display("IF_ID_BUFFER_FLUSH       = %h",CPU.if_id_buffer_flush);
		$display("IF_ID_BUFFER_HOLD        = %h",CPU.if_id_buffer_hold);
		$display("ID_INSTRUCTION  	       = %h",CPU.id_intruction);
		$display("ID_PC_NEXT_ADDRESS  	   = %h",CPU.id_pc_next_address);
    
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
