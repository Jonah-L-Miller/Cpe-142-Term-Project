`timescale 1ns_1ps
`include "ID_EX_buffer.v"
`include "EX_MEM_buffer.v"
`include "MEM_WB_buffer.v"

module forwarding_unit();

input[3:0] ID_EX_RegisterOp1, ID_EX_RegisterOp2, EX_MEM_RegisterOp1, MEM_WB_RegisterOp1;

reg output[1:0] Forward_A, Forward_B = 0;

//Instantiations
ID_EX_buffer ID_EX( 
	.ID_EX_RegisterOp1 (ID_EX_RegisterOp1),
	.ID_EX_RegisterOp2 (ID_EX_RegisterOp2);
);

EX_MEM_buffer EX_MEM( 
	.EX_MEM_RegisterOp1 (EX_MEM_RegisterOp1),
);

MEM_WB_buffer MEM_WB( 
	.MEM_WB_RegisterOp1 (MEM_WB_RegisterOp1)
);

always@(*)
begin

//Execution Hazards
if ((EX_MEM_RegWrite & (EX_MEM_RegisterOp1 != 0)) & (EX_MEM_RegisterOp1 = ID_EX_RegisterOp1))
	Forward_A = 2'b10; 
if ((EX_MEM_RegWrite & (EX_MEM_RegisterOp1 != 0)) & (EX_MEM_RegisterOp1 = ID_EX_RegisterOp2))
	Forward_B = 2'b10;	 
	
//Memory Hazards
if (((MEM_WB_RegWrite & (MEM_WB_RegisterOp1 != 0)) & !(EX_MEM_RegWrite & (EX_MEM_RegisterOp1 != 0)) & (EX_MEM_RegisterOp1 = ID_EX_RegisterOp2)) & (MEM_WB_RegisterOp1 = ID_EX_RegisterOp2))
	Forward_A = 2'b01;
if (((MEM_WB_RegWrite & (MEM_WB_RegisterOp1 != 0)) & !(EX_MEM_RegWrite & (EX_MEM_RegisterOp1 != 0)) & (EX_MEM_RegisterOp1 = ID_EX_RegisterOp2)) & (MEM_WB_RegisterOp1 = ID_EX_RegisterOp2))
	Forward_B = 2'b01;
	
end
endmodule	
	 
	
