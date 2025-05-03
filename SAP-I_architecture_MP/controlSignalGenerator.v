`timescale 1ns / 1ps
module controlSignalGenerator(
		input clk,rst,
		input [3:0] opcode,
		output 	hlt, pc_inc, pc_en_bus,
					mem_load, mem_store, mem_en_bus,
					ir_load, ir_en_bus, a_load, a_en_bus,
					b_load, subtract, adder_en_bus, segment_latch
					
);
/*

	Different modules and their different control signals and flags;
	
	global rst on all is present mostly. rst wont ever be asserted by controlSignalGenerator
	
	AdderSubtractor: sub [FLAGS: carry,borrow]
	clockModule: halt
	instructionRegister: load
	memoryWrapper: load,store
	programCounter: pc_inc
	Accumalator A: load
	Accumalator B: load
	BusController signals:addEN,irEN,memEN,pcEN,aEN
	
	this guy will monitor the last 2 register of the memory for display purposes.
	7 segment controller: lat
	
	Different control signals generated in theory:
	hlt       		Halt execution of the computer
	pc_inc   		Increment the Program Counter
	pc_en_bus     	Put the value in the Program Counter onto the bus
	mem_load  		Load an address into the Memory Address Register
	mem_store 		Store accumalator data into the Memory Address Register
	mem_en_bus    	Put a value from memory onto the bus
	ir_load   		Load a value from the bus into the Instruction Register
	ir_en_bus     	Put the value in the Instruction Register onto the bus
	a_load    		Load a value from the bus into A
	a_en_bus      	Put the value in A onto the bus
	b_load    		Load a value from the bus into B
	subtract 		Subtract the value in B from A
	adder_en_bus  	Put the adder's value onto the bus
	
		
*/
	
	/*opcodes to decipher and generate signals for*/
	parameter LOAD 		= 4'b0000;
	parameter ADD 			= 4'b0001;
	parameter SUB	 		= 4'b0010;
	parameter STORE	 	= 4'b0100;
	parameter OUT 			= 4'b1110;
	parameter HLT	 		= 4'b1111;
	
	reg	Reg_hlt, Reg_pc_inc, Reg_pc_en_bus,
			Reg_mem_load, Reg_mem_store, Reg_mem_en_bus,
			Reg_ir_load, Reg_ir_en_bus, Reg_a_load, Reg_a_en_bus,
			Reg_b_load, Reg_subtract, Reg_adder_en_bus, Reg_segment_latch;
			
	assign hlt = Reg_hlt;
	assign pc_inc = Reg_pc_inc;
	assign pc_en_bus = Reg_pc_en_bus;
	assign mem_load = Reg_mem_load;
	assign mem_store = Reg_mem_store;
	assign mem_en_bus = Reg_mem_en_bus;
	assign ir_load = Reg_ir_load;
	assign ir_en_bus = Reg_ir_en_bus;
	assign a_load = Reg_a_load;
	assign a_en_bus = Reg_a_en_bus;
	assign b_load = Reg_b_load;
	assign subtract = Reg_subtract;
	assign adder_en_bus = Reg_adder_en_bus;
	assign segment_latch = Reg_segment_latch;
	
	reg [2:0] state;
	initial state = 3'd0;		
	
	always@(negedge clk, posedge rst) begin
		if (rst) begin
			state <= 0;
		end 
		else begin
			if (state == 3'd5) begin
				state <= 0;
			end 
			else begin
			state <= state + 1'b1;
			end
		end
	end
	
	always@(state, opcode) begin
		Reg_hlt 				= 1'b0;
		Reg_pc_inc 			= 1'b0;
		Reg_pc_en_bus 		= 1'b0;
		Reg_mem_load 		= 1'b0;
		Reg_mem_store 		= 1'b0;
		Reg_mem_en_bus 	= 1'b0;
		Reg_ir_load 		= 1'b0;
		Reg_ir_en_bus 		= 1'b0;
		Reg_a_load 			= 1'b0;
		Reg_a_en_bus 		= 1'b0;
		Reg_b_load 			= 1'b0;
		Reg_subtract 		= 1'b0;
		Reg_adder_en_bus 	= 1'b0;
		Reg_segment_latch = 1'b0;
			
		case (state)
			3'd0: begin
				Reg_pc_en_bus = 1;
				Reg_mem_load = 1;
			end
			3'd1: begin
				Reg_pc_inc = 1;
			end
			3'd2: begin
				Reg_mem_en_bus = 1;
				Reg_ir_load = 1;
			end
			3'd3: begin
				case (opcode)
					LOAD: begin
						Reg_ir_en_bus = 1;
						Reg_mem_load = 1;
					end
					ADD: begin
						Reg_ir_en_bus = 1;
						Reg_mem_load = 1;
					end
					SUB: begin
						Reg_ir_en_bus = 1;
						Reg_mem_load= 1;
					end
					HLT: begin
						Reg_hlt = 1;
					end
					OUT:begin
						Reg_segment_latch = 1;
					end
					STORE:begin
						Reg_ir_en_bus = 1;
						Reg_mem_store = 1;
					end
				endcase
			end
			3'd4: begin
				case (opcode)
					LOAD: begin
						Reg_mem_en_bus = 1;
						Reg_a_load = 1;
					end
					ADD: begin
						Reg_mem_en_bus = 1;
						Reg_b_load = 1;
					end
					SUB: begin
						Reg_mem_en_bus = 1;
						Reg_b_load = 1;
					end
				endcase
			end
			3'd5: begin
				case (opcode)
					ADD: begin
						Reg_adder_en_bus = 1;
						Reg_a_load = 1;
					end
					SUB: begin
						Reg_subtract = 1;
						Reg_adder_en_bus = 1;
						Reg_a_load = 1;
					end
				endcase
			end
		endcase
	end
	
endmodule
