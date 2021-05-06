`include "left_shift.v"
module fixture_left_shift();
	reg [15:0] in;
	wire [15:0] out;
	integer i;
	left_shift uut(
		.in(in),
		.out(out)
	);
	
	initial
		in = 0;
	
	always@(in) begin
		#3;
		$display("\n=====\n");
		$display("in = %h", uut.in);
		$display("in = %d", uut.in);
		$display("out = %h", uut.out);
		$display("out = %d", uut.out);
	end
	
	initial begin
		for (i=0;i<15;i=i+1)
			#10 in = i;
		#10 $finish;
	end
endmodule