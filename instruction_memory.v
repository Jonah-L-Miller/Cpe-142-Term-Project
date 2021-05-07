module instruction_memory(from_pc,instruction);
	// Input/Output Ports
	input[15:0]from_pc;
	output reg[15:0]instruction;

	always@(*)
	begin
		case(from_pc)
//	 		 Address	                                                   Instruction
			16'h0000:	instruction=16'hFE21;	//		00	ADD R14, R2
			16'h0002:	instruction=16'hFB22;	//		02	SUB R11, R2
			16'h0004:	instruction=16'h2388;	//		04	ORi R3, 0088
			16'h0006:	instruction=16'h149A;	//		06	ANDi R4, 9A
			16'h0008:	instruction=16'hF564;	//		08	MUL R5, R6
			16'h000A:	instruction=16'hF168;	//		0A	DIV R1, R6
			16'h000C:	instruction=16'hD59A;	//		0C	SW R5, A(R9)
			16'h000E:	instruction=16'h2802;	//		0E	ORi R8, 2
			16'h0010:	instruction=16'hCE9A;	//		10	LW R14, A(R9)
			16'h0012:	instruction=16'hF002;	//		12	SUB R0, R0
			16'h0014:	instruction=16'hF121;	//		14	ADD R1, R2
			16'h0016:	instruction=16'hF122;	//		16	SUB R1, R2
			16'h0018:	instruction=16'h1802;	//		18	ANDi R8, 2
			16'h001A:	instruction=16'hA694;	//		1A	LBU R6, 4(R9)
			16'h001C:	instruction=16'hB696;	//		1C	SB  R6, 6(R9)
			16'h001E:	instruction=16'hC696;	//		1E	LW R6, 6(R9) 
			16'h0020:	instruction=16'hF7D2;	//		20	SUB R7, R13
			16'h0022:	instruction=16'h6404;	//		22	BEQ R7, 4
			16'h0024:	instruction=16'hFB11;	//		24	ADD R11, R1
			16'h0026:	instruction=16'h5705;	//		26	BLT R7, 5
			16'h0028:	instruction=16'hFB21;	//		28	ADD R11, R2
			16'h002A:	instruction=16'h4702;	//		2A	BGT R7, 2
			16'h002C:	instruction=16'hF111;	//		2C	ADD R1, R1
			16'h002E:	instruction=16'hF111;	//		2E	ADD R1, R1
			16'h0030:	instruction=16'hC890;	//		30	LW R8, 0(R9)
			16'h0032:	instruction=16'hF881;	//		32	ADD R8, R8
			16'h0034:	instruction=16'hD892;	//		34	SW R8, 2 (R9)
			16'h0036:	instruction=16'hCA92;	//		36	LW R10, 2 (R9)
			16'h0038:	instruction=16'hFCC1;	//		38	ADD R12, R12
			16'h003A:	instruction=16'hFDD2;	//		3A	SUB R13, R13
			16'h003C:	instruction=16'hFCD1;	//		3C	ADD R12, R13
			16'h003E:	instruction=16'h0000;	//		3E	HALT
			default: 	instruction=16'h0000;
		endcase
	end
endmodule


////////////////////////////////////////////////////////////////////////////////// 
// Engineer: Jonah Miller 
// 
// Create Date: 04/26/2021 8:16 PM
// Design Name: instruction memory
// Module Name: instruction_memory
// Target Devices: IF/ID Buffer 
// Dependencies: PC 
// Description: Outputs the proper instruction to be used by the control unit,
//		registers and zero extend based on the opcode, op1, op2, and
//		immediate values required by the provided hardcoded instructions.		
//////////////////////////////////////////////////////////////////////////////////
