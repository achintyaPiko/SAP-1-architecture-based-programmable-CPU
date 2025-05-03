`timescale 1ns / 1ps
module AdderSubtractor(
    input [7:0] a,b,
    input sub,
    output [7:0] result,
    output carry,borrow
    );
	
	wire [8:0] resultComplete;
	assign resultComplete = (sub)?a-b:a+b;
	
	assign result = resultComplete[7:0];
	assign carry = (sub)?1'b0:resultComplete[8];
	assign borrow = (sub)?resultComplete[8]:1'b0;
	
endmodule
