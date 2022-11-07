
/*----------------------------------------------------------------
  Module for Multiplexer 2x1
------------------------------------------------------------------*/
module Mux(input mux_sel,
		   input[31:0] m1, m2,
		   output reg[31:0] mux_result);
		   
always_comb begin
	case (mux_sel)
		0: mux_result <= m1;
		1: mux_result <= m2;
	endcase
	end
endmodule