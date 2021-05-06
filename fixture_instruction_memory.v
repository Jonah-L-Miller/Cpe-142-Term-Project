`include "instruction_memory.v"
module fixture_instruction_memory();
	integer i;
	reg [15:0] from_pc;
	wire [15:0] instruction;
	
	instruction_memory uut(
		.from_pc(from_pc),
		.instruction(instruction)
	);
	
	initial
		from_pc = 0;
	
	always@(*) begin
		#3;
		$display("\n=====\n");
		$display("from_pc = %h", uut.from_pc);
		$display("instruction = %h", uut.instruction);
	end
	
	initial begin
		for (i=0;i<40;i = i+1)
			#10 from_pc = 2*i;
	end

endmodule
