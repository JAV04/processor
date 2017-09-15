# mips-processor									
A MIPS processor written in verilog

to compile and RUN

1) open terminal cd to project1 folder.
2) enter either 1) `bash run` OR `./run`         -> this step executes a script that deals with the include requirements and compiles then runs processor.v

## Design 
I apporached this project by trying to make it very modular. I started off by attempting to create these modules individually so that I could test them and make sure they all work to specification before I linked everything together. I also wanted to focus on making modules as generic as possible - a good example of this is in the global_mux module (rather than create modules of different sizes I created one parameterized module that adjsust the #bits). Once I was able to successfully test all of the modules by themselves, I followed the data flow diagram to wire everything together. I attempted to keep the naming convention of the wires and modules as close as possible to the picture of the data flow. The naming convention was very important when I got to the debugging phase. Another design feature I added in the bash script was adding requirements to a text file and then compiling with these requirements. This makes it so you can add new modules into the "modules/" folder and the bash script will know how to handle compiling/including them.

## Testing
To test my modules I instatiated them and tested known inputs/outputs to test if my modules were behaving appropriately. For example, with the and_gate I simply test if an input of a 1 and 1 outputs 1 or an input of 0 and 1 outputs 0. I found it was much easier to test modules by themselves rather than trying to test a group of modules. Some modules were very difficult to test. For example, registers was difficult to test because I did not have data_memory implemented yet. So, to test I hardcoded in a "next value" for the registers and passed an instruction that should write to register t0. To test this I printed out the value of t0 after the instruction ran.

I have successfully implemented this processor to complete add_test.s 
Note* This does not work for fibo
