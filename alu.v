module alu(in1, in2, out, r0, con);
	input [15:0] in1, in2;
	input [3:0] con;
	
	output reg [15:0] out, r0;
	
	always@(*) begin	//falling edge of clock?
		carry = 32'h 0000;
		case (con)
			4'h 1:	out = in1 + in2;	//0001
			4'h 2:	out = in1 - in2;	//0010
			4'h 4:	 //0100
				{r0, out} = in1 * in2;
			4'h 8:	begin //1000
				out = in1 / in2;	//quotient
				r0 = in1 % in2;		//remainder
			end			
			4'h C:	//1100
			4'h D:	//1101
			4'h E:	//1110
			4'h F:	//1111
			
		endcase
	end
endmodule