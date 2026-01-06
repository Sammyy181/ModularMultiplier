`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06.10.2025 12:28:29
// Design Name: 
// Module Name: pipelineFoldKaratsuba_tb
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


`timescale 1ns / 1ps

module pipelineFoldKaratsuba_tb();

	reg clock, reset;
	reg in_valid;
	reg [127:0] X;
	reg [64:0] X1X0;
	wire [383:0] P;
	wire out_valid;
	wire [127:0] result_4;
	wire [129:0] sum_1;
	wire [127:0] P00_2;
	wire [128:0] T1K_2;
	
	foldKaratsuba FK(.clock(clock),.reset(reset),.in_valid(in_valid),.X(X),.X1X0(X1X0),.P(P),.out_valid(out_valid),.result_4(result_4),
			.sum_1(sum_1),.P00_2(P00_2),.T1K_2(T1K_2));
	
	initial begin
		clock <= 1'b0;
		forever #10 clock = ~clock;
	end

	initial begin
	
		reset <= 1'b1;
		X <= 128'b0;
		X1X0 <= 65'b0;
		
		#15 reset <= 1'b0;
		X <= 128'h5b013b70ddf11560736ff50d7c982339;
		X1X0 <= 65'hce71307e5a893899;
		
		#20 X <= 128'hffffffffffffffffffffffffffffffff;
		X1X0 <= 65'h1fffffffffffffffe;
	
	end

endmodule