
/*----------------------------------------------------------------
  Module for Multiplexer 5x1
------------------------------------------------------------------*/
module Mux5(input[2:0] mux_sel,
		   input[31:0] m1, m2,m3,m4,m5,
		   output reg[31:0] mux_result);
		   
always_comb begin
	case (mux_sel)
		3'd0: mux_result <= m1;
		3'd1: mux_result <= m2;
		3'd2: mux_result <= m3;
		3'd3: mux_result <= m4;
		3'd4: mux_result <= m5;
	endcase
	end
endmodule