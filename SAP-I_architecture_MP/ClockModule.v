`timescale 1ns / 1ps
module ClockModule(
    input clk_in, halt,
    output scaled_clk_out, SYS_clk
    );
	//scaling down the 32Mhz clock to 1Mhz for sysclk 
	//and then to ~500Hz for the segment display.
	reg [15:0] divider;
	initial divider = 16'd0;
	
	always@(posedge clk_in) begin
		divider <= divider + 1'b1;
	end
	
	assign SYS_clk = ~halt & divider[4];
	assign scaled_clk_out = divider[15];
	
endmodule
