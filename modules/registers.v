`include "mips.h" 


/*
This module is for register memory. On The negedge of the clk read from register_memory and on posedge we write to the register_memory. All register memory is defaulted to a zero value so that the first ADDIU instruction is able to execute propery
*/
module registers(input wire clk, input wire reg_write, input wire [25:21] reg1, input wire [20:16] reg2, input wire [4:0] use_reg, input wire [31:0] data_in, output reg [31:0] read1, output reg [31:0] read2, output reg [31:0] v0, output reg [31:0] a0, output reg [31:0] t0, output reg [31:0] t1);
  reg [31:0] register_memory [31:0];

	integer i;
  initial begin
	read1 = 32'b0;
	read2 = 32'b0;
	for (i = 0; i<32; i=i+1) begin
		register_memory[i] = 32'b0;		//default memory to zero.
	end


  end
  always @(*)
    begin
	  if(clk) begin
      if(reg_write == 1) begin
        register_memory[use_reg] = data_in;		//write to reg mem.
		end
    end
	else begin
    read1 <= register_memory[reg1];			//read from reg mem.
    read2 <= register_memory[reg2];
	end
    v0 <= register_memory[`v0];
    a0 <= register_memory[`a0];
	t0 <= register_memory[`t0];
	t1 <= register_memory[`t1];
  end

endmodule
