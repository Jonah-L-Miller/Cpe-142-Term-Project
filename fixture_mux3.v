`include "mux3.v"
module mux3_fixture();
	reg [15:0] in1, in2, in3;
	reg [1:0] s;
	
	wire [15:0] out;
	
	mux3 uut(
		.in1(in1),
		.in2(in2),
		.in3(in3),

		.s(s),
		.out(out)
    );
    
    initial 
    begin
		in1 = 16'h ABCD;
		in2 = 16'h 0123;
		in3 = 16'h 0000;

		s = 2'b00;
		
    end
    
	always@(s) begin
		#3;
		$display("IN1  = %h", uut.in1);
		$display("IN2  = %h", uut.in2);
		$display("IN3  = %h", uut.in3);
		$display("S    = %h", uut.s);
		$display("OUT  = %h", uut.out);
		$display("---------\n\n");
	end
    initial begin
		#10;	//in1
		#10 s = 2'b01;	//in2
		#10 s = 2'b10;	//in3
		#10 s = 2'b11;	//nothing
		#10 s = 2'b00;	//in1
		#10;
        $finish;
    end
                   
endmodule