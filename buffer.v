module buffer #(parameter N = 32)(
		input clock, reset, flush, hold,
		input [N-1:0] buffer_in,
		output reg [N-1:0] buffer_out
	);
	
	integer i;
	reg insert_bubble = 0;
	
	always@(posedge clock or negedge reset) begin
		if (!reset || insert_bubble) begin
			if (!reset)
				insert_bubble <= 1'b0;
				
		
				buffer_out <= 0;
		end
		else if (hold)
			buffer_out <= buffer_out;
		else
			buffer_out <= buffer_in;
			
		if (flush) 
				insert_bubble <= 1'b1;
	end
endmodule