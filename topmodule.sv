/*----------------------------------------------------------------
  Top Module for Project 1
------------------------------------------------------------------*/
module Project_1(input clk, reset);

logic rfwrite, Use_Imm;
logic [1:0] sel_PC, wb_sel;
logic [2:0] func3, br_type, Op_Extend;
logic [3:0] ALUop;
logic [6:0] func7, opcode;


Datapath_1 d1 (.clk(clk), .reset(reset), .rfwrite(rfwrite), .ALUop(ALUop), .Op_Extend(Op_Extend) , .Use_Imm(Use_Imm) ,
                .sel_PC(sel_PC) , .wb_sel(wb_sel) , .func3(func3), .func7(func7), .opcode(opcode) , .br_type(br_type));
			   
controller_1 c1 (.func3(func3), .opcode(opcode), .func7(func7), .rfwrite(rfwrite), .ALUop(ALUop) ,
                   .Use_Imm(Use_Imm), .sel_PC(sel_PC) , .Op_Extend(Op_Extend), .wb_sel(wb_sel), .br_type(br_type));

endmodule