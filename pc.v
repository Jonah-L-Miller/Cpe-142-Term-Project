module pc (in_addr, out_addr, pc_pause, clk);
	input [15:0] in_addr;
	output reg [15:0] out_addr;
	
	always@(clk) begin
		if (pc_pause)
			out_addr = out_addr;
		else
			out_addr = in_addr;
	end
endmodule