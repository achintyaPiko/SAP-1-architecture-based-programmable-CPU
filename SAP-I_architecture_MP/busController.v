`timescale 1ns / 1ps
module busController(
    input clk,
    input [7:0] adder_out, inst_reg_out, memory_out, pc_out, accum_out,
    input [4:0] bus_controlSignals,
    output [7:0] bus_driven
    );

	
	/*
		Bus Control Signal format:
		adder_enabletoBUS 			= 0th bit
		inst_reg_enabletoBUS 		= 1st bit
		memory_enabletoBUS 			= 2nd bit
		PC_enabletoBUS 				= 3rd bit
		accumalator_enabletoBUS 	= 4th bit
		
		BUS CONTENTION IS NOT HANDLED 
		IF MULTIPLE ENABLE SIGNALS ACTIVE BUS CONTROLLER FREAKS OUT
		
		Bus arbitration can be implemented in the future by raising HLT and shooting the CPU in its head at multiple
		enable asserts
		
		
	*/
	wire add_en,inst_en,mem_en,pc_en,acc_en;
	assign add_en 		= bus_controlSignals[0];
	assign inst_en 	= bus_controlSignals[1];
	assign mem_en 		= bus_controlSignals[2];
	assign pc_en 		= bus_controlSignals[3];
	assign acc_en 		= bus_controlSignals[4];
	
	assign bus_driven = 	(add_en)?adder_out:
								(inst_en)?inst_reg_out:
								(mem_en)?memory_out:
								(pc_en)?pc_out:
								(acc_en)?accum_out:
								8'd0;
endmodule
