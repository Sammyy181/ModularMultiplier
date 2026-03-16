`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 27.01.2026 17:01:54
// Design Name: 
// Module Name: baseline
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


module baseline(
    input wire clock,
    input wire reset,
    input wire [129:0] X,
    input wire [129:0] Y,
    input wire in_valid,
    output reg [259:0] P,
    output reg out_valid
);

    // Cycle 1
    reg [51:0] P0_S1, P1_S1, P2_S1, P3_S1, P4_S1;
    reg [26:0] X10_S1, X21_S1, X20_S1, X32_S1, X31_S1, X30_S1, X43_S1, X42_S1, X41_S1, X40_S1;
    reg [26:0] Y10_S1, Y21_S1, Y20_S1, Y32_S1, Y31_S1, Y30_S1, Y43_S1, Y42_S1, Y41_S1, Y40_S1;

    reg valid_S1;
    
    // Cycle 2
    reg [53:0] M10_S2, M21_S2, M20_S2, M32_S2, M31_S2, M30_S2, M43_S2, M42_S2, M41_S2, M40_S2;
    reg [51:0] P0_S2, P1_S2, P2_S2, P3_S2, P4_S2;

    reg valid_S2;

    // Cycle 3
    reg [53:0] M10_S3, M21_S3, M20_S3, M32_S3, M31_S3, M30_S3, M43_S3, M42_S3, M41_S3, M40_S3;
    reg [52:0] S01_S3, S23_S3, S34_S3, S14_S3;
    reg [51:0] T0K_S3, T8K_S3, P2_S3;

    reg valid_S3;

    // Cycle 4
    reg [51:0] T0K_S4, T8K_S4;
    reg [52:0] T1K_S4, S23_S4, T7K_S4;
    reg [53:0] S012_S4, S234_S4;
    reg [54:0] S0123_S4, S1234_S4;

    reg [53:0] M20_S4, M42_S4;
    reg [54:0] M3_S4, M4_S4, M5_S4;

    reg valid_S4;

    // Cycle 5
    reg [25:0] T0KL_S5;
    
    reg [54:0] T5K_S5;


    always @(posedge clock) begin
        if (reset) begin
            P <= 260'b0;
            valid_S1 <= 1'b0;
            out_valid <= 1'b0;
        end
        else begin

            // Cycle 1
            P0_S1 <= X[25:0] * Y[25:0];
            P1_S1 <= X[51:26] * Y[51:26];
            P2_S1 <= X[77:52] * Y[77:52];
            P3_S1 <= X[103:78] * Y[103:78];
            P4_S1 <= X[125:103] * Y[125:103];

            X10_S1 <= {1'b0, X[51:26]} - {1'b0, X[25:0]};
            X21_S1 <= {1'b0, X[77:52]} - {1'b0, X[51:26]};
            X20_S1 <= {1'b0, X[77:52]} - {1'b0, X[25:0]};
            X32_S1 <= {1'b0, X[103:78]} - {1'b0, X[77:52]};
            X31_S1 <= {1'b0, X[103:78]} - {1'b0, X[51:26]};
            X30_S1 <= {1'b0, X[103:78]} - {1'b0, X[25:0]};
            X43_S1 <= {1'b0, X[125:104]} - {1'b0, X[103:78]};
            X42_S1 <= {1'b0, X[125:104]} - {1'b0, X[77:52]};
            X41_S1 <= {1'b0, X[125:104]} - {1'b0, X[51:26]};
            X40_S1 <= {1'b0, X[125:104]} - {1'b0, X[25:0]};

            Y10_S1 <= {1'b0, Y[51:26]} - {1'b0, Y[25:0]};
            Y21_S1 <= {1'b0, Y[77:52]} - {1'b0, Y[51:26]};
            Y20_S1 <= {1'b0, Y[77:52]} - {1'b0, Y[25:0]};
            Y32_S1 <= {1'b0, Y[103:78]} - {1'b0, Y[77:52]};
            Y31_S1 <= {1'b0, Y[103:78]} - {1'b0, Y[51:26]};
            Y30_S1 <= {1'b0, Y[103:78]} - {1'b0, Y[25:0]};
            Y43_S1 <= {1'b0, Y[125:104]} - {1'b0, Y[103:78]};
            Y42_S1 <= {1'b0, Y[125:104]} - {1'b0, Y[77:52]};
            Y41_S1 <= {1'b0, Y[125:104]} - {1'b0, Y[51:26]};
            Y40_S1 <= {1'b0, Y[125:104]} - {1'b0, Y[25:0]};

            valid_S1 <= valid_S0;

            // Cycle 2
            M10_S2 <= X10_S1 * Y10_S1;
            M21_S2 <= X21_S1 * Y21_S1;
            M20_S2 <= X20_S1 * Y20_S1;
            M32_S2 <= X32_S1 * Y32_S1;
            M31_S2 <= X31_S1 * Y31_S1;
            M30_S2 <= X30_S1 * Y30_S1;
            M43_S2 <= X43_S1 * Y43_S1;
            M42_S2 <= X42_S1 * Y42_S1;
            M41_S2 <= X41_S1 * Y41_S1;
            M40_S2 <= X40_S1 * Y40_S1;

            valid_S2 <= valid_S1;

            // Cycle 3
            S01_S3 <= P0_S2 + P1_S2;
            S23_S3 <= P2_S2 + P3_S2;
            S14_S3 <= P1_S2 + P4_S2;
            S34_S3 <= P3_S2 + P4_S2;
            
            T0K_S3 <= P0_S2;
            P2_S3 <= P2_S2;
            T8K_S3 <= P4_S2;

            M10_S3 <= M10_S2;
            M21_S3 <= M21_S2;
            M20_S3 <= M20_S2;
            M32_S3 <= M32_S2;
            M31_S3 <= M31_S2;
            M30_S3 <= M30_S2;
            M43_S3 <= M43_S2;
            M42_S3 <= M42_S2;
            M41_S3 <= M41_S2;
            M40_S3 <= M40_S2;

            valid_S3 <= valid_S2;

            // Cycle 4
            T1K_S4 <= {1'b0, S01_S3} - M10_S3;
            T7K_S4 <= {1'b0, S34_S3} - M43_S3;
            S23_S4 <= S23_S3;
            S012_S4 <= S01_S3 + P2_S3;
            S234_S4 <= S23_S3 + T8K_S3;
            S0123_S4 <= S01_S3 + S23_S3;
            S1234_S4 <= S14_S3 + S23_S3;

            M3_S4 <= M21_S3 + M30_S3;
            M4_S4 <= M31_S3 + M40_S3;
            M5_S4 <= M32_S3 + M41_S3;

            M20_S4 <= M20_S3;
            M42_S4 <= M42_S3;

            T0K_S4 <= T0K_S3;
            T8K_S4 <= T8K_S3;

            valid_S4 <= valid_S3;

            // Cycle 5



        end
    end

endmodule