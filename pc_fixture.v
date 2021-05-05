`include "program_counter.v"

module pc_fixture();
	reg [15:0] pc_new_address;
	reg pc_stop, clock, reset;

	wire [15:0] instruction_address;

	program_counter g1 (
		.pc_new_address(pc_new_address),
		.pc_stop(pc_stop),
		.clock(clock),
		.reset(reset),
		.instruction_address(instruction_address)
		);

	initial begin
		clock = 1'b0;
		forever #10 clock = ~clock;
		
	end

	initial begin
		reset = 1'b1;
		#20;
		reset = ~reset;
		#20;
		pc_stop = 0;

		pc_new_address = 16'h1111;
		#20;
		pc_new_address = 16'habcd;
		#100;
		$finish;
	end
	
	always@(negedge clock) begin
		$display ("new = %h", pc_new_address);
$display("next = %h", instruction_address);
$display("stop = %h", pc_stop);
	end
	
endmodule
