`timescale 1ns / 1ps
module accumlator(
    input clk,rst,load,
    input [7:0] bus,
    output [7:0] data
    );

	//call 2 instances to make A and B register
	
	/*Modified:
		Accumalator will store the add and sub results after operation right?
		So why not add a store signal to the accumalator so that the result can be stored in memory.
		things to change will be the accumalator, the memory controller, the bus controller and the control
		signal generator for this modified sap 1 to work.
		
		new opcodes will be:
		LDA	- load to a
		STFA	- store from a
		ADD
		SUB
		HLT
		OUT
		
		additionally the 4 digit 7 segment controller will monitor the last 2 8 bit registers.(Controller needs 4x4bit line)
		the programmer should conserve space and prioritise programming such that the variables being worked
		on and the and output are shown in the last 2 register.
		
		the segment controller has a lat pin to help the control signal generator for this purpose.
		
	*/
	
	reg [7:0] dataRegPrimitive;
	initial dataRegPrimitive = 8'd0;
	always@(posedge clk) begin
		if(rst) begin
			dataRegPrimitive  <= 8'd0;
		end
		else if(load) begin
			dataRegPrimitive  <= bus;
		end
	end
	assign data = dataRegPrimitive ;

endmodule
