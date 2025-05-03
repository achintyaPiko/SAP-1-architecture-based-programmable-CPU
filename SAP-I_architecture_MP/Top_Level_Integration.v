`timescale 1ns / 1ps
module Top_Level_Integration(
		input clk_32, rst, clk_select, ext_clk,
		output a,b,c,d,e,f,g,
		output dp,
		output [3:0] enableDigit,
		output [7:0] leds,
		output carry_out,borrow_out	//additional flags
	 );
	
	wire scaled_clk_out;	// 488Hz
	wire SYS_clk;			//1Mhz
	assign carry_out = ~carry;
	assign borrow_out = ~borrow;
	wire [7:0] bus;
	wire [3:0] operand;
	wire [3:0] opcode;	
	wire [7:0] A_output;
	wire [7:0] B_output;
	wire [7:0] Adder_output;
	wire [7:0] Mem_output;
	wire [7:0] PC_output; 
	wire [7:0] IR_output;
	assign IR_output = {opcode,operand};	
	
	wire [7:0] displayRAMregister1;
	wire [7:0] displayRAMregister2;
	wire [7:0] displayRAMregister3;
	
	assign leds = displayRAMregister3;
	
	/*
	assign add_en 		= bus_controlSignals[0];
	assign inst_en 	= bus_controlSignals[1];
	assign mem_en 		= bus_controlSignals[2];
	assign pc_en 		= bus_controlSignals[3];
	assign acc_en 		= bus_controlSignals[4];
	*/
	
	wire [4:0] busControl;
	assign busControl = {a_en_bus,pc_en_bus,mem_en_bus,ir_en_bus,adder_en_bus};
	
	
	
	//control signals
	wire halt;				
	wire pc_inc;
	wire pc_en_bus;
	wire mem_load;
	wire mem_store;
	wire mem_en_bus;
	wire ir_load;
	wire ir_en_bus;
	wire a_load;
	wire a_en_bus;
	wire b_load;
	wire subtract;
	wire adder_en_bus;
	wire segment_latch;
	
	wire clkModule_clock;
	ClockModule clkModule (
    .clk_in(clk_32), 
    .halt(halt), 
    .scaled_clk_out(scaled_clk_out), 
    .SYS_clk(clkModule_clock)
	);
	
	
	//if clk_select set then external clock else onboard crystal clock is used.
	assign SYS_clk = (clk_select)?ext_clk:clkModule_clock;
	
	controlSignalGenerator SignalGen (
    .clk(SYS_clk), 
    .rst(rst), 
    .opcode(opcode), 
    .hlt(halt), 
    .pc_inc(pc_inc), 
    .pc_en_bus(pc_en_bus), 
    .mem_load(mem_load), 
    .mem_store(mem_store), 
    .mem_en_bus(mem_en_bus), 
    .ir_load(ir_load), 
    .ir_en_bus(ir_en_bus), 
    .a_load(a_load), 
    .a_en_bus(a_en_bus), 
    .b_load(b_load), 
    .subtract(subtract), 
    .adder_en_bus(adder_en_bus), 
    .segment_latch(segment_latch)
    );
	 	
	InstructionRegister InstReg (
    .clk(SYS_clk), 
    .rst(rst), 
    .load(ir_load), 
    .bus(bus), 
    .opcode(opcode), 
    .operand(operand)
	);
	
	accumlator A_register (
    .clk(SYS_clk), 
    .rst(rst), 
    .load(a_load), 
    .bus(bus), 
    .data(A_output)
    );
	 
	 accumlator B_register (
    .clk(SYS_clk), 
    .rst(rst), 
    .load(b_load), 
    .bus(bus), 
    .data(B_output)
    );
	 
	 busController BusControl (
    .clk(SYS_clk), 
    .adder_out(Adder_output), 
    .inst_reg_out(IR_output), 
    .memory_out(Mem_output), 
    .pc_out(PC_output), 
    .accum_out(A_output), 
    .bus_controlSignals(busControl), 
    .bus_driven(bus)
    );
	 
	 AdderSubtractor AddSub (
    .a(A_output), 
    .b(B_output), 
    .sub(subtract), 
    .result(Adder_output), 
    .carry(carry), 
    .borrow(borrow)
    );
	
	 ProgramCounter PC (
    .clk(SYS_clk), 
    .rst(rst), 
    .inc(pc_inc), 
    .bus(PC_output)
    );
	 
	 MemoryWrapperModule Memory (
    .bus(bus), 
    .accumalatorDataLine(A_output), 
    .clk(SYS_clk), 
    .rst(rst), 
    .load(mem_load), 
    .store(mem_store), 
    .data(Mem_output), 
    .displayRAMregister1(displayRAMregister1), 
    .displayRAMregister2(displayRAMregister2),
	 .displayRAMregister3(displayRAMregister3)
    );
	 
	 //reg1 15 ka hai
	 //reg2 14 ka hai
	 //left 2 digits will display 8bit data of address 15
	 //right 2 digits will display 8bit data of address 14
	 //controller has left as 4 right as 1
	 wire en;
	 assign en = 1'b1;
	 	 
	 wire [3:0] hexNumberDigit1;
	 assign hexNumberDigit1 = displayRAMregister2[3:0];
	 
	 wire [3:0] hexNumberDigit2;
	 assign hexNumberDigit2 = displayRAMregister2[7:4];
	 
	 wire [3:0] hexNumberDigit3;
	 assign hexNumberDigit3 = displayRAMregister1[3:0];
	  
	 wire [3:0] hexNumberDigit4;
	 assign hexNumberDigit4 = displayRAMregister1[7:4];
	 
	 multiSegmentDriver display (
    .clk(scaled_clk_out), 
    .latch(segment_latch), 
    .en(en), 
    .hexNumberDigit1(hexNumberDigit1), 
    .hexNumberDigit2(hexNumberDigit2), 
    .hexNumberDigit3(hexNumberDigit3), 
    .hexNumberDigit4(hexNumberDigit4), 
    .a(a), 
    .b(b), 
    .c(c), 
    .d(d), 
    .e(e), 
    .f(f), 
    .g(g), 
    .dp(dp), 
    .enableDigit(enableDigit)
    );
	

endmodule
