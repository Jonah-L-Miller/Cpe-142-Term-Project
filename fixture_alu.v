`include "alu.v"
module fixture_alu();
	reg signed [15:0] in1, in2;
	reg [3:0] ctrl;
	reg r;
	
	wire signed [15:0] out, r0;
	wire overflow_flag;
	
	alu bub(
		.in1(in1),
		.in2(in2),
		.ctrl(ctrl),
		.out(out),
		.r0(r0),
		.overflow_flag(overflow_flag),
		.reset(r)
	);
	
	initial begin
		in1 = 16'h 0000;
		in2 = 16'h 0000;
		
		ctrl = 4'b 0000;
		r = 1'b1;
	end
	
	always@(*) begin
		#3;
		$display("===============\n\n");
		$display("IN1        = %b (%d)", bub.in1,bub.in1);
		$display("IN2        = %b (%d)", bub.in2,bub.in2);
		$display("CTRL       = %h", bub.ctrl);
		$display("R0         = %b (%d)", bub.r0,bub.r0);
		$display("OUT        = %b (%d)", bub.out,bub.out);
		$display("OVER_FLOW  = %b (%d)", bub.overflow_flag,bub.overflow_flag);

	end
	
	initial begin
		#5 r = !r;
			//pos, pos
			
		#10;
		in1 = 16'h 7fff;
		in2 = 16'h 0030;
		ctrl = 4'h 1;	//add
		
		#10;
		in1 = 16'h 0000;
		in2 = 16'h ffff;
		ctrl = 4'h 2;	//sub
		
		#10;
		in1 = 16'h 000a;
		in2 = 16'h 0006;
		ctrl = 4'h 4;	//mut
		
		#10;
		in1 = 16'h 000a;
		in2 = 16'h 0002;
		ctrl = 4'h 8;	//div
		
		#10;
		in1 = 16'h 000a;
		in2 = 16'h 0006;
		ctrl = 4'h C;	//andi
		
		#10;
		in1 = 16'h 000a;
		in2 = 16'h 0006;
		ctrl = 4'h e;	//ori
		
		#10;
		in1 = 16'h 000a;
		in2 = 16'h 0006;
		ctrl = 4'h f;	//add no func
		
		#10;
		in1 = 16'h ffff;
		in2 = 16'h 0001;
		ctrl = 4'h2;	//add of
			
			//pos, neg
		#10;
		in1 = 16'h 000a;
		in2 = 16'h fff6;
		ctrl = 4'h 1;	//add
		
		#10;
		in1 = 16'h 000a;
		in2 = 16'h fff6;
		ctrl = 4'h 2;	//sub
		
		#10;
		in1 = 16'h 000a;
		in2 = 16'h fff6;
		ctrl = 4'h 4;	//mut
		
		#10;
		in1 = 16'h 000a;
		in2 = 16'h fff6;
		ctrl = 4'h 8;	//div
		
		#10;
		in1 = 16'h 000a;
		in2 = 16'h fff6;
		ctrl = 4'h C;	//andi
		
		#10;
		in1 = 16'h 000a;
		in2 = 16'h fff6;
		ctrl = 4'h e;	//ori
		
		#10;
		in1 = 16'h 000a;
		in2 = 16'h fff6;
		ctrl = 4'h f;	//add no func
		
		#10;
		in1 = 16'h 000a;
		in2 = 16'h fff6;
		ctrl = 4'h 2;	//sub
		
			//neg neg
		#10;
		in1 = 16'h fffb;
		in2 = 16'h fff6;
		ctrl = 4'h 1;	//add
		
		#10;
		in1 = 16'h fffb;
		in2 = 16'h fff6;
		ctrl = 4'h 2;	//sub
		
		#10;
		in1 = 16'h fffb;
		in2 = 16'h fff6;
		ctrl = 4'h 4;	//mut
		
		#10;
		in1 = 16'h fffb;
		in2 = 16'h fff6;
		ctrl = 4'h 8;	//div
		
		#10;
		in1 = 16'h fffb;
		in2 = 16'h fff6;
		ctrl = 4'h C;	//andi
		
		#10;
		in1 = 16'h fffb;
		in2 = 16'h fff6;
		ctrl = 4'h e;	//ori
		
		#10;
		in1 = 16'h fffb;
		in2 = 16'h fff6;
		ctrl = 4'h f;	//add no func
		
			//neg pos
		#10;
		in1 = 16'h fffb;
		in2 = 16'h 0005;
		ctrl = 4'h 1;	//add
		
		#10;
		in1 = 16'h fffb;
		in2 = 16'h 0005;
		ctrl = 4'h 2;	//sub
		
		#10;
		in1 = 16'h fffb;
		in2 = 16'h 0005;
		ctrl = 4'h 4;	//mut
		
		#10;
		in1 = 16'h fffb;
		in2 = 16'h 0005;
		ctrl = 4'h 8;	//div
		
		#10;
		in1 = 16'h fffb;
		in2 = 16'h 0005;
		ctrl = 4'h C;	//andi
		
		#10;
		in1 = 16'h fffb;
		in2 = 16'h 0005;
		ctrl = 4'h e;	//ori
		
		#10;
		in1 = 16'h fffb;
		in2 = 16'h 0005;
		ctrl = 4'h f;	//add no func
		
		#10 $finish;
	end
endmodule