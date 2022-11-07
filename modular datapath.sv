/*----------------------------------------------------------------
  Top Module for Datapath
------------------------------------------------------------------*/
module Datapath_1(input logic clk, reset, rfwrite, Use_Imm, 
				  input logic [1:0] sel_PC, wb_sel, 
				  input logic [2:0] Op_Extend, br_type,
				  input logic [3:0] ALUop, 
				  output logic [2:0] func3,  
				  output logic [6:0] func7, opcode);

logic cs, wr;
logic [3:0] mask;
logic [4:0] radd1, radd2, wadd;
logic [31:0] rdata1, rdata2, PC, Instruction, ALUresult, Mem_wr, Mem_Dout,
			 Extended_Imm, op1, op2, wdata, imm, Simm,Uimm,BImm, JImm;


Program_Counter p1 (.clk(clk), .reset(reset), .PC(PC), .ALUresult(ALUresult), .br_taken(br_taken));

Instruction_Memory mymem (.PC(PC), .Instruction(Instruction));

assign radd1 = Instruction[19:15];
assign radd2 = Instruction[24:20];
assign wadd  = Instruction[11:7];
assign Imm   = Instruction[31:20];

assign func3  = Instruction[14:12];
assign func7  = Instruction[31:25];
assign opcode = Instruction[6:0];

assign imm    = { {20{Instruction[31]}}, Instruction[31:20] };  //I Type and Load  and JALR
assign Simm   = { {20{Instruction[31]}}, Instruction[31:25], Instruction[11:7] };  //Store 
assign Uimm   = { Instruction[31:12], 12'b0 };    //U Type
assign BImm	  = { {20{Instruction[31]}}, Instruction[7], Instruction[30:25], Instruction[11:8], 1'b0}; //B type
assign JImm   = { {12{Instruction[31]}}, Instruction[19:12], Instruction[20], Instruction[30:21], 1'b0}; //J type


Register myreg (.clk(clk), .rfwrite(rfwrite), .radd1(radd1), .radd2(radd2),
				.wadd(wadd), .wdata(wdata), .rdata1(rdata1), .rdata2(rdata2));

Mux5 imm_mux (.mux_sel(Op_Extend), .m1(imm), .m2(Simm), .m3(Uimm), .m4(BImm), .m5(JImm) , .mux_result(Extended_Imm));

Mux3 mux (.mux_sel(sel_PC), .m1(rdata1), .m2(PC), .m3(32'd0), .mux_result(op1));
Mux3 mux_mem (.mux_sel(wb_sel), .m1(ALUresult), .m2(Mem_wr), .m3(PC + 32'd4), .mux_result(wdata));	

Mux mux_imm(.mux_sel(Use_Imm), .m1(rdata2), .m2(Extended_Imm), .mux_result(op2));
ALU myalu (.op1(op1), .op2(op2), .ALUop(ALUop), .ALUresult(ALUresult));

Data_mem mydm (.clk(clk), .cs(cs), .wr(wr), .Mem_Addr(ALUresult), .Mem_Din(rdata2), .mask(mask), .Mem_Dout(Mem_Dout));
LSU mylsu(.Mem_Addr(ALUresult), .Mem_rd(Mem_Dout),.opcode(opcode), .func3(func3),
          .cs(cs), .wr(wr), .mask(mask), .Mem_wr(Mem_wr)); 

Branch_cond mybr (.rdata1(rdata1), .rdata2(rdata2), .br_type(br_type), .br_taken(br_taken));



endmodule				  