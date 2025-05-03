`timescale 1ns / 1ps
module ProgramCounter(
    input clk,rst,inc,
    output [7:0] bus
    );

	reg [3:0] progCount;
	initial progCount = 4'd0;
	always@(posedge clk) begin
		if(rst)
			progCount <= 4'd0;
		else if (inc)
			progCount <= progCount + 1'b1;
	end
	assign bus = {4'b0000, progCount};

endmodule
