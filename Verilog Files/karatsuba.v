`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.07.2025 21:31:37
// Design Name: 
// Module Name: karatsuba
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

module karatsuba(
    input wire clock,
    input wire in_valid,
    input wire [255:0] X,
    input wire [255:0] Y,
    input wire reset,
    output reg [511:0] P
    );
    
    //1st Cycle 
    reg [127:0] P00, P11, P22, P33;
    reg [64:0] S10X, S10Y, S20X, S20Y, S21X, S21Y, S30X, S30Y, S31X, S31Y, S32X, S32Y;
    reg valid_0;
    
    //2nd Cycle
    reg [128:0] P1P0, P2P0, P2P1, P3P0, P3P1, P3P2;
    reg [129:0] S10, S20, S21, S30, S31, S32;
    reg [127:0] T0K_1, P11_1, P22_1, T6K_1;
    reg valid_1;
    
    //3rd Cycle
    reg [128:0] T1K_2, T5K_2, M20, M21, M30, M31;
    reg [127:0] T0K_2, P11_2, P22_2, T6K_2;
    reg valid_2;
    
    //4th Cycle
    reg [128:0] T2K_3, T4K_3;
    reg [128:0] upSum_3;
    reg [129:0] T3K_3;
    reg [129:0] lowSum_3;
    reg [63:0] result_3;
    reg [63:0] T5K_L;
    reg valid_3;
     
    
    always @(posedge clock) begin
    	if(reset) begin
    		P <= 512'b0;
    		valid_0 <= 1'b0;
    		valid_1 <= 1'b0;
    		valid_2 <= 1'b0;
    		valid_3 <= 1'b0;
		end
    		
    	else begin
    		// 1st Cycle
    		P00[127:0] <= X[63:0] * Y[63:0];
    		P11[127:0] <= X[127:64] * Y[127*64];
    		P22[127:0] <= X[191:128] * Y[191:128];
    		P33[127:0] <= X[255:0] * Y[255:0];
    		
    		S10X <= X[127:64] + X[63:0];
    		S20X <= X[191:128] + X[63:0];
    		S30X <= X[255:192] + X[63:0];
    		S21X <= X[191:128] + X[127:64];
    		S31X <= X[255:192] + X[127:64];
    		S32X <= X[255:192] + X[191:128];
    		
    		S10Y <= Y[127:64] + Y[63:0];
			S20Y <= Y[191:128] + Y[63:0];
			S30Y <= Y[255:192] + Y[63:0];
			S21Y <= Y[191:128] + Y[127:64];
			S31Y <= Y[255:192] + Y[127:64];
			S32Y <= Y[255:192] + Y[191:128];
			
			valid_0 <= in_valid;
    		
    		// 2nd Cycle
    		S10 <= S10X * S10Y;
    		S20 <= S20X * S20Y;
    		S21 <= S21X * S21Y;
    		S30 <= S30X * S30Y;
    		S31 <= S31X * S31Y;
    		S32 <= S32X * S32Y;
    		
    		P1P0 <= P11 + P00;
    		P2P0 <= P22 + P00;
    		P2P1 <= P22 + P11;
    		P3P0 <= P33 + P00;
    		P3P1 <= P33 + P11;
    		P3P2 <= P33 + P22;
    		
    		T0K_1 <= P00;
    		P11_1 <= P11;
    		P22_1 <= P22;
    		T6K_1 <= P33;
    		
    		valid_1 <= valid_0;
    		
    		// 3rd Cycle
    		T1K_2[128:0] <= S10[129:0] - P1P0[128:0];
    		M20[128:0] <= S20[129:0] - P2P0[128:0];
    		M21[128:0] <= S21[129:0] - P2P1[128:0];
    		M30[128:0] <= S30[129:0] - P3P0[128:0];
    		M31[128:0] <= S31[129:0] - P3P1[128:0];
    		T5K_2[128:0] <= S32[129:0] - P3P2[128:0];
    		
    		T0K_2 <= T0K_1;
    		P11_2 <= P11_1;
    		P22_2 <= P22_1;
    		T6K_2 <= T6K_1;
    		
    		valid_2 <= valid_1;
    		
    		// 4th Cycle
    		result_3[63:0] <= T0K_2[63:0];
    		lowSum_3[129:0] <= T1K_2[128:0] + T0K_2[127:64];
    		T2K_3 <= P11_2 + M20;
    		T3K_3 <= M30 + M21;
    		T4K_3 <= P22_2 + M31;
    		T5K_L[63:0] <= T5K_2[63:0];
    		upSum_3[128:0] <= T5K_2[128:64] + T6K_2;
    		
    		valid_3 <= valid_2;
    		
    	end 
	end 
    		
		
endmodule 