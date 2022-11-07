
/*----------------------------------------------------------------
  Module for Data Memory
------------------------------------------------------------------*/
module Data_mem(input logic clk, cs, wr,
				input logic  [31:0] Mem_Addr, Mem_Din,
                input logic  [3:0] mask,
                output logic [31:0] Mem_Dout); 
				
logic [31:0] Data_File [31:0];


initial begin
	$readmemh("data.txt", Data_File);
	end

//Write operation (Store Data) synchronous
always_ff @(negedge clk)
begin
	if(!cs && !wr) begin
		if (mask[0])
			Data_File[Mem_Addr[31:2]][7:0] = Mem_Din[7:0];
		if (mask[1])
			Data_File[Mem_Addr[31:2]][15:8] = Mem_Din[15:8];	
		if (mask[2])
			Data_File[Mem_Addr[31:2]][23:16] = Mem_Din[23:16];
		if (mask[3])
			Data_File[Mem_Addr[31:2]][31:24] = Mem_Din[31:24];
	end
end

assign Mem_Dout = (!cs & wr) ? Data_File[Mem_Addr[31:2]] : 32'b0;  // asynchronous read

endmodule