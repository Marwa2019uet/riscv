module Branch_cond( input logic [31:0] rdata1, rdata2,
                    input logic [2:0] br_type,
                    output logic br_taken);   //br_taken = br_result

always_comb begin
    case(br_type)
    3'd0 : br_taken <= rdata1 ==rdata2;                        //BEQ
    3'd1 : br_taken <= rdata1 !=rdata2;                        //BNE
    3'd2 : br_taken <= $signed(rdata1) < $signed(rdata2);      //BLT
    3'd3 : br_taken <= $signed(rdata1) >= $signed(rdata2);     //BGE
    3'd4 : br_taken <= $unsigned(rdata1) < $unsigned(rdata2);  //BLTU
    3'd5 : br_taken <= $unsigned(rdata1) >= $unsigned(rdata2);  //BGEU
    3'd6 : br_taken <= 1;                                       //JAL, JALR
    default : br_taken = 0;
    endcase
end

endmodule
