`include "registers.v"
module fixture_registers();
	reg [3:0] rr1, rr2, wr;
	reg [15:0] wd,r0;
	reg [1:0] rw;
	reg reset;
	
	wire [15:0] rd1, rd2;
	integer i;
	registers uut(
		.read_reg1(rr1),
		.read_reg2(rr2),
		.write_reg(wr),
		.write_data(wd),
		.r0(r0),
		.reg_write(rw),
		.reset(reset),
		.read_data1(rd1),
		.read_data2(rd2)		
	);
	
	initial
		{rr1, rr2, wr, wd, r0, rw, reset} = 0;
	
	always@(*) begin
		#3;
		$display("\n================\n");
		$display("READ REG 1 =  %h", uut.read_reg1);
		$display("READ REG 2 =  %h", uut.read_reg2);
		$display("READ data 1 = %h", uut.read_data1);
		$display("READ data 2 = %h", uut.read_data2);
		$display("R0=           %h", uut.r0);
		$display("reg_write=    %h", uut.reg_write);
		$display("reset=        %h", uut.reset);
		$display("write_reg=    %h", uut.write_reg);
		$display("write_data=   %h", uut.write_data);
	end
	
	initial begin

		#10 		reset = 1;
		#10;
		for (i=0;i<15;i=i+1)
			#10 rr1 = i;
			
		/*#10;
		for (i=0;i<15;i=i+1)
			#10 rr2 = i;*/
	end
endmodule