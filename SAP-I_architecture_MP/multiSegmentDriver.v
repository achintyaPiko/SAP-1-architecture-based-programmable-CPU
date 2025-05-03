`timescale 1ns / 1ps
module multiSegmentDriver(
			input clk,latch,en,
			input [3:0] hexNumberDigit1,hexNumberDigit2,hexNumberDigit3,hexNumberDigit4,
			output reg a,b,c,d,e,f,g,
			output dp,
			output reg [3:0] enableDigit
    );
	
	
	assign dp = 1'b1;
	/*
	
	4 digit - 7 segment driver module
	
	Character supported:
	0,1,2,3,4,5,6,7,8,9,A,b,C,d,E,F
	
	Intended Use:
	write data to display onto the appropriate hexNumber Buses and latch it. 
	Data can be deasserted without repurcussions once latched. enable to enable display segments.
	Right most segment is numbered 1, 
	left most is numbered 4.
	
	Limitations:
	The onboard 4 digit 7 segment display does not work for very high clock rates. Recommended clock for 
	segment driver is 500Hz. Maximum is 1kHz.
	*/
	
	reg [3:0] digit_1,digit_2,digit_3,digit_4;
	reg [1:0] presentSegmentNumber;
	reg [3:0] presentSegmentData;
	
	
	initial begin
		digit_1 = 4'd0;
		digit_2 = 4'd0;
		digit_3 = 4'd0;
		digit_4 = 4'd0;
		presentSegmentNumber = 2'd0;
		presentSegmentData = 4'd0;
	end
	
	always@(posedge latch) begin
		digit_1 <= hexNumberDigit1;
		digit_2 <= hexNumberDigit2;
		digit_3 <= hexNumberDigit3;
		digit_4 <= hexNumberDigit4;
	end
	
	always@(posedge clk) begin
		case(presentSegmentNumber)
			2'd0:	begin
					//First Segment is being driven now
					enableDigit <= 4'b1110;
					presentSegmentData <= digit_1;
					end
			2'd1:	begin
					//Second Segment is being driven now
					enableDigit <= 4'b1101;
					presentSegmentData <= digit_2;
					end
			2'd2:	begin
					//Third Segment is being driven now
					enableDigit <= 4'b1011;
					presentSegmentData <= digit_3;
					end
			2'd3:	begin
					//Fourth Segment is being driven now
					enableDigit <= 4'b0111;
					presentSegmentData <= digit_4;
					end
		endcase		
		presentSegmentNumber <= presentSegmentNumber + 1'b1;	
	end

	always@(presentSegmentData or en) begin
		case(presentSegmentData)
			4'd0:	begin
						a <= 1'b0 | ~en;
						b <= 1'b0 | ~en;
						c <= 1'b0 | ~en;
						d <= 1'b0 | ~en;
						e <= 1'b0 | ~en;
						f <= 1'b0 | ~en;
						g <= 1'b1 | ~en;
					end
			4'd1:	begin
						a <= 1'b1 | ~en;
						b <= 1'b0 | ~en;
						c <= 1'b0 | ~en;
						d <= 1'b1 | ~en;
						e <= 1'b1 | ~en;
						f <= 1'b1 | ~en;
						g <= 1'b1 | ~en;
					end
			4'd2:	begin
						a <= 1'b0 | ~en;
						b <= 1'b0 | ~en;
						c <= 1'b1 | ~en;
						d <= 1'b0 | ~en;
						e <= 1'b0 | ~en;
						f <= 1'b1 | ~en;
						g <= 1'b0 | ~en;
					end
			4'd3:	begin
						a <= 1'b0 | ~en;
						b <= 1'b0 | ~en;
						c <= 1'b0 | ~en;
						d <= 1'b0 | ~en;
						e <= 1'b1 | ~en;
						f <= 1'b1 | ~en;
						g <= 1'b0 | ~en;
					end
			4'd4:	begin
						a <= 1'b1 | ~en;
						b <= 1'b0 | ~en;
						c <= 1'b0 | ~en;
						d <= 1'b1 | ~en;
						e <= 1'b1 | ~en;
						f <= 1'b0 | ~en;
						g <= 1'b0 | ~en;
					end
			4'd5:	begin
						a <= 1'b0 | ~en;
						b <= 1'b1 | ~en;
						c <= 1'b0 | ~en;
						d <= 1'b0 | ~en;
						e <= 1'b1 | ~en;
						f <= 1'b0 | ~en;
						g <= 1'b0 | ~en;
					end
			4'd6:	begin
						a <= 1'b0 | ~en;
						b <= 1'b1 | ~en;
						c <= 1'b0 | ~en;
						d <= 1'b0 | ~en;
						e <= 1'b0 | ~en;
						f <= 1'b0 | ~en;
						g <= 1'b0 | ~en;
					end		
			4'd7:	begin
						a <= 1'b0 | ~en;
						b <= 1'b0 | ~en;
						c <= 1'b0 | ~en;
						d <= 1'b1 | ~en;
						e <= 1'b1 | ~en;
						f <= 1'b1 | ~en;
						g <= 1'b1 | ~en;
					end
			4'd8:	begin
						a <= 1'b0 | ~en;
						b <= 1'b0 | ~en;
						c <= 1'b0 | ~en;
						d <= 1'b0 | ~en;
						e <= 1'b0 | ~en;
						f <= 1'b0 | ~en;
						g <= 1'b0 | ~en;
					end
			4'd9:	begin
						a <= 1'b0 | ~en;
						b <= 1'b0 | ~en;
						c <= 1'b0 | ~en;
						d <= 1'b0 | ~en;
						e <= 1'b1 | ~en;
						f <= 1'b0 | ~en;
						g <= 1'b0 | ~en;
					end
			4'd10:begin
						a <= 1'b0 | ~en;
						b <= 1'b0 | ~en;
						c <= 1'b0 | ~en;
						d <= 1'b1 | ~en;
						e <= 1'b0 | ~en;
						f <= 1'b0 | ~en;
						g <= 1'b0 | ~en;
					end
			4'd11:begin
						a <= 1'b1 | ~en;
						b <= 1'b1 | ~en;
						c <= 1'b0 | ~en;
						d <= 1'b0 | ~en;
						e <= 1'b0 | ~en;
						f <= 1'b0 | ~en;
						g <= 1'b0 | ~en;
					end
			4'd12:begin
						a <= 1'b0 | ~en;
						b <= 1'b1 | ~en;
						c <= 1'b1 | ~en;
						d <= 1'b0 | ~en;
						e <= 1'b0 | ~en;
						f <= 1'b0 | ~en;
						g <= 1'b1 | ~en;
					end
			4'd13:begin
						a <= 1'b1 | ~en;
						b <= 1'b0 | ~en;
						c <= 1'b0 | ~en;
						d <= 1'b0 | ~en;
						e <= 1'b0 | ~en;
						f <= 1'b1 | ~en;
						g <= 1'b0 | ~en;
					end
			4'd14:begin
						a <= 1'b0 | ~en;
						b <= 1'b1 | ~en;
						c <= 1'b1 | ~en;
						d <= 1'b0 | ~en;
						e <= 1'b0 | ~en;
						f <= 1'b0 | ~en;
						g <= 1'b0 | ~en;
					end
			4'd15:begin
						a <= 1'b0 | ~en;
						b <= 1'b1 | ~en;
						c <= 1'b1 | ~en;
						d <= 1'b1 | ~en;
						e <= 1'b0 | ~en;
						f <= 1'b0 | ~en;
						g <= 1'b0 | ~en;
					end
		endcase		
	end
endmodule
