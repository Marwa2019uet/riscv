/*----------------------------------------------------------------
  Module for Program Counter
------------------------------------------------------------------*/
module Program_Counter(input logic clk, reset,
					   input logic [31:0] ALUresult,
					   input logic br_taken,
					   output logic [31:0] PC); 

always_ff @(posedge clk) begin 
	if(reset)
		PC <= 32'd0;
	else
		PC <= br_taken ? ALUresult : 	PC+ 32'd4;
	end
endmodule