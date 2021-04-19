`timescale 1ns/1ps
`include "ID/EX_buffer.v"
`include "EX/MEM_buffer.v"
`include "MEM/WB_buffer.v"

module forwarding_unit();

input[3:0] ID/EX_RegisterOp1, ID/EX_RegisterOp2, EX/MEM_RegisterOp1, 

reg output[1:0] Forward_A, Forward_B = 0;

//Instantiations
ID/EX_buffer ID/EX( 
	.ID/EX_RegisterOp1 (ID/EX_RegisterOp1),
	.ID/EX_RegisterOp2 (ID/EX_RegisterOp2);
);

EX/MEM_buffer EX/MEM( 
	.EX/MEM_RegisterOp1 (EX/MEM_RegisterOp1),
);

MEM/WB_buffer MEM/WB( 
	.MEM/WB_RegisterOp1 (MEM/WB_RegisterOp1)
);

always@(*)
begin

//Execution Hazards
if ((EX/MEM_RegWrite & (EX/MEM_RegisterOp1 != 0)) & (EX/MEM_RegisterOp1 = ID/EX_RegisterOp1))
	Forward_A = 2'b10; 
if ((EX/MEM_RegWrite & (EX/MEM_RegisterOp1 != 0)) & (EX/MEM_RegisterOp1 = ID/EX_RegisterOp2))
	Forward_B = 2'b10;	 
	
//Memory Hazards
if (((MEM/WB_RegWrite & (MEM/WB_RegisterOp1 != 0)) & !(EX/MEM_RegWrite & (EX/MEM_RegisterOp1 != 0)) & (EX/MEM_RegisterOp1 = ID/EX_RegisterOp2)) & (MEM/WB_RegisterOp1 = ID/EX_RegisterOp2))
	Forward_A = 2'b01
if (((MEM/WB_RegWrite & (MEM/WB_RegisterOp1 != 0)) & !(EX/MEM_RegWrite & (EX/MEM_RegisterOp1 != 0)) & (EX/MEM_RegisterOp1 = ID/EX_RegisterOp2)) & (MEM/WB_RegisterOp1 = ID/EX_RegisterOp2))
	Forward_B = 2'b01;
	
end
endmodule	
	 

	