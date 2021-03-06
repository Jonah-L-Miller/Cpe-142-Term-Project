module data_memory(
		input memWrite, reset, byte_en,
		input [15:0] address, writeData,
		output reg [15:0] readData
	);
	
	reg [7:0] mem [65535:0];
	
	integer i;
	
	always@(*)begin 
		if(!reset) begin 
			for (i = 0;i<65535;i = i+1)
				mem[i] <= 8'h00;

			mem[16'h 0000] <= 8'h 56;
			mem[16'h 0001] <= 8'h 38;
			mem[16'h 0002] <= 8'h 00;
			mem[16'h 0003] <= 8'h 00;
			mem[16'h 0004] <= 8'h 12;
			mem[16'h 0005] <= 8'h 43;
			mem[16'h 0006] <= 8'h DE;
			mem[16'h 0007] <= 8'h BE;
			mem[16'h 0008] <= 8'h EF;
			mem[16'h 0009] <= 8'h AD;	
		end 
		else if(byte_en)	//control signal managages lbu and su
			if(memWrite) 
				mem[address] <= writeData[7:0];
			else 
				readData <= {8'h 00, mem[address]};	//zero extended lbu
		else if(!byte_en)
			if(memWrite)begin 
				mem[address] <= writeData[7:0]; 
				mem[address+1] <= writeData[15:8];
			end 
			else begin 
				readData[15:8] <= mem[address+1];
				readData[7:0] <= mem[address]; 
			end 
		else begin
			mem[0] = mem[0];
			readData[0] = readData[0];
		end
    end 
endmodule