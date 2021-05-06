`include "buffer.v"
module fixture_buffer();
	reg clk, reset, flush, hold;
	reg [31:0] buffer_in;
	
	wire [31:0] buffer_out;
	
	buffer #(.N(32)) uut(
		.clock(clk),
		.reset(reset),
		.flush(flush),
		.hold(hold),
		.buffer_in(buffer_in),
		.buffer_out(buffer_out)
	);
	
	initial
		{clk, reset, flush, hold, buffer_in} = 0;
	
	initial
		forever #5 clk = ~clk;
		
	always@(posedge clk) begin
		#3;
		$display("\n==============\n");
		$display("reset      = %h", uut.reset);
		$display("flush      = %h", uut.flush);
		$display("hold       = %h", uut.hold);
		$display("buffer_in  = %h", uut.buffer_in);
		$display("buffer_out = %h", uut.buffer_out);
		$display("insert_bubble = %h", uut.insert_bubble);
	end
	
	initial begin
		reset = 1'b1;
		
		#10 reset = 1'b0;
		#10 reset = 1'b1;
		#10;
		#10 buffer_in = 32'h abcdef12;
		#10 buffer_in = 32'h 12345678;
		#10 buffer_in = 32'h 12121212;
		#10;
		#10 flush = 1'b1;
		#10 flush = 1'b0;
		#10;
		#10 buffer_in = 32'h abcdef12;
		#10 buffer_in = 32'h 12345678;
		#10 buffer_in = 32'h 12121212;
		#10;
		#10 hold = 1'b1;
		#10;
		#10 buffer_in = 32'h abcdef12;
		#10 buffer_in = 32'h 12345678;
		#10 buffer_in = 32'h 12121212;
		#10;
		#40 hold = 1'b0;
		#10;
		#10 $finish;
	end
endmodule