`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   15:13:35 04/27/2025
// Design Name:   RAM16x8
// Module Name:   /home/ise/SAP-I_architecture_MP/RAM_testbench.v
// Project Name:  SAP-I_architecture_MP
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: RAM16x8
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module RAM_testbench;

	// Inputs
	reg [3:0] add;

	// Outputs
	wire [7:0] out;

	// Instantiate the Unit Under Test (UUT)
	RAM16x8 uut (
		.add(add), 
		.out(out)
	);

	initial begin
		// Initialize Inputs
		add = 0;
		// Wait 100 ns for global reset to finish
		#10;
		add = 1;
		#10;
		add = 2;
		#10;
		add = 3;
		#10;
		add = 4;
		#10;
		add = 5;
		#10;
		add = 6;
		#10;
		add = 7;
		#10;
		add = 8;
      #10;
		add = 9;
		#10;
		add = 10;  
		// Add stimulus here

	end
      
endmodule

