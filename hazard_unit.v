module hazard_unit(		
		input ex_memwrite,
		input [3:0] id_op1,  ex_op1, 
		output reg id_flush, pc_pause, if_id_flush, if_id_hold	
		);

	always@(*)
		
		if ( (ex_op1 == id_op1) && ( ex_memwrite == 1 ) ) begin //
			id_flush = 1; // flushed control signals for ID/EX buffer
			pc_pause = 1;
			//if_id_flush = 1;
			if_id_hold = 1;
		end

		else  begin
			id_flush = 0; 
			pc_pause = 0;
			if_id_flush = 0;
			if_id_hold = 0;
		end

endmodule
	