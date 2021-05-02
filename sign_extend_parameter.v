module sign_extend #(parameter N = 12)(
	input [N-1:0] in,
	output reg [15:0] out
	);
	reg [0:0] one;	
	always@(*) begin
		one = 1;
		out = {{16,one}, in};
	end
	
endmodule
