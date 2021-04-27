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
    $display("-----IF-----");
    $display("IF_FROM_PC           = %h", CPU.if_from_pc);
    $display("IF_INSTRUCTION       = %h", CPU.if_instruction);
    $display("IF_PC_NEW_ADDRESS    = %h", CPU.if_pc_new_address);
    $display("IF_INSTRUCTION_ADDRESS = %h",CPU.if_instruction_address);
    $display("IF_PC_STOP  	   = %h",CPU.if_pc_stop);
    $display("IF_ADDER_RESULT_ADDRESS = %h", CPU.if_adder_result_address);	    
    $display("-----ID-----");
    
    
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
        
        
        #620
        $finish;
    end
                   
endmodule
