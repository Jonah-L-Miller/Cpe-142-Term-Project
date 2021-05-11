module sign_extend #(parameter N = 12)(
	input [N-1:0] in,
	output reg [15:0] out
	);
	
	reg [32:0] temp;
	reg load;
	
	always@(*) begin
		load = in[N-1];
		temp = {{16{load}},in};
		out = temp [15:0];
	end
	
endmodule