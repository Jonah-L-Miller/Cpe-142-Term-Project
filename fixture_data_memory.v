`include "data_memory.v"
module fixture_data_memory();
	reg memWrite, reset, byte_en;
	reg [15:0] address, writeData;
	wire [15:0] readData;
		
	integer i;
	
	data_memory uut(
		.memWrite(memWrite),
		.reset(reset),
		.byte_en(byte_en),
		.address(address),
		.writeData(writeData),
		.readData(readData)
	);
	
	initial
		{memWrite, reset, byte_en, address, writeData} = 0;
	
	always@(*) begin
		#3;
		$display("\n=====\n");
		$display("reset = %h", uut.reset);
		$display("byte_en = %h", uut.byte_en);
		$display("memWrite = %h", uut.memWrite);
		$display("writeData = %h", uut.writeData);
		$display("address = %h", uut.address);
		$display("readData = %h", uut.readData);
	end
	
	initial begin
		reset = 1;
		#10 reset = 0;
		#10 reset = 1;
		
		#10 writeData = 16'h abcd;
		
		for (i=0;i<10;i=i+2)
			#10 address = i;
			
		#10 memWrite = 1;
		#10 memWrite = 0;		
			
		#10 byte_en = 1;	
		for (i=0;i<10;i=i+1)
			#10 address = i;
			
		#10 memWrite = 1;
		#10 memWrite = 0;

	end
endmodule
	