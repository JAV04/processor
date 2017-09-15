`include "mips.h" 

/*
Module for an ALU. Takes two intputs and has two outputs. One output is the result of the op. The other output is a 1/0 depending on if the result is zero (used for branching).

Operations:
and
or
plus
minus
less than
*/
module alu(input wire [31:0] in1, input wire [31:0] in2, input wire [2:0] aluop, output reg [31:0] out, output wire zero);

  assign zero = (out == 0);

  always @(*) begin
    case(aluop)
      3'b000: out <= in1 & in2;
      3'b001: out <= in1 | in2;
      3'b010: out <= in1 + in2;
      3'b110: out <= in1 - in2;
      3'b111: out <= in1 < in2 ? 1:0;
      default: out <= 0;
    endcase
  end

endmodule
