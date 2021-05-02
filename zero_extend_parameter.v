module zero_extend #(parameter N = 12)(
	input [N-1:0] in,
	output reg [15:0] out
	);
	
	reg [32:0] temp = 32'h00000000;
	
	always@(*) begin
		temp = {16'h0000, in};
		out = temp [15:0];
	end
	
endmodule