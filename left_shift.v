module left_shift (
	input [15:0] in,
	output reg [15:0] out
	);
	
	always@(*)
		out = in << 1;
		
endmodule