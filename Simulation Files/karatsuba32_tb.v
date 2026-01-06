`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04.10.2025 19:23:21
// Design Name: 
// Module Name: karatsuba32_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module karatsuba32_tb();

	reg clock = 1'b0;
	reg reset;
	reg [63:0] Xin, Yin;
	wire [127:0] P;
	wire [63:0] high, low;
	wire [64:0] mid;
	
	karatsuba32 K32(.clock(clock),.reset(reset),.Xin(Xin),.Yin(Yin),.P(P),.high(high),.low(low),.mid(mid));
	
	initial begin
		forever #5 clock <= ~clock;
	end
	
	initial begin
		reset <= 1'b1;
		
		Xin <= 64'h972a846916419f82;
		Yin <= 64'h9a1de644815ef6d1;
		
		#15 reset <= 1'b0;
	end
endmodule