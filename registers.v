module registers(
	input [3:0] read_reg1, read_reg2,
	input [3:0] write_reg,
	input [15:0] write_data, r0,
	input [1:0] reg_write,	//reg write and r0 write
	input reset,
	
	output reg [15:0] read_data1, read_data2
	);
	
	reg [15:0] R [15:0];
	
	always@(*) begin
		if (!reset) begin
			R[4'h0] <= 16'h 0000;
			R[4'h1] <= 16'h 7B18;
			R[4'h2] <= 16'h 245B;
			R[4'h3] <= 16'h FF0F;
			R[4'h4] <= 16'h F0FF;
			R[4'h5] <= 16'h 0051;
			R[4'h6] <= 16'h 6666;
			R[4'h7] <= 16'h 00FF;
			R[4'h8] <= 16'h FF88;
			R[4'h9] <= 16'h 0000;
			R[4'hA] <= 16'h 0000;
			R[4'hB] <= 16'h 3099;
			R[4'hC] <= 16'h CCCC;
			R[4'hD] <= 16'h 0002;
			R[4'hE] <= 16'h 0011;
			R[4'hF] <= 16'h 0000;
		end
		
		if (reg_write[1] == 1'b1)
			R[write_reg] <= write_data;
		if (reg_write[0] == 1'b1)
			R[0] <= r0;
				
		read_data1 <= R[read_reg1];
		read_data2 <= R[read_reg2];

	end
endmodule
