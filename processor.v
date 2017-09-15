/*
This is the test bench for my processor. This module is where all of the wiring between modules is handeled. I attempted to layout this module so it is readable and can be traced back to the data flow diagram. The inline comments explain what each component in this module does. Use the diagram as a reference when refering to this module.
*/ 
module ProcessorTestBench;

// for statistics
integer pc_counter = 0;


//important
reg clk = 0;
wire [31:0] pc;

//wires for connecting modules. Names explain use of wires.
wire [31:0] adder_pc;
wire [31:0] instruction;
wire [31:0] jump_to;
wire [31:0] sign_extend;
wire [31:0] shift_out;
wire [31:0] adder_out;
wire [31:0] read_data1;
wire [31:0] read_data2;
wire [31:0] alu_out;
wire [31:0] data_mem_out;
wire [31:0] v0; //reg v0
wire [31:0] a0; //reg a0
wire [31:0] t0; //reg t0
wire [31:0] t1; //reg t1
wire alu_zero;
wire and_out;

//wires for mux outputs. Same numbers as appear on my data flow diagram
wire [31:0] mux_five_out;
wire [31:0] mux_four_out;
wire [31:0] mux_three_out;
wire [4:0] mux_two_out;
wire [31:0] new_pc;

//control bits. All one bit besides ALU op because more than two ops
wire reg_dest; 
wire jump;
wire branch;
wire mem_read;
wire mem_to_reg;
wire [2:0] aluop;
wire mem_write;
wire alu_src;
wire reg_write;
wire syscall_control;


PC PC_Hold(clk, new_pc, pc); //tracks currentPC and updates to new PC
adder Add_Four(pc, 32'd4, adder_pc);	//add four to PC
instruction_mem inst_mem(pc, instruction);  //mem for instructin
registers registerModule(clk, reg_write, instruction[25:21], instruction[20:16], mux_two_out, mux_five_out, read_data1, read_data2, v0, a0,t0,t1); //reg mem
control controller(instruction[31:26],instruction[5:0], reg_dest, jump, branch, mem_read, mem_to_reg, aluop, mem_write, alu_src, reg_write, syscall); //controller (determines flow of program based on opcode and funcode)
shift_instruction shift_inst(instruction[25:0], adder_pc[31:28], jump_to); //shift and concats instruction

//muxes (named correspond to data flow sheet) .BITS determines size of inputs and outputs
global_mux #(.BITS(31)) muxOne(jump, mux_four_out, jump_to, new_pc);
global_mux #(.BITS(4)) muxTwo(reg_dest, instruction[20:16], instruction[15:11], mux_two_out);
global_mux #(.BITS(31)) muxThree(alu_src, read_data2, sign_extend, mux_three_out);
global_mux #(.BITS(31)) muxFour(and_out, adder_pc, adder_out, mux_four_out);
global_mux #(.BITS(31)) muxFive(mem_to_reg, alu_out, data_mem_out, mux_five_out);

sign_extend my_sign_extend(instruction[15:0], sign_extend); //sign extender 16bits -> 32 bits
shift shiftTwo(sign_extend, shift_out);						//shift by two without concatinating
adder adderTwo(adder_pc, shift_out, adder_out);				//add two inputs (NOT THE PLUS FOUR ADDER)
alu my_alu(read_data1, mux_three_out, aluop, alu_out, alu_zero);	//alu_zero determines result of branch instructions
and_mod my_and(branch, alu_zero, and_out);					//simple and gate
data_memory data_mem(clk, mem_read, mem_write, alu_out, read_data2, data_mem_out); //data memory
system_call my_sys_call(clk,syscall, v0, a0);			//module used to handle syscalls.

always @(posedge clk)begin
	pc_counter = pc_counter + 1

end

always begin
	//flip clock
  `TICK; clk = ~clk;
	if (clk == 1)
		//display on posedge
  		$display("Clock Cycle is %d Instruction is %x", pc_counter,instruction);
  if(instruction == 0)
    $finish; //end on instruction == 0
end
initial begin
  $dumpfile("test.vcd"); //used for GTKwave
  $dumpvars(0, ProcessorTestBench);

end


endmodule
