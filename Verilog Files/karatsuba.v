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
    input wire clk,
    input wire [255:0] A,
    input wire [255:0] B,
    input wire rst,
    input wire start,
    output reg [511:0] P,
    output reg done
    );
    
    reg [127:0] Pll, Plh, Phl, Phh;
    reg [129:0] Pl, Ph;
    reg [255:0] P_low, P_high; // To store AlBl and AhBh
    reg [257:0] Pm; // To store (Ah+Al)(Bh+Bl)
    
    reg [1:0] state;
    
    always @(posedge clk) begin
        if (rst) begin
            state <= 0;
            done <= 0;
            P <= 0;
        end
        
        case(state)
            2'b00: begin
                if(start) begin
                	// 1st Cycle
                	Pll[127:0] <= A[63:0] * B[63:0]; //All * Bll
					Plh[127:0] <= A[127:64] * B[127:64]; //Alh * Blh
					Phl[127:0] <= A[191:128] * B[191:128]; //Ahl * Bhl
					Phh[127:0] <= A[255:192] * B[255:192]; //Ahh * Bhh
					Pl[129:0] <= (A[127:64] + A[63:0]) * (B[127:64] + B[63:0]); //(Alh + All) * (Blh + Bll)
					Ph[129:0] <= (A[255:192] + A[191:128]) * (B[255:192] + B[191:128]); //(Ahh + Ahl) * (Bhh + Bhl)
					Pm[257:0] <= (A[255:128] + A[127:0]) * (B[255:128] + B[127:0]); //(Ah + Al) * (Bh + Bl)
					state <= 2'b01;
				end
            end
            
            2'b01: begin
                // 2nd Cycle
				P_low[255:0] <= (Plh[127:0] << 128) + ((Pl[129:0] - Plh[127:0] - Pll[127:0]) << 64) + Pll[127:0]; //Al * Bl
				P_high[255:0] <= (Phh[127:0] << 128) + ((Ph[129:0] - Phh[127:0] - Phl[127:0]) << 64) + Phl[127:0]; //Ah * Bh
                            
                state <= 2'b10;
            end
            
            2'b10: begin     
                // 3rd Cycle
				P[511:0] <= (P_high[255:0] << 256) + ((Pm[257:0] - P_low[255:0] - P_high[255:0]) << 128) + P_low[255:0]; // A * B 
				done <= 1;
                state <= 2'b11;
            end
            
            2'b11: begin
                done <= 0;
                state <= 2'b00;
            end
        endcase             
    end
endmodule
