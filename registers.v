module registers(
	input [4:0] read_reg1, read_reg2,
	input [4:0] write_reg,
	input [15:0] write_data, R0,
	input reg_write, reset, write_r0,	
	
	output reg [15:0] read_data1, read_data2
	);
	
	reg [15:0] R [15:0];
	
	always@(*) begin
		if (reset) begin
			R[0] = 16'h 0000;
			R[1] = 16'h 7B18;
			R[2] = 16'h 245B;
			R[3] = 16'h FFFF;
			R[4] = 16'h F0FF;
			R[5] = 16'h 0051;
			R[6] = 16'h 6666;
			R[7] = 16'h 00FF;
			R[8] = 16'h FF88;
			R[9] = 16'h 0000;
			R[A] = 16'h 0000;
			R[B] = 16'h 3099;
			R[C] = 16'h CCCC;
			R[D] = 16'h 0002;
			R[E] = 16'h 0011;
			R[F] = 16'h 0000;
		end
		else if (reg_write)
			R[write_reg] = write_data;
		else if (write_r0)
				R[0] = R0;
		else begin
			read_data1 = R[read_reg1];
			read_data2 = R[read_reg2];
		end
		

	end
endmodule