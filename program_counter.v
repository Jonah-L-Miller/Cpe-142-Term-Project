module program_counter (
	input [15:0] pc_new_address,
	input pc_stop, clock, reset,
	
	output reg [15:0] instruction_address
	);
	
	always@(posedge clock or negedge reset) begin
		if (reset)
			instruction_address = 16'h 0000;
		else begin
			if (pc_stop)
				instruction_address = instruction_address;
			else
				instruction_address = pc_new_address;
		end
	end
endmodule