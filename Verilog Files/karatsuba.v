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
    input wire [255:0] A,
    input wire [255:0] B,
    input wire reset,
    input wire start,
    output reg [511:0] P,
    output reg done
    );
    
    reg [127:0] Phh, Phl, Plh, Pll; // Store Ahh * Bhh, Ahl * Bhl, Alh * Blh & All * Bll
    reg [64:0] Ahsum, Bhsum, Alsum, Blsum; // Store partial sums of Ahh, Bhh, Ahl, Bhl, etc.
	reg [128:0] Ph_sum, Pl_sum; // Store (Ahh*Bhh) + (Ahl*Bhl), same for Al and Bl 
    reg [128:0] As, Bs; // Store Ah + Al, Bh + Bl
    reg [129:0] Ps_H, Phsum, Plsum;
    reg [127:0] Ps_L;
    reg [65:0] As_sum, Bs_sum;
    reg [130:0] midSumPart;
    reg [129:0] Ph_mid, Pl_mid;
    reg [131:0] Psum_mid, midSumTerm;
    reg [131:0] tempP;
    reg [129:0] Psumsums;
    
    reg [2:0] state;
    
    always @(posedge clock) begin
    	if(reset) begin
    		done <= 1'b0;
    		P <= 512'b0;
    		state <= 3'b000;
		end
   
   		else begin
   		case (state)
   			
   			3'b000: begin
   				done <= 1'b0;
   				if(start) begin
   					// 1st Cycle
   					Phh[127:0] <= A[255:192] * B[255:192];
   					Phl[127:0] <= A[191:128] * B[191:128];
   					Plh[127:0] <= A[127:64] * B[127:64];
   					Pll[127:0] <= A[63:0] * B[63:0];
   					
   					As[128:0] <= A[127:0] + A[255:128];
   					Bs[128:0] <= B[127:0] + B[255:128];
   					Ahsum[64:0] <= A[255:192] + A[191:128];
   					Alsum[64:0] <= A[127:64] + A[63:0];
   					Bhsum[64:0] <= B[255:192] + B[191:128];
   					Blsum[64:0] <= B[127:64] + B[63:0];
   					state <= 3'b001;
				end 
				
				else state <= 3'b000;
			end
			
			3'b001: begin
				// 2nd Cycle
				
				// Higher Term
				Phsum[129:0] <= Ahsum[64:0] * Bhsum[64:0]; // Phsum
				Ph_sum[128:0] <= Phh[127:0] + Phl[127:0]; // Phh + Phl
				
				
				// Middle Term
				Ps_H[129:0] <=  As[128:64] * Bs[128:64]; // A'h*B'h
				Ps_L[127:0] <= As[63:0] * Bs[63:0]; // A'l * B'l
				As_sum[65:0] <= As[128:64] + As[63:0]; // A'h + A'l
				Bs_sum[65:0] <= Bs[128:64] + Bs[63:0]; // B'h + B'l
				
				//Lower Term
				Plsum[129:0] <= Alsum[64:0] * Blsum[64:0]; // Plsum
				Pl_sum[128:0] <= Plh[127:0] + Pll[127:0]; // Plh + Pll
				
				// Overall Term Arithmetic
				P[511:0] <= {Phh[127:0], Phl[127:0], Plh[127:0], Pll[127:0]} - {128'b0, Phh[127:0], Phl[127:0], 128'b0}; 
				
				state <= 3'b010;
			end 
			
			3'b010: begin
				// 3rd Cycle
				
				// Higher Term
				Ph_mid[129:0] <= Phsum[129:0] - Ph_sum[128:0];
				
				//  Middle Term
				midSumPart[130:0] <= Ps_H[129:0] + Ps_L[127:0]; // P'h + P'l
				Psum_mid[131:0] <= As_sum[65:0] * Bs_sum[65:0]; // (A'h + A'l)*(B'h + B'l)
				
				// Lower Term
				Pl_mid[129:0] <= Plsum[129:0] - Pl_sum[128:0];
				
				// Overall Term Arithmetic
				P[511:0] <= P[511:0] - {128'b0, Plh[127:0], Pll[127:0], 128'b0};
				tempP[130:0] <= Phsum[129:0] + Plsum[129:0];
				Psumsums[129:0] <= Ph_sum[128:0] + Pl_sum[128:0];
				
				state <= 3'b011; 
			end
				
			3'b011: begin
				//4th Cycle
				
				// Middle Term
				midSumTerm[131:0] <= Psum_mid[131:0] - midSumPart[130:0];
				
				// Overall Term
				P[511:0] <= P[511:0] + {62'b0, Ph_mid[129:0], 126'b0, Pl_mid[129:0] ,64'b0};
				tempP[130:0] <= tempP[130:0] - Psumsums[129:0];
				
				state <= 3'b100;
			end
			
			3'b100: begin
				//5th Cycle
				P[511:0] <= P[511:0] + (Ps_H[129:0] << 256);
				tempP[131:0] <= tempP[130:0] - midSumTerm[131:0];
				state <= 3'b101;
			end
			
			3'b101: begin
				//6th Cycle
				P[511:0] <= P[511:0] - (tempP << 192);
				
				state <= 3'b110;
			end
			
			3'b110: begin
				//7th Cycle (final)
				P[511:0] <= P[511:0] + (Ps_L[127:0] << 128);
				
				done <= 1'b1;
				state <= 3'b111;
			end	
			
			3'b111: begin
				done <= 1'b0;
				state <= 3'b000;
			end				
		endcase 
		end
	end
		
endmodule 
