`include "alu_op.v"
module fixture_alu_op();
	reg [3:0] func;
	reg [1:0] op;
	
	wire [3:0] out;
	
	alu_ctrl uut(
		.func(func),
		.op(op),
		.out(out)
	);
	
	initial
		{func, op} = 0;
	
	always@(*) begin
		#3;
		$display("\n=========");
		$display("FUNC = %b", uut.func);
		$display("OP   = %b", uut.op);
		$display("OUT  = %b", uut.out);
		
	end
	
	initial begin
		#10 ;
		
		#10 func = 4'b 1111;
		#10 op = 2'b 01;
		
		#10 func = 4'b 0101;
		#10 op = 2'b 01;
		
		#10 func = 4'b 1010;
		#10 op = 2'b 01;
		
		#10 func = 4'b 0000;
		#10 op = 2'b 01;
		//----------------------
		#10 func = 4'b 0001;
		#10 op = 2'b 00;
		
		#10 func = 4'b 0001;
		#10 op = 2'b 11;
		
		#10 func = 4'b 0001;
		#10 op = 2'b 10;
		
		#10 func = 4'b 0001;
		#10 op = 2'b 01;
		
	end
endmodule