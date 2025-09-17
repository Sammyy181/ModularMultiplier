`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.08.2025 18:31:34
// Design Name: 
// Module Name: topModule
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


module topModule(
	input wire clock,
	input wire reset,
	input wire in_valid,
	input wire [255:0] X,
	input wire [255:0] Y,
	output reg [255:0] Q,
	output reg out_valid
    );

	// Pre-Computed moduli wires here
	wire [127:0] C_low;
	wire [64:0] Y1Y0, Y2Y0, Y2Y1, Y3Y0, Y3Y1;

	assign [127:0] C_low = 128'h1c424d77f1b750a99cc6df2b0ee713a2;
	assign [64:0] Y1Y0 = 65'hb9092ca3009e644b;
	assign [64:0] Y2Y0 = 65'hd2dd30d1fd8adefd;
	assign [64:0] Y2Y1 = 65'h52589f1ee05b1c04;
	assign [64:0] Y3Y0 = 65'h12faca19e5664357a;
	assign [64:0] Y3Y1 = 65'haf280feb39347281;

	// First Multiplication Wires
	wire [511:0] product;
	wire prod_valid;

	karatsuba K1(.clock(clock),.in_valid(in_valid),.X(X),.Y(Y),.reset(reset),.P(product),.out_valid(prod_valid));

	// Reduction Multiplication 
	
	// Cycle 1
	reg redIn_valid;
	reg [383:0] Plow_1;
	reg [127:0] Ph;
	wire [383:0] redP;
	reg [64:0] X1X0;
	wire red_valid;
	reg valid_1;

	foldKaratsuba FK(.clock(clock),.reset(reset),.in_valid(redIn_valid),.X(Ph),.X1X0(X1X0),.Y(C_low),.Y1Y0(Y1Y0),.Y2Y0(Y2Y0),.Y2Y1(Y2Y1),.Y3Y0(Y3Y0),.Y3Y1(Y3Y1),.P(redP),.out_valid(red_valid));

	// Cycle 2
	reg [383:0] Plow_2;
	reg valid_2;

	// Cycle 3
	reg [383:0] Plow_3;
	reg valid_3;

	// Cycle 4
	reg [383:0] Plow_4;
	reg valid_4;

	// Cycle 5
	reg [383:0] Plow_5;
	reg valid_5;

	// Cycle 6
	reg [383:0] Plow_6;
	reg valid_6;

	// Cycle 7
	reg [383:0] Plow_7;
	reg valid_7;

	// Cycle 8
	reg [192:0] foldLow_8;
	reg [192:0] foldHigh_8;
	reg valid_8;

	// Cycle 9
	reg [384:0] reductionOut;
	reg valid_9;

	always @(posedge clock) begin
		if(reset) begin
			Q <= 256'b0;
			out_valid <= 1'b0;
		end

		// Consider 0th Cycle to provide X * Y
		// 1st Cycle
		Ph <= product[511:384];
		X1X0 <= product[511:448] + product[447:384];
		Plow_1 <= product[383:0];
		redIn_valid <= prod_valid;
		valid_1 <= red_valid;

		// 2nd Cycle
		Plow_2 <= Plow_1;
		valid_2 <= valid_1;

		// 3rd Cycle
		Plow_3 <= Plow_2;
		valid_3 <= valid_2;

		// 4th Cycle
		Plow_4 <= Plow_3;
		valid_4 <= valid_3;

		// 5th Cycle
		Plow_5 <= Plow_4;
		valid_5 <= valid_4;

		// 6th Cycle
		Plow_6 <= Plow_5;
		valid_6 <= valid_5;

		// 7th Cycle
		Plow_7 <= Plow_6;
		valid_7 <= valid_6;

		// 8th Cycle
		foldLow_8 <= Plow_7[191:0] + redP[191:0];
		foldHigh_8 <= Plow_7[383:192] + redP[383:192];
		valid_8 <= valid_7;

		// 9th Cycle 
		reductionOut <= {foldHigh_8[192:0]+foldLow_8[192],foldLow_8[191:0]};
		valid_9 <= valid_8;

	end

endmodule