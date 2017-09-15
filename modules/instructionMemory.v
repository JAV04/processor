/*
Module is designed to store instructions in memory. Accessed to determine what the next instruction of the program is. All of the instructions come from the machine code file add_test.v.

output - next instruction
*/
module instruction_mem(input wire [31:0] addr, output reg [31:0] out);
  reg [31:0] memory [32'h100000:32'h101000];	//memory array
  reg [31:0] out_addr;							//address of instruction

  initial
    begin
      $readmemh("add_test.v", memory);	//read insturctions
    end

  always @(addr)
    begin
        out_addr = addr >> 2;		//shift addr
        out = memory[out_addr];		//get instruction to go out
    end

endmodule
