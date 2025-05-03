`timescale 1ns / 1ps
module MemoryWrapperModule(
    input [7:0] bus,
	 input [7:0] accumalatorDataLine,
    input clk,rst,load,store,
    output [7:0] data,
	 output [7:0] displayRAMregister1,displayRAMregister2,displayRAMregister3
    );

	
	(* keep = "true" *) reg [7:0] memory [0:15];
	initial begin
		$readmemh("ram_init.bin",memory);
	end
		
	reg [3:0] marAddress;
	always@(posedge clk, posedge rst) begin
		if(rst) begin
			marAddress <= 4'd0;
		end
		else if(load) begin
			marAddress <= bus[3:0];
		end
		else if(store) begin
			//marAddress <= bus[3:0];
			memory[bus[3:0]] <= accumalatorDataLine;
		end
	end
		
	assign data = memory[marAddress];
	
	//these two registers are used for output purposes and RAM purpose.
	//data to be display onto 7 segment has to be written at addresses 15 and 14.
	
	assign displayRAMregister1 = memory[4'd15];
	assign displayRAMregister2 = memory[4'd14];
	assign displayRAMregister3 = memory[4'd13];
	
endmodule
