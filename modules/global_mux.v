`include "mips.h" 

/*
This is a universal mux (any number of bits). If test is zero Ifzero is returned. If test is one ifOne is returned. Output is out.
*/
module global_mux(input wire test, input wire [BITS:0] ifZero, input wire [BITS:0] ifOne, output reg [BITS:0] out);
parameter BITS = 31;
always @(*)
  begin
    out = (test == 0 ? ifZero : ifOne); //terinary operator to determine output of mux.
  end
endmodule
