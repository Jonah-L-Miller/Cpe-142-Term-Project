module mux3(in1,in2, in3, out, s);
	input [15:0] in1, in2, in3
	input [1:0]s;
	
	output reg [15:0] out;
	
	always@(*)
		case (s)
			2'b 00: out = in1;
			2'b 01: out = in2;
			2'b 10: out = in3;
			
			default: out = out;
		endcase
endmodule