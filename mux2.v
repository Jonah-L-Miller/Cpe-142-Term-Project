module mux2(in1,in2, out, s);
	input [15:0] in1, in2;
	input s;
	
	output reg [15:0] out;
	
	always@(*)
		if (s)
			out = in1;
		else
			out = in2;
endmodule