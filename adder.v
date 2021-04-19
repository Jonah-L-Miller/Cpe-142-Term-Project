module adder (in1, in2, out);
	input [15:0] in1, in2;
	
	output reg [15:0] out;
	
	always@ (*)
		out = in1 + in2;
endmodule
// ACTION LOG
// ACTION     DATE     USER
// -----------------------------
// COMPILE01  4-18-21  PAYNE
//
// --------------------
