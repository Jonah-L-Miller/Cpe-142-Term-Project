`include "program_counter.v"
module fixture_program_counter();
	reg [15:0] pc_new_address;
	reg pc_stop, clock, reset;
	
	wire [15:0] instruction_address;
	
	integer i;
	
	program_counter uut(
		.pc_new_address(pc_new_address),
		.clock(clock),
		.reset(reset),
		.instruction_address(instruction_address),
		.pc_stop(pc_stop)
	);
	
	initial
		{pc_new_address,pc_stop,clock, reset} = 0;
		
	initial
		forever #5 clock = ~clock;
		
	always@(posedge clock) begin
		#3;
		$display("\n======\n");
		$display("reset = %h", uut.reset);
		$display("pc_new_address = %h", uut.pc_new_address);
		$display("instruction_address = %h", uut.instruction_address);
		$display("pc_stop = %h", uut.pc_stop);
	end
	
	initial begin
		reset = 1;
		#10 reset = 0;
		#10 reset = 1;
		
		for (i=0;i<10;i=i+1)
			#10 pc_new_address = i;
			
		#10 pc_stop = 1;
		
		for (i=0;i<10;i=i+1)
			#10 pc_new_address = i;
			
		#10 $finish;
	end
endmodule