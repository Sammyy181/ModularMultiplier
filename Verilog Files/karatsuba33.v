`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.10.2025 13:38:31
// Design Name: 
// Module Name: karatsuba33
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


module karatsuba33(
	input wire clock,
	input wire reset,
	input wire [64:0] Xin,
	input wire [63:0] Yin,
	output reg [128:0] P
    );
    
    wire [64:0] P00, P11;
	wire [65:0] P10;
	
	reg [31:0] X0, Y0, Y1;
	reg [32:0] X1;
	reg [33:0] Sx, Sy;
	
	reg [64:0] P00_r, P11_r;
	reg [67:0] P10_r;
	
	reg [64:0] high, low;
	reg [66:0] mid;
	
	always @(posedge clock) begin
		if(reset) begin
			X0 <= 0;
			X1 <= 0;
			Y0 <= 0;
			Y1 <= 0;
			Sx <= 33'b0;
			Sy <= 33'b0;
			P00_r <= 0;  
			P11_r <= 0;
			P10_r <= 0;
			high <= 0;
			low <= 0;
			mid <= 0;
			P <= 0;
		end
		
		else begin
			X0 <= Xin[31:0];
			Y0 <= Yin[31:0];
			X1 <= Xin[64:32];
			Y1 <= Yin[63:32];
			Sx <= Xin[64:32] + Xin[31:0];
			Sy <= Yin[63:32] + Yin[31:0];
			
			// Store Mult outputs
			P00_r <= X0 * Y0;
			P11_r <= X1 * Y1;
			P10_r <= Sx * Sy;
			
			// Next Cycle
			high <= P11_r;
			low <= P00_r;
			mid <= P10_r - P11_r - P00_r;
			
			// Final Cycle
			P <= {high, 64'b0} + {mid, 32'b0} + low;		
		end
	end
endmodule