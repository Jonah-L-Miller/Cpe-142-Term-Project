`include "cpu.v"

module cpu_fixture();

    reg clk, reset;
    integer clock_cycles;
    
    initial 
        $vcdpluson;
    
    cpu CPU (
        .clk(clk),
        .reset(reset)
    );
    
    initial 
    begin
        clock_cycles = 0;
        clk = 0;
        forever
        begin
            #10 clk = ~clk;
            if(reset == 1 && clk == 1)
                clock_cycles = clock_cycles + 1;
        end
    end
    
    always@(negedge clk)
    begin
    $display("\n clock cycles = %d,   reset = %h",clock_cylces, reset);
    $display("-----IF-----");
    $display("IF_FROM_PC           = %h", CPU.if_from_pc);
    $display("IF_INSTRUCTION       = %h", CPU.if_instruction);
    
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
        reset = 1;
        
        #620
        $finish;
    end
                   
endmodule
