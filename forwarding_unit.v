module forwarding_unit(
		input [1:0] ex_regwrite, mem_regwrite,
		input [3:0] id_op1, ex_op1, mem_op1, id_op2, ex_op2, 
		input mem_muxc,
		output reg [2:0] forward_a, forward_b,
		output reg forward_branch
    );
    
    always @(*) begin 
		if (mem_regwrite == 2'b11 and mem_op1 == ex_op1)
			forward_a = 3'b001;
		else
			forward_a = 3'b000;
		
		if (wb_regwrite == 2'b11 and wb_op1 == ex_op1)
			forward_a = 3'b010;
		else
			forward_a = 3'b000;
			
		if (mem_regwrite = 2'b11 and mem_op1 == ex_op2)
			forward_b = 3'b001;
		else
			forward_b = 3'b000;
		
		if (wb_regwrite = 2'b11 and wb_op1 == ex_op2)
			forward_b = 3'b010;
		else
			forward_b = 3'b000;
			
		if (mem_op1 == ex_op1 and mem_muxc == 1)
			forward_a = 3'b100;
		else
			forward_a = 3'b000;
		
		if (mem_op1 == ex_op2 and mem_muxc == 1)
			forward_b = 3'b100;
		else
			forward_b = 3'b000;
			
		if (mem_op1 == id_op1 and mem_regwrite == 2'b11)
			forward_branch = 1'b1;
		else
			forward_branch = 1'b0;
			
		if (mem_op1 == id_op1 and mem_regwrite != 2'b11)
			forward_branch = 1'b1;
		else
			forward_branch = 1'b0;

    end 
endmodule	