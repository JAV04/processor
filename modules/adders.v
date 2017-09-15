/*
Returns adder_out. Out = in1 plus in2. **Note of in1 OR in2 are 'x' then adder_out WILL be 'x'
*/
module adder(input wire [31:0] in1, input wire [31:0] in2, output reg [31:0] adder_out);
  always @(in1)
    begin
      adder_out = in1 + in2;	//add inputs and send on out wire
    end
endmodule


