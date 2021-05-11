module alu(	input signed [15:0] in1, in2, 
			input [3:0] ctrl,
			input reset,
			output reg signed[15:0] out, r0,
			output reg overflow_flag	//OVERFLOW FLAG		
		); //compiles, hPAYNE (4/18/21)

	
	always@(*) begin	//falling edge of clock?
	
		if (!reset)
			{out, r0, overflow_flag} = 0;
			
		case (ctrl)	
			4'h 1: begin
				{overflow_flag, out} = in1 + in2;		//0001
				
				//overflow_flag = 1'b1;
			end
			4'h 2:	out = in1 - in2;		//0010
			4'h 4:	{r0, out} = in1 * in2;  //0100
			4'h 8:	begin //1000
				out = in1 / in2;	//quotient
				r0 = in1 % in2;		//remainder
			end			
			
			4'h C: out = in1 & in2;	//1100 ANDI
		//	4'h D:	//1101 
			4'h E: out = in1 | in2;	//1110 ORI
			4'h F: out = in1 + in2;	//1111 ADD NO FUNC
			default: out = out;
		endcase
		
		if (!overflow_flag) begin
			if (in1 > 0)	//in1 positive
				if (in2 > 0) //in2 positive
					if (out < 0 && (ctrl == 4'h 1 || ctrl == 4'h 4 || ctrl == 4'h8 || ctrl == 4'h F))	//output is negative for add, mult, div
						overflow_flag = 1'b1;
					else
						overflow_flag = 1'b0;
				else	//in2 negative
					if (out < 0 && ctrl == 4'h2)	//if in1 - (-in2)<0
						overflow_flag = 1'b1;
					else
						overflow_flag = 1'b0;
			else //in1 negative
				if (in2 < 0)
					if(ctrl == 4'h4 || ctrl == 4'h8) && out < 0)	//in2/out negative for mult/divide
						overflow_flag = 1'b1;
					else
						overflow_flag = 1'b0;
				else	//in1 neg, in2 pos
					
				
		end
		

	end
endmodule
/*_________________ACTION LOG_______________*/
/*______ACTION__________DATE____________USER*/
/*---___---___---___---___---___---___---___*/
//	COMPILE		4-18-21		PAYNE
//
/*---___---___---___---___---___---___---___*/
