`include "mux2.v"
module mux2_fixture();
	reg [15:0] in1, in2, in3;
	reg s;
	
	wire [15:0] out;
	
	mux2 uut(
		.in1(in1),
		.in2(in2),

		.s(s),
		.out(out)
    );
    
    initial 
    begin
		in1 = 16'h ABCD;
		in2 = 16'h 0123;

		s = 1'b0;
		
    end
    
	always@(s) begin
		#3;
		$display("IN1  = %h", uut.in1);
		$display("IN2  = %h", uut.in2);
		$display("S    = %h", uut.s);
		$display("OUT  = %h", uut.out);
		$display("---------\n\n");
	end
    initial begin
		#10;	//in1
		#10 s = 1'b1;	//in2

		#10 s = 1'b0;	//in1
		#10;
        $finish;
    end
                   
endmodule