`include "mips.h" 


/*
This module is designed to send out control signals to other modules. The control signals are determined with the opcode and the function code. With these two inputs we determine if the values of the 10 control signals.
*/
module control (input wire [31:26] opcode,input wire [5:0] funcCode,output reg regDst,output reg jump,output reg branch,output reg memRead,output reg memToReg,output reg [2:0] aluOp,output reg memWrite,output reg aluSrc,output reg regWrite, output reg syscall
);

  always @ ( * ) begin		//one bit control signals usually controlling mux (see data flow to see what these control bits do)
    regDst = opcode == 0 ? 1 : 0;	
    jump = (opcode == 2 || opcode == 3) ? 1 : 0; 
    branch = (opcode == 4 || opcode == 5) ? 1 : 0;
    memRead = opcode == 6'h23 ? 1 : 0;
    memToReg = opcode == 6'h23 ? 1 : 0;
    memWrite = opcode == 6'h2b ? 1 : 0;
    aluSrc = (opcode == 8 || opcode == 6'hd || opcode == 6'h23 || opcode == 6'h2b || opcode == 9) ? 1 : 0;
    regWrite = (opcode == 0 || opcode == 8 || opcode == 6'hd || opcode == 6'h23 || opcode == 9) ? 1 : 0;
    syscall = ( opcode == 0 && funcCode == 6'h0c ) ? 1 : 0;

    if (opcode != 0)		//determines the ALU op so ALU knows which operation to perform.
      case (opcode)
        6'h09: aluOp = 3'b010;
        6'h0d: aluOp = 3'b001;
        6'h23 || 6'h2b: aluOp = 3'b010;
        6'h04 || 6'h05: aluOp = 3'b110;
        default: aluOp = 3'b000;
      endcase

    else
      case (funcCode)				//determine ALU op for non R-type instructions
        6'h20: aluOp = 3'b010;
        6'h22: aluOp = 3'b110;
        6'h24: aluOp = 3'b000;
        6'h25: aluOp = 3'b001;
        6'h2a: aluOp = 3'b111;
        default: aluOp = 3'b000;
      endcase;

  end

endmodule
