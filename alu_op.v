module alu_op(func, op, out);
	input [3:0] func;
	input [1:0] op;
	
	output reg [3:0] out;
	
	always@(*) begin
		if op = '01'
			out = func;
		else
			out = {2'b 11, op};
	end
endmodule