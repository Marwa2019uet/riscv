
/*----------------------------------------------------------------
  Module for Multiplexer 3x1
------------------------------------------------------------------*/
module Mux3(input [1:0] mux_sel,
		   input[31:0] m1, m2, m3,
		   output reg[31:0] mux_result);
		   
always_comb begin
	case (mux_sel)
		0: mux_result <= m1;
		1: mux_result <= m2;
        2: mux_result <= m3;
	endcase
	end
endmodule