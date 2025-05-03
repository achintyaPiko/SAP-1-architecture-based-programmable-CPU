`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   15:00:09 05/01/2025
// Design Name:   MemoryWrapperModule
// Module Name:   /home/ise/SAP-I_architecture_MP/memoryTB.v
// Project Name:  SAP-I_architecture_MP
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: MemoryWrapperModule
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module memoryTB;

	// Inputs
	reg [7:0] bus;
	reg [7:0] accumalatorDataLine;
	reg clk;
	reg rst;
	reg load;
	reg store;

	// Outputs
	wire [7:0] data;

	// Instantiate the Unit Under Test (UUT)
	MemoryWrapperModule uut (
		.bus(bus), 
		.accumalatorDataLine(accumalatorDataLine), 
		.clk(clk), 
		.rst(rst), 
		.load(load), 
		.store(store), 
		.data(data)
	);

	initial begin
		// Initialize Inputs
		bus = 0;
		accumalatorDataLine = 0;
		clk = 0;
		rst = 0;
		load = 0;
		store = 0;

		// Wait 100 ns for global reset to finish
		#20;
		bus = 1;
		accumalatorDataLine = 0;
		rst = 0;
		load = 1;
		store = 0;
		#20;
		bus = 1;
		accumalatorDataLine = 0;
		rst = 0;
		load = 0;
		store = 0;
		#20;
		bus = 2;
		accumalatorDataLine = 0;
		rst = 0;
		load = 1;
		store = 0;
		#20;
		bus = 2;
		accumalatorDataLine = 0;
		rst = 0;
		load = 0;
		store = 0;
		#20;
		bus = 2;
		accumalatorDataLine = 8'd255;
		rst = 0;
		load = 0;
		store = 1;
		#20;
		bus = 2;
		accumalatorDataLine = 0;
		rst = 0;
		load = 0;
		store = 0;
		#20;
		bus = 2;
		accumalatorDataLine = 0;
		rst = 0;
		load = 1;
		store = 0;
		
		#20;
		bus = 3;
		accumalatorDataLine = 0;
		rst = 0;
		load = 1;
		store = 0;
		#20;
		bus = 3;
		accumalatorDataLine = 0;
		rst = 0;
		load = 0;
		store = 0;
		#20;
		
		bus = 3;
		accumalatorDataLine = 8'hEE;
		rst = 0;
		load = 0;
		store = 1;
		#20;
		bus = 3;
		accumalatorDataLine = 0;
		rst = 0;
		load = 0;
		store = 0;
		
		#20;
		bus = 3;
		accumalatorDataLine = 0;
		rst = 0;
		load = 1;
		store = 0;
		#20;
		bus = 3;
		accumalatorDataLine = 0;
		rst = 0;
		load = 0;
		store = 0;
		#20;
        
		// Add stimulus here

	end
	always #5 clk = ~clk;
      
endmodule

