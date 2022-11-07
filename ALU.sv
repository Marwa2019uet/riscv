
/*----------------------------------------------------------------
  Module for ALU
------------------------------------------------------------------*/
module ALU(input logic [31:0] op1, op2,                 //operand1 and operand 2 of ALU
           input logic[3:0] ALUop, 
           output logic[31:0] ALUresult);
           
always_comb begin
	case (ALUop)
        4'd0 : ALUresult = op1 + op2;                      // add
        4'd1 : ALUresult = op1 - op2;                      // subtarct
        4'd2 : ALUresult = op1 << op2[4:0];                // sll
        4'd3 : ALUresult = $signed(op1) < $signed(op2);    // slt
        4'd4 : ALUresult = op1 < op2;                      // sltu
        4'd5 : ALUresult = op1 ^op2;                      // xor
        4'd6 : ALUresult = op1 >> op2[4:0];                // srl
        4'd7 : ALUresult = op1 >>> op2[4:0];               // sra
        4'd8 : ALUresult = op1 | op2;                      // or
        4'd9 : ALUresult = op1 & op2;                      // and
        default: ALUresult = 0;
    endcase
end
endmodule