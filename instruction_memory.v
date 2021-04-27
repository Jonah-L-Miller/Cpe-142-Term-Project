module instruction_memory(if_from_pc,if_instruction);
	// Input/Output Ports
	input[15:0]if_from_pc;
	output reg[15:0]if_instruction;

	always@(*)
	begin
		case(if_from_pc)
//	 		 Address	                                                   Instruction
			16'h0000:	if_instruction=16'hFE21;	//		00	ADD R14, R2
			16'h0002:	if_instruction=16'hFB22;	//		02	SUB R11, R2
			16'h0004:	if_instruction=16'h2388;	//		04	ORi R3, 0088
			16'h0006:	if_instruction=16'h149A;	//		06	ANDi R4, 9A
			16'h0008:	if_instruction=16'hF564;	//		08	MUL R5, R6
			16'h000A:	if_instruction=16'hF168;	//		0A	DIV R1, R6
			16'h000C:	if_instruction=16'hD59A;	//		0C	SW R5, A(R9)
			16'h000E:	if_instruction=16'h2802;	//		0E	ORi R8, 2
			16'h0010:	if_instruction=16'hCE9A;	//		10	LW R14, A(R9)
			16'h0012:	if_instruction=16'hF002;	//		12	SUB R0, R0
			16'h0014:	if_instruction=16'hF121;	//		14	ADD R1, R2)
			16'h0016:	if_instruction=16'hF122;	//		16	SUB R1, R2
			16'h0018:	if_instruction=16'h1802;	//		18	ANDi R8, 2
			16'h001A:	if_instruction=16'hA694;	//		1A	LBU R6, 4(R9)
			16'h001C:	if_instruction=16'hB696;	//		1C	SB  R6, 6(R9)
			16'h001E:	if_instruction=16'hC696;	//		1E	LW R6, 6(R9) 
			16'h0020:	if_instruction=16'hF7D2;	//		20	SUB R7, R13
			16'h0022:	if_instruction=16'h6404;	//		22	BEQ R7, 4
			16'h0024:	if_instruction=16'hFB11;	//		24	ADD R11, R1
			16'h0026:	if_instruction=16'h5705;	//		26	BLT R7, 5
			16'h0028:	if_instruction=16'hFB21;	//		28	ADD R11, R2
			16'h002A:	if_instruction=16'h4702;	//		2A	BGT R7, 2
			16'h002C:	if_instruction=16'hF111;	//		2C	ADD R1, R1
			16'h002E:	if_instruction=16'hF111;	//		2E	ADD R1, R1
			16'h0030:	if_instruction=16'hC890;	//		30	LW R8, 0(R9)
			16'h0032:	if_instruction=16'hF881;	//		32	ADD R8, R8
			16'h0034:	if_instruction=16'hD892;	//		34	SW R8, 2 (R9)
			16'h0036:	if_instruction=16'hCA92;	//		36	LW R10, 2 (R9)
			16'h0038:	if_instruction=16'hFCC1;	//		38	ADD R12, R12
			16'h003A:	if_instruction=16'hFDD2;	//		3A	SUB R13, R13
			16'h003C:	if_instruction=16'hFCD1;	//		3C	ADD R12, R13
			16'h003E:	if_instruction=16'h0000;	//		3E	HALT
			default: if_instruction=16'h0000;
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
