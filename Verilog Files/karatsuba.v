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
    input wire [255:0] Xin,
    input wire [255:0] Yin,
    input wire reset,
    output reg [511:0] P,
	output reg out_valid
    );
    
    reg [255:0] X, Y;
    
    //1st Cycle 
    wire [127:0] P11, P22, P33, P00; 
    reg [64:0] S10X, S10Y, S20X, S20Y, S21X, S21Y, S30X, S30Y, S31X, S31Y, S32X, S32Y;
    
    // 1.1, 1.2, 1.3
    reg [64:0] S10X_1, S10Y_1, S20X_1, S20Y_1, S21X_1, S21Y_1, S30X_1, S30Y_1, S31X_1, S31Y_1, S32X_1, S32Y_1;
    reg [64:0] S10X_2, S10Y_2, S20X_2, S20Y_2, S21X_2, S21Y_2, S30X_2, S30Y_2, S31X_2, S31Y_2, S32X_2, S32Y_2;
    reg [64:0] S10X_3, S10Y_3, S20X_3, S20Y_3, S21X_3, S21Y_3, S30X_3, S30Y_3, S31X_3, S31Y_3, S32X_3, S32Y_3;
    
    reg valid_0;
    
    //2nd Cycle
    reg [128:0] P1P0, P2P0, P2P1, P3P0, P3P1, P3P2;
    reg [129:0] S10, S20, S21, S30, S31, S32;
    reg [127:0] P11_1, P22_1, T6K_1, T0K_1; 
    reg valid_1;
    
    //3rd Cycle
    reg [128:0] T1K_2, T5K_2, M21, M30, M31, M20;
    reg [127:0] P11_2, P22_2, T6K_2, T0K_2;
    reg valid_2;
    
    //4th Cycle
    reg [129:0] T2K_3, T4K_3;
    reg [128:0] upSum_3;
    reg [129:0] T3K_3;
    reg [129:0] lowSum_3;
    reg [63:0] result_3;
    reg [63:0] T5K_L;
    reg valid_3;

	//5th Cycle
	reg [127:0] result_4;
	reg [129:0] sum3_4;
	reg [129:0] T3K_4;
	reg [63:0] T4K_L_4;
	reg [65:0] sum5_4;
	reg [128:0] upSum_4;
	reg valid_4;

	//6th Cycle
	reg [191:0] result_5;
	reg [130:0] sum4_5;
	reg [63:0] T4K_L_5;
	reg [191:0] upSum_5;
	reg valid_5;

	//7th Cycle
	reg [255:0] result_6;
	reg	[67:0] sum5_6;
	reg [191:0] upSum_6;
	reg valid_6;
     
    karatsuba32 K00(.clock(clock),.reset(reset),.Xin(X[63:0]),.Yin(Y[63:0]),.P(P00));
    karatsuba32 K11(.clock(clock),.reset(reset),.Xin(X[127:64]),.Yin(Y[127:64]),.P(P11));
    karatsuba32 K22(.clock(clock),.reset(reset),.Xin(X[191:128]),.Yin(Y[191:128]),.P(P22));
    karatsuba32 K33(.clock(clock),.reset(reset),.Xin(X[255:192]),.Yin(Y[255:192]),.P(P33));
    
    always @(posedge clock) begin
    	if(reset) begin
    		P <= 512'b0;
    		X <= 256'b0;
    		Y <= 256'b0;
			out_valid <= 1'b0;
			valid_0 <= 1'b0;
			valid_1 <= 1'b0;
			valid_2 <= 1'b0;
			valid_3 <= 1'b0;
			valid_4 <= 1'b0;
			valid_5 <= 1'b0;
			valid_6 <= 1'b0;
		end
    		
    	else begin
    		// 0th Cycle
    		X <= Xin;
    		Y <= Yin;
    	
    		// 1st Cycle
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
			
			// 1.1 Cycle
			S10X_1 <= S10X;
			S20X_1 <= S20X;
			S30X_1 <= S30X;
			S21X_1 <= S21X;
			S31X_1 <= S31X;
			S32X_1 <= S32X;
			
			S10Y_1 <= S10Y;
			S20Y_1 <= S20Y;
			S30Y_1 <= S30Y;
			S21Y_1 <= S21Y;
			S31Y_1 <= S31Y;
			S32Y_1 <= S32Y;
			
			// 1.2 Cycle
			S10X_2 <= S10X_1;
			S20X_2 <= S20X_1;
			S30X_2 <= S30X_1;
			S21X_2 <= S21X_1;
			S31X_2 <= S31X_1;
			S32X_2 <= S32X_1;
			
			S10Y_2 <= S10Y_1;
			S20Y_2 <= S20Y_1;
			S30Y_2 <= S30Y_1;
			S21Y_2 <= S21Y_1;
			S31Y_2 <= S31Y_1;
			S32Y_2 <= S32Y_1;
			
			// 1.3 Cycle (Ready Here)
			S10X_3 <= S10X_2;
			S20X_3 <= S20X_2;
			S30X_3 <= S30X_2;
			S21X_3 <= S21X_2;
			S31X_3 <= S31X_2;
			S32X_3 <= S32X_2;
			
			S10Y_3 <= S10Y_2;
			S20Y_3 <= S20Y_2;
			S30Y_3 <= S30Y_2;
			S21Y_3 <= S21Y_2;
			S31Y_3 <= S31Y_2;
			S32Y_3 <= S32Y_2;
    		
    		// 2nd Cycle
    		S10 <= S10X_3 * S10Y_3;
    		S20 <= S20X_3 * S20Y_3;
    		S21 <= S21X_3 * S21Y_3;
    		S30 <= S30X_3 * S30Y_3;
    		S31 <= S31X_3 * S31Y_3;
    		S32 <= S32X_3 * S32Y_3;
    		
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

			// 5th Cycle
			result_4[127:0] <= {lowSum_3[63:0],result_3[63:0]};
			sum3_4[129:0] <= T2K_3 + lowSum_3[129:64];
			T3K_4 <= T3K_3;
			T4K_L_4[63:0] <= T4K_3[63:0];
			sum5_4[65:0] <= T4K_3[129:64] + T5K_L[63:0];
			upSum_4 <= upSum_3;

			valid_4 <= valid_3;

			// 6th Cycle
			result_5[191:0] <= {sum3_4[63:0], result_4[127:0]};
			sum4_5 <= sum3_4[129:64] + T3K_4;
			T4K_L_5 <= T4K_L_4;
			upSum_5[191:0] <= {(upSum_4 + sum5_4[65:64]), sum5_4[63:0]};

			valid_5 <= valid_4;

			// 7th Cycle
			result_6[255:0] <= {sum4_5[63:0], result_5[191:0]};
			sum5_6[67:0] <= sum4_5[130:64] + T4K_L_5;
			upSum_6 <= upSum_5;

			valid_6 <= valid_5;

			// 8th Cycle
			P[511:0] <= {(upSum_6 + sum5_6[67:64]),sum5_6[63:0],result_6[255:0]};

			out_valid <= valid_6;
    		
    	end 
	end 
endmodule 