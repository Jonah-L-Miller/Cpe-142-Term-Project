`include "zero_extend_parameter.v"
module fixture_zero_extend();
	reg [7:0] in;
	wire [15:0] out;
	
	integer i;
	zero_extend #(.N(8)) UUT(
		.in(in),
		.out(out)
	);
	
	initial
		in = 8'hbd;
		
	always@(in) begin
		#3;
		$display("IN  = %h", UUT.in);
		$display("OUT  = %h", UUT.out);
		$display("---------\n\n");
	end
	
	initial begin
		#10;
		
		for (i=0; i<255; i=i+25)
			#10 in = i;
			
		#10 $finish;
	end
endmodule