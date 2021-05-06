`include "mux5.v"
module mux4_fixture();
	reg [15:0] in1, in2, in3, in4, in5;
	reg [1:0] s;
	
	wire [15:0] out;
	
	mux4 uut(
		.in1(in1),
		.in2(in2),
		.in3(in3),
		.in4(in4),
		.in5(in5),
		.s(s),
		.out(out)
    );
    
    initial 
    begin
		in1 = 16'h ABCD;
		in2 = 16'h 0123;
		in3 = 16'h 0000;
		in4 = 16'h 4567;
		in5 = 16'h 89EF;
		s = 2'b00;
		
    end
    
	always@(s) begin
		#3;
		$display("IN1  = %h", uut.in1);
		$display("IN2  = %h", uut.in2);
		$display("IN3  = %h", uut.in3);
		$display("IN4  = %h", uut.in4);
		$display("IN5  = %h", uut.in5);
		$display("S    = %h", uut.s);
		$display("OUT  = %h", uut.out);
		$display("---------\n\n");
	end
    initial begin
		#10;	//in1
		#10 s = 3'b000;	//in1
		#10 s = 3'b001;	//in2
		#10 s = 3'b010;	//in3
		#10 s = 3'b011;	//in4
		#10 s = 3'b100;	//in5
		#10;
        $finish;
    end
                   
endmodule
