`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.08.2025 18:42:31
// Design Name: 
// Module Name: topModule_tb
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


module topModule_tb();

	reg clk, rst, start;
	reg [255:0] X, Y;
	wire [255:0] Q;
	wire done;
	
	
	topModule uut (.clock(clk),.rst(rst),.start(start),.X(X),.Y(Y),.Q(Q),.done(done));
	
	initial begin
		clk <= 0;
		forever #10 clk <= ~clk ;
	end

	initial begin
		rst <= 1'b1;
		
		#15 rst <= 1'b0;
		
		//#15 X <= 256'h972a846916419f828b9d2434e465e150bd9c66b3ad3c2d6d1a3d1fa7bc8960a9;
		//#15 Y <= 256'h9a1de644815ef6d13b8faa1837f8a88b17fc695a07a0ca6e0822e8f36c031199;
		#15 X <= 256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF;
		#15 Y <= 256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF;
		
		#30 start <= 1'b1;  
		#20 start <= 1'b0;
	end
endmodule