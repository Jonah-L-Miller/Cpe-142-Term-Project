module zero_extend #(parameter N = 12)(
	input [N-1:0] in,
	output reg [15:0] out
	);
	
	always@(*) begin
		out = {16'b 0000000000000000, in} [15:0]
	end
	
endmodule