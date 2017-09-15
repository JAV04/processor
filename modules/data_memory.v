`include "mips.h" 

/*
Module for data memory

Timing works same as the register memory. Read on negedge and write on posedge. Control bits (mem_read and mem_write) determine where output of this module get written to.
*/
module data_memory(input wire clk, input wire mem_read, input wire mem_write, input wire [31:0] address, input wire [31:0] write_data, output reg [31:0] read_data);
  reg [31:0] memory [255:0];

  always @(negedge clk)
    begin
      if(mem_read == 1)
        read_data = memory[address];		//read from data mem on negegde.
    end
  always @(posedge clk)
    begin
      if(mem_write == 1)
        memory[address] = write_data;		//write to data mem on posedge.
    end

endmodule
