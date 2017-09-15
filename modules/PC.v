`include "mips.h" 


/*
Module designed to keep track of the current PC. On the posedge of the clock this module updates with the new pc to keep the flow of the program moving forward. The value of the next PC is NOT determined in this module, just set.
*/
module PC(input wire clk, input wire [31:0] new_pc, output reg [31:0] current_pc);

initial
  begin
    current_pc = 32'h00400020;
  end

  always @(posedge clk)
    begin
      current_pc = new_pc;
    end

endmodule
