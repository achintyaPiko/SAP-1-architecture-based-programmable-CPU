`timescale 1ns / 1ps
module InstructionRegister(
    input clk,rst,load,
    input [7:0] bus,
    output [3:0] opcode,operand
    );
	 
	 reg [7:0] busPrimitive;
	 always@(posedge clk) begin
		if(rst) begin
			busPrimitive <= 8'd0;
		end
		else if(load) begin
			busPrimitive <= bus;
		end
	 end

	assign opcode = busPrimitive[7:4];
	assign operand = busPrimitive[3:0];

endmodule
