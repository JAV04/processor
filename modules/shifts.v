`include "mips.h"

/*
Module in top left of diagram. This shifts the instruction 26->28 bits and then concats the top 4 bits of the adder+4 module. 
*/
module shift_instruction(input wire [25:0] instruction, input wire [31:28] new_pc, output reg [31:0] out);
  always @(instruction) begin
      out = instruction << 2; 	//shift left 2
      out = {new_pc[31:28], out[27:0]};		//concat
  end
endmodule

/*
Shift left by two. No concat on this module unlike above.
*/
module shift(input wire [31:0] instruction, output reg [31:0] shifted);
  always @(instruction)
    shifted = instruction << 2; //shift left 2
endmodule

