
/*----------------------------------------------------------------
  Module for Controller
------------------------------------------------------------------*/
module controller_1( 
					input logic [2:0] func3,
					input logic [6:0] opcode, func7,
					output logic rfwrite, Use_Imm,
					output logic [1:0] sel_PC, wb_sel,
					output logic[2:0] Op_Extend, br_type,
				    output logic[3:0] ALUop);

always_comb begin
		rfwrite = 1'b0;
		Use_Imm = 1'b0;
		sel_PC = 2'b00;
		wb_sel=2'b00;
		Op_Extend = 2'b00;
		ALUop = 4'b0000;
		
		
		case(opcode)
			7'b0110011: rfwrite = 1; //R Type Instruction

			7'b0010011: begin //I Type Instruction
							Use_Imm   = 1; 
							rfwrite   = 1;
							end

			7'b0000011: begin //Load Word
							Use_Imm   = 1; 
							rfwrite   = 1;
							wb_sel    = 1;						
							Op_Extend = 0;
							end
			7'b0100011: begin //Store Word
							Use_Imm   = 1;
							Op_Extend = 1;
							end
			7'b0110111: begin    // LUI Instruction
							rfwrite   = 1;
							Use_Imm   = 1;						
							Op_Extend = 2;
							sel_PC = 2;
						end
			7'b0010111: begin    // AUIPC Type Instruction
							rfwrite   = 1;
							Use_Imm   = 1;
							Op_Extend = 2;
							sel_PC = 1;
						end
			7'b1100011: begin    //Branch Instruction
							Use_Imm =1;
							Op_Extend = 3;
							sel_PC = 1;
							case(func3)	
							3'b000: br_type = 3'd0;    //BEQ
							3'b001: br_type = 3'd1;    //BNE
							3'b100: br_type = 3'd2;    //BLT
							3'b101: br_type = 3'd3;    //BGE
							3'b110: br_type = 3'd4;    //BLTU
							3'b111: br_type = 3'd5;    //BGEU
							endcase
						end
			7'b1101111:	begin   //Jump instruction			
							rfwrite = 1;
							Use_Imm =1;
							Op_Extend = 4;   //Sign extension
							wb_sel = 2;
							sel_PC= 1;
							br_type =3'd6;
							
						end	
			7'b1100111: begin  //JALR
							rfwrite=1;
							Use_Imm =1;
							Op_Extend = 0;
							wb_sel = 2;
							sel_PC = 0;
							br_type =3'd6;
						end

		endcase			
					
		
		if (opcode == 7'b0110011 || opcode == 7'b0010011) begin
		case(func3)
			3'b000: begin
					if (func7 == 7'b0000000) 
						ALUop = 4'd0; 				// add
					else if (func7 == 7'b0100000) 
						ALUop = 4'd1; 				// subtract
					end
			3'b001: begin
					ALUop = 4'd2;                		// sll
					end
			3'b010: ALUop = 4'd3; 					// slt
			3'b011: ALUop = 4'd4;						// sltu
			3'b100: ALUop = 4'd5;					    // xor
			3'b101: begin
					if (func7 == 7'b0000000) 
						ALUop = 4'd6; 				// srl
					else if (func7 == 7'b0100000) 
						ALUop = 4'd7; 				// sra
					end				    
			3'b110: ALUop = 4'd8; 					// or
			3'b111: ALUop = 4'd9;       				// and
			default: ALUop = 0;
		endcase
	end 

end
endmodule