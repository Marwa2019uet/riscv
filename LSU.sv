// LOAD STORE UNIT

module LSU(input logic [31:0] Mem_Addr, Mem_rd,
           input logic [6:0] opcode,
           input logic [2:0] func3,
           output logic cs, wr,
           output logic [3:0] mask,
           output logic [31:0] Mem_wr); 

//wrMem_wr Operation
always_comb begin 
    if(opcode == 7'b0100011) begin
        cs = 0;
        wr = 0;
	case(func3)
	//to store a byte SB we use last 2 bits
	 3'b000 : begin 
            case(Mem_Addr[1:0])
                2'b00 : mask = 4'b0001;
                2'b01 : mask = 4'b0010;
                2'b10 : mask = 4'b0100;
                2'b11 : mask = 4'b1000;
			endcase
            end
        
	// to store half word we use only 2nd last bit
	3'b001 : begin  
            case(Mem_Addr[1])
                1'b0 : mask = 4'b0011;
                1'b1 : mask = 4'b1100;
            endcase
        end	
	// Store word SW
	3'b010 : mask = 4'b1111;

    default: mask = 4'b0000;

	endcase
	end

    if (opcode == 7'b0000011) begin
        cs = 0;
        wr = 1;
	case(func3)
	// Load Byte
	3'b000 : begin
		case(Mem_Addr[1:0]) 
            2'b00 : Mem_wr = {{24{Mem_rd[7]}}, {Mem_rd[7:0]}};
            2'b01 : Mem_wr = {{24{Mem_rd[15]}}, {Mem_rd[15:8]}}; 
            2'b10 : Mem_wr = {{24{Mem_rd[23]}}, {Mem_rd[23:16]}};
            2'b11 : Mem_wr = {{24{Mem_rd[31]}}, {Mem_rd[31:24]}}; 
        endcase
    end 

	// Load Byte unsigned
    3'b100 : begin 
        case(Mem_Addr[1:0]) 
            2'b00 : Mem_wr = {24'b0, {Mem_rd[7:0]}};  
            2'b01 : Mem_wr = {24'b0, {Mem_rd[15:8]}};
            2'b10 : Mem_wr = {24'b0, {Mem_rd[23:16]}};  
            2'b11 : Mem_wr = {24'b0, {Mem_rd[31:24]}};
        endcase
    end 

	// Load Halfword
    3'b001 : begin  
        case(Mem_Addr[1]) 
            1'b0 : Mem_wr = {{16{Mem_rd[15]}}, {Mem_rd[15:0]}}; 
            1'b1 : Mem_wr = {{16{Mem_rd[31]}}, {Mem_rd[31:16]}};  
        endcase
    end

	// Load halfword unsigned
    3'b101 : begin  
        case(Mem_Addr[1]) 
            1'b0 : Mem_wr = {16'b0, {Mem_rd[15:0]}}; 
            1'b1 : Mem_wr = {16'b0, {Mem_rd[31:16]}};
        endcase
    end 

	// Load Word   
    3'b010: Mem_wr = Mem_rd;    
    default: Mem_wr = 0;
    endcase
    end
end 
endmodule

