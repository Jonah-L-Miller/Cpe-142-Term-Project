module sign_extend #(parameter N = 12)(
	input [N-1:0] in,
	output reg [15:0] out
	);
	reg [31:0] temp = 32'h 00000000;
	always@(*) begin
	
		temp = {16'b 111111111111111, in} [15:0];
		
		out = temp [15:0];
	end
	
endmodule