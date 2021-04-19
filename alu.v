module alu(in1, in2, out, r0, con); //compiles, hPAYNE (4/18/21)
	input [15:0] in1, in2;
	input [3:0] con;
	
	output reg [15:0] out, r0;
	
	always@(*) begin	//falling edge of clock?
		case (con)
			4'h 1:	out = in1 + in2;	//0001
			4'h 2:	out = in1 - in2;	//0010
			4'h 4:	 //0100
				{r0, out} = in1 * in2;
			4'h 8:	begin //1000
				out = in1 / in2;	//quotient
				r0 = in1 % in2;		//remainder
			end			
			4'h C: out = in1 & in2;	//1100 ANDI
		//	4'h D:	//1101 
			4'h E: out = in1 | in2;	//1110 ORI
			4'h F: out = in1 + in2;	//1111 ADD NO FUNC
			
		endcase
	end
endmodule
/*_________________ACTION LOG_______________*/
/*______ACTION__________DATE____________USER*/
/*---___---___---___---___---___---___---___*/
//	COMPILE		4-18-21		PAYNE
//
/*---___---___---___---___---___---___---___*/
