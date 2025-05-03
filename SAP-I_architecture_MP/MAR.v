`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:20:09 04/27/2025 
// Design Name: 
// Module Name:    MAR 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////////////////
//
//
//DEPRECATED	
//
//
//////////////////////////////////////////////////////////////////////////////////
module MAR(
    input [7:0] bus,
    input clk,rst,load,store,
    output [3:0] address
    );

	reg [3:0] addressRegPrimitive;
	initial addressRegPrimitive = 4'd0;
	always@(posedge clk) begin
		if(rst) begin
			addressRegPrimitive <= 4'd0;
		end
		else if(load || store) begin
			addressRegPrimitive <= bus[3:0];
		end
	end
	assign address = addressRegPrimitive;

endmodule
