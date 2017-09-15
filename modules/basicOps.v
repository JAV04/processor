/*
Basic and gate.
*/
module and_mod(input wire inOne, input wire inTwo, output wire out);

  assign out = inOne & inTwo; //out == 1 if inOne and inTwo == 1

endmodule


/*
Extends a 16 bit values. Works for 2s compliment by concatinating 16 of the first bit with the orignal value.
*/
module sign_extend(input wire [15:0] in, output reg [31:0] out);

always @(in)
  begin
    out = {{16{in[15]}}, in[15:0]};
  end

endmodule
