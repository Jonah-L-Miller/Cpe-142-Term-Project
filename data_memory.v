module data_memory(
	input memWrite, reset, byte_en,
	input [15:0] address, writeData,
	output reg [15:0] readData
	);
	
	reg [7:0] mem [15:0];
	
	integer i;
	
	always@(*)begin 
		if(reset) begin 
		/* 	memory[(16'h3856)] <= 8'h00;
            memory[(16'h0000)] <= 8'h02;
            memory[(16'h4312)] <= 8'h04;
            memory[(16'hBEDE)] <= 8'h06;
            memory[(16'hADEF)] <= 8'h08; */
			
			for (i = 0;i<32767;i = i+1)
				mem[i] <= 8'h00;
			
			/* mem[8'h 00] <= 8'h 38;
			mem[8'h 01] <= 8'h 56;
			mem[8'h 02] <= 8'h 00;
			mem[8'h 03] <= 8'h 00;
			mem[8'h 04] <= 8'h 43;
			mem[8'h 05] <= 8'h 12;
			mem[8'h 06] <= 8'h BE;
			mem[8'h 07] <= 8'h DE;
			mem[8'h 08] <= 8'h AD;
			mem[8'h 09] <= 8'h EF; */
			
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