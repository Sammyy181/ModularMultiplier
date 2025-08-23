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
	
	topModule uut (.clk(clk),.rst(rst),.start(start),.X(X),.Y(Y),.Q(Q),.done(done));
	
	initial begin
		clk <= 0;
		forever #10 clk <= ~clk ;
	end

	initial begin
		rst <= 1'b1;
		
		#15 rst <= 1'b0;
		
		#15 X <= 256'd68374361576449959379811878238702970795767227995234058958640265755013581201577;
		#15 Y <= 256'd69709006495262083753438964270882567809667203355268795714903518762464260067737;
		
		#30 start <= 1'b1;  
		#45 start <= 1'b0;
	end
endmodule
