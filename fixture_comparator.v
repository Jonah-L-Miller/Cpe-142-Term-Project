`include "comparator.v"
module fixture_comparator();
	reg signed [15:0] in1, in2;
	wire [1:0] out;
	
	comparator uut(
		.in1(in1),
		.in2(in2),
		.result(out)
	);
	
	initial begin
		in1 = 16'h 0000;
		in2 = 16'h 0000;
	end
	
	always@(*) begin
		#3;
		$display ("IN1    =    %h", uut.in1);
		$display ("IN2    =    %h", uut.in2);
		$display ("RESULT =    %b", uut.result);
		$display ("==============\n\n");		
	end
	
	initial begin
		#10;
		//POSITIVE
		in1 = 16'h 000A;//1>2
		in2 = 16'h 0008;
		#10;
		
		in1 = 16'h 0002;//1<2
		in2 = 16'h 0110;
		#10;
		
		in1 = 16'h 012C;//1=2
		in2 = 16'h 012C;
		#10;
		
		//NEGATIVE
		in1 = 16'h FFBA;//1>2
		in2 = 16'h FF88;
		#10;
		
		in1 = 16'h FF38;//1<2
		in2 = 16'h FFC4;
		#10;
		
		in1 = 16'h FFA6;//1=2
		in2 = 16'h FFA6;
		#10;
		
		
		//MIX
		in1 = 16'h 0078;//1>2
		in2 = 16'h FFF1;
		#10;
		
		in1 = 16'h FFF3;//1<2
		in2 = 16'h 0016;
		#10;
		
		#10 $finish;
	end
endmodule