`include "mips.h" 

/*
	Module is designed to handle syscalls. If V0 is one this module displays a0. If V0 is 10 this module exits. If V0 is anything else nothing really happens. syscall_control is what determines if the current instruction is infact a syscall.

output - sideeffect of syscall.
*/
module system_call(input wire clk,input wire syscall_control, input wire [31:0] v0, input wire [31:0] a0, input wire [31:0] inst);
	realtime progTime = 0.0;
	integer cycleCounter=1; //start at one due to set up of clock edges
	integer instCounter=0;

	initial begin
		$timeformat(-3, 4, " ms", 10);
		progTime = $realtime;
		$display("StartTime: %t",progTime);

	end

	always @(inst) begin
		instCounter = instCounter + 1;
end


  always @(posedge clk) begin
	cycleCounter = cycleCounter+1;
end

  always @ ( negedge clk ) begin
    if(syscall_control==1) begin
      case(v0)
        32'd1: $display("\na0 = %d",a0);
        32'd10:begin
				 $display("\nSyscall: Exiting Program!");
				 $display("# Clock Cycles: \t%d",cycleCounter);
				 $display("# Instructions: \t%d",instCounter);
				 $display("#Instruction/#Clocks: \t%d", instCounter/cycleCounter);
				 progTime = $realtime;
				 $display("EndTime: %t",progTime);
				 $finish;
				end
        default: $display("Other Syscall");

      endcase


    end

  end

endmodule
