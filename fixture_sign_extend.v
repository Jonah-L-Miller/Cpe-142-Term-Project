`include "sign_extend_parameter.v"
module fixture_sign_extend();
	reg [7:0] in;
	wire [15:0] out;
	
	integer i;
	
	sign_extend #(.N(8)) uut(
		.in(in),
		.out(out)
	);
	
	initial
		in = 8'h 0;
		
	always@(in) begin
		#3;
		$display("IN  = %h", uut.in);
		$display("OUT = %h", uut.out);
		$display("========\n\n");
	end
	
	initial begin
		#10; 
		for(i = 0; i<255; i = i+25)
			#10 in = i;
		
		#10 $finish;
	end
endmodule