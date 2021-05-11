module forwarding_unit(
		input [1:0] ex_regwrite, mem_regwrite, wb_regwrite,
		input [3:0] id_op1, ex_op1, mem_op1, id_op2, ex_op2, wb_op1,
		input mem_muxc,
		output reg [1:0] forward_a, forward_b,
		output reg forward_branch
    );
    
    always @(*) begin 
		if ((mem_regwrite != 2'b00) && (mem_op1 == ex_op1))
			forward_a = 2'b01;
		else
			forward_a = 2'b00;
		
		if ((wb_regwrite != 2'b00) && (wb_op1 == ex_op1))
			forward_a = 2'b10;
		else
			forward_a = 2'b00;
			
		if ((mem_regwrite != 2'b00) && (mem_op1 == ex_op2))
			forward_b = 2'b01;
		else
			forward_b = 2'b00;
		
		if ((wb_regwrite != 2'b00) && (wb_op1 == ex_op2))
			forward_b = 2'b10;
		else
			forward_b = 2'b00;
			
		if ((mem_op1 == ex_op1) && (mem_muxc == 0))
			forward_a = 2'b11;
		else
			forward_a = 2'b00;
		
		if ((mem_op1 == ex_op2) && (mem_muxc == 0))
			forward_b = 2'b11;
		else
			forward_b = 2'b00;
			
		if ((mem_op1 == id_op1) && (mem_regwrite != 2'b00))
			forward_branch = 1'b1;
		else
			forward_branch = 1'b0;
			
		if ((mem_op1 == id_op1) && (mem_muxc == 0))
			forward_branch = 1'b1;
		else
			forward_branch = 1'b0;

    end 
endmodule	
	