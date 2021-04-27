`timescale 1ns / 1ps

module instruction_memory_tb();
integer i;
reg [15:0] if_adder;
reg clk;
wire [15:0] if_instruction;

instruction_memory uut(if_adder,if_instruction);

initial clk = 1;
always #10 clk=~clk;
always@(posedge clk) begin
    if_adder = 0;
    for(i=0;i<=8'h3E;i = i +2)begin
        #10
        if_adder =+ i; 
    end
    #40
    $stop;
end
endmodule
