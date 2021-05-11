module mux2 #(parameter N = 16)(
			input [N-1:0] in1,in2, 
			input s,
			output reg [N-1:0] out);
	
	always@(*)
		if (!s)
			out <= in1;
		else
			out <= in2;
endmodule
// ACTION LOG
// ACTION     DATE     USER
// ----------------------------
// COMPILE01  4-18-21  PAYNE
//
// ----------------------------
