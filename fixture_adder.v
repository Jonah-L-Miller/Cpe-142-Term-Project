`include "adder.v"
module fixture_adder();
	reg [15:0] in1, in2;
	wire [15:0] out;
	
	integer i, j;
	adder UUT(
		.in1(in1),
		.in2(in2),
		.out(out)
	);
	
	initial begin
		in1 = 16'h 0000;
		in2 = 16'h 0001;
	end
	
	always@(*) begin
		#3;
		$display("IN1 =     %h", UUT.in1);
		$display("IN2 =     %h", UUT.in2);
		$display("OUT =     %h", UUT.out);
		$display("============\n");
	end
	
	initial begin
		#10;
		for (i=0;i<16; i = i+2) begin
			in1 = i;
			for (j = 0; j < 16; j = j + 5) begin
				in2 = j;
				#10;
			end
		end
		#10 $finish;
	end
endmodule