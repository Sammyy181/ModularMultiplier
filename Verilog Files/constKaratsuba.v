`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 27.01.2026 17:03:14
// Design Name: 
// Module Name: constKaratsuba
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


module constKaratsuba(
    input wire clock,
    input wire reset,
    input wire in_valid,
    input wire [255:0] X,
    input wire [127:0] Y,
    output reg [383:0] P,
    output reg out_valid
);

    // Modulus = e3b8c1e9392456de3eb13b9046685257bdd640fb06671ad11c80317fa3b1799d
    // X = 92e5c273477d21d8361651a6eea3cb5b1c424d77f1b750a99cc6df2b0ee713a2

    // Cycle 1

    reg [39:0] Z0_S1, Z2_S1, Z3_S1, Z4_S1, Z5_S1, Z7_S1, Z12_S1, Z14_S1, Z15_0S1, Z15_1S1, Z15_2S1, Z16_0S1, Z16_1S1, Z17_0S1, Z17_1S1, Z17_2S1, 
                Z18_S1, Z19_0S1, Z19_1S1, Z20_S1, Z21_0S1, Z21_1S1, Z21_2S1, Z22_0S1, Z22_1S1, Z23_0S1, Z23_1S1, Z23_2S1, Z24_S1, Z25_0S1,
                Z25_1S1, Z26_S1, Z27_S1, Z28_0S1, Z28_1S1, Z29_S1, Z30_S1, Z32_S1, Z37_S1, Z39_S1, Z41_S1;
    reg [31:0] Z40_S1, Z42_S1, Z44_S1;

    reg [24:0] diffX6_0S1, diffX9_3S1, diffX12_0S1, diffX12_6S1, diffX24_18S1, diffX27_15S1, diffX30_18S1, diffX27_21S1, diffX30_24S1;
    reg [16:0] diffY0_6S1, diffY2_8S1, diffY4_10S1, diffY0_12S1, diffY2_14S1, diffY6_12S1, diffY8_14S1;

    reg S1_valid;

    // Cycle 2

    reg [39:0] Z0_S2, Z2_S2, Z3_S2, Z4_S2, Z5_S2, Z7_S2, Z12_S2, Z14_S2, Z15_0S2, Z15_1S2, Z15_2S2, Z16_0S2, Z16_1S2, Z17_0S2, Z17_1S2, Z17_2S2, 
                Z18_S2, Z19_0S2, Z19_1S2, Z20_S2, Z21_0S2, Z21_1S2, Z21_2S2, Z22_0S2, Z22_1S2, Z23_0S2, Z23_1S2, Z23_2S2, Z24_S2, Z25_0S2,
                Z25_1S2, Z26_S2, Z27_S2, Z28_0S2, Z28_1S2, Z29_S2, Z30_S2, Z32_S2, Z37_S2, Z39_S2, Z41_S2;
    reg [31:0] Z40_S2, Z42_S2, Z44_S2;

    reg [40:0] M6_S2, M8_S2, M9_S2, M10_S2, M11_S2, M12_S2, M13_S2, M14_S2, M18_S2, M20_S2, M24_S2, M26_S2, M27_S2, M29_S2, M30_S2, M31_S2,
                M32_S2, M33_S2, M34_S2, M35_S2, M36_S2, M38_S2;

    wire [55:0] Z2_S2_sh = Z2_S2 << 16;
    wire [63:0] Z3_S2_sh = Z3_S2 << 24;
    wire [71:0] Z4_S2_sh = Z4_S2 << 32;
    wire [47:0] Z7_S2_sh = Z7_S2 << 8;
    wire [39:0] Z40_S2_sh = Z40_S2 << 8;
    wire [55:0] Z41_S2_sh = Z41_S2 << 16;
    wire [55:0] Z42_S2_sh = Z42_S2 << 24;

    reg S2_valid;

    // Cycle 3

    wire [40:0] Z6_S3, Z8_S3, Z9_S3, Z10_S3, Z11_S3, Z13_S3, Z16_S3, Z19_S3, Z22_S3, Z25_S3, Z28_S3, Z31_S3, Z33_S3, Z34_S3, Z35_S3, Z36_S3, Z38_S3;
    wire [41:0] Z12_S3, Z14_S3, Z15_S3, Z17_S3, Z18_S3, Z20_S3, Z21_S3, Z23_S3, Z24_S3, Z26_S3, Z27_S3, Z29_S3, Z30_S3, Z32_S3;

    assign Z6_S3 = $signed(M6_S2) + $signed({1'b0, Z0_S2}) + $signed({1'b0, Z12_S2});
    assign Z8_S3 = $signed(M8_S2) + $signed({1'b0, Z2_S2}) + $signed({1'b0, Z14_S2});
    assign Z9_S3 = $signed(M9_S2) + $signed({1'b0, Z15_0S2}) + $signed({1'b0, Z3_S2});
    assign Z10_S3 = $signed(M10_S2) + $signed({1'b0, Z16_0S2}) + $signed({1'b0, Z4_S2});
    assign Z11_S3 = $signed(M11_S2) + $signed({1'b0, Z17_0S2}) + $signed({1'b0, Z5_S2});
    assign Z12_S3 = $signed(M12_S2) + $signed({1'b0, Z12_S2}) + $signed({1'b0, Z0_S2}) + $signed({1'b0, Z24_S2});
    assign Z13_S3 = $signed(M13_S2) + $signed({1'b0, Z19_0S2}) + $signed({1'b0, Z7_S2});
    assign Z14_S3 = $signed(M14_S2) + $signed({1'b0, Z14_S2}) + $signed({1'b0, Z26_S2}) + $signed({1'b0, Z2_S2});
    assign Z15_S3 = $unsigned(Z15_0S2) + $unsigned(Z15_1S2) + $unsigned(Z15_2S2);
    assign Z16_S3 = $unsigned(Z16_0S2) + $unsigned(Z16_1S2);
    assign Z17_S3 = $unsigned(Z17_0S2) + $unsigned(Z17_1S2) + $unsigned(Z17_2S2);
    assign Z18_S3 = $signed(M18_S2) + $signed({1'b0, Z18_S2}) + $signed({1'b0, Z12_S2}) + $signed({1'b0, Z24_S2});
    assign Z19_S3 = $unsigned(Z19_0S2) + $unsigned(Z19_1S2);
    assign Z20_S3 = $signed(M20_S2) + $signed({1'b0, Z20_S2}) + $signed({1'b0, Z26_S2}) + $signed({1'b0, Z14_S2});
    assign Z21_S3 = $unsigned(Z21_0S2) + $unsigned(Z21_1S2) + $unsigned(Z21_2S2);
    assign Z22_S3 = $unsigned(Z22_0S2) + $unsigned(Z22_1S2);
    assign Z23_S3 = $unsigned(Z23_0S2) + $unsigned(Z23_1S2) + $unsigned(Z23_2S2);
    assign Z24_S3 = $signed(M24_S2) + $signed({1'b0, Z24_S2}) + $signed({1'b0, Z30_S2}) + $signed({1'b0, Z18_S2});
    assign Z25_S3 = $unsigned(Z25_0S2) + $unsigned(Z25_1S2);
    assign Z26_S3 = $signed(M26_S2) + $signed({1'b0, Z26_S2}) + $signed({1'b0, Z32_S2}) + $signed({1'b0, Z20_S2});
    assign Z27_S3 = $signed(M27_S2) + $signed({1'b0, Z27_S2}) + $signed({1'b0, Z39_S2}) + $signed({1'b0, Z15_1S2});
    assign Z28_S3 = $unsigned(Z28_0S2) + $unsigned(Z28_1S2);
    assign Z29_S3 = $signed(M29_S2) + $signed({1'b0, Z29_S2}) + $signed({1'b0, Z41_S2}) + $signed({1'b0, Z17_1S2});
    assign Z30_S3 = $signed(M30_S2) + $signed({1'b0, Z30_S2}) + $signed({1'b0, Z42_S2}) + $signed({1'b0, Z18_S2});
    assign Z31_S3 = $signed(M31_S2) + $signed({1'b0, Z37_S2}) + $signed({1'b0, Z25_0S2});
    assign Z32_S3 = $signed(M32_S2) + $signed({1'b0, Z32_S2}) + $signed({1'b0, Z20_S2}) + $signed({1'b0, Z44_S2});
    assign Z33_S3 = $signed(M33_S2) + $signed({1'b0, Z39_S2}) + $signed({1'b0, Z27_S2});
    assign Z34_S3 = $signed(M34_S2) + $signed({1'b0, Z40_S2}) + $signed({1'b0, Z28_0S2});
    assign Z35_S3 = $signed(M35_S2) + $signed({1'b0, Z41_S2}) + $signed({1'b0, Z29_S2});
    assign Z36_S3 = $signed(M36_S2) + $signed({1'b0, Z42_S2}) + $signed({1'b0, Z30_S2});
    assign Z38_S3 = $signed(M38_S2) + $signed({1'b0, Z44_S2}) + $signed({1'b0, Z32_S2});

    wire [48:0] Z9_S3_sh = Z9_S3 << 8;
    wire [48:0] Z11_S3_sh = Z11_S3 << 8;
    wire [48:0] Z34_S3_sh = Z34_S3 << 8;
    wire [48:0] Z36_S3_sh = Z36_S3 << 8;
    wire [48:0] Z38_S3_sh = Z38_S3 << 8;
    
    reg [81:0] S81_0S3;
    reg [71:0] S383_312S3;
    reg [49:0] S98_48S3, S114_64S3, S130_80S3, S314_264S3, S330_280S3, S346_296S3;
    reg [41:0] S138_96S3, S154_112S3, S162_120S3, S178_136S3, S186_144S3, S202_160S3, S210_168S3, S226_184S3, S234_192S3, S250_208S3, S258_216S3, S274_232S3, S282_240S3, S298_256S3;
    reg [40:0] S145_104S3, S169_128S3, S193_152S3, S217_176S3, S241_200S3, S265_224S3, S289_248S3;

    wire [97:0] S98_48S3_sh = S98_48S3 << 48;
    wire [65:0] S130_80S3_sh = S130_80S3 << 16;
    wire [73:0] S138_96S3_sh = S138_96S3 << 32;
    wire [49:0] S154_112S3_sh = S154_112S3 << 8;
    wire [57:0] S162_120S3_sh = S162_120S3 << 16;
    wire [49:0] S178_136S3_sh = S178_136S3 << 8;
    wire [57:0] S186_144S3_sh = S186_144S3 << 16;
    wire [49:0] S202_160S3_sh = S202_160S3 << 8;
    wire [57:0] S210_168S3_sh = S210_168S3 << 16;
    wire [49:0] S226_184S3_sh = S226_184S3 << 8;
    wire [57:0] S234_192S3_sh = S234_192S3 << 16;
    wire [49:0] S250_208S3_sh = S250_208S3 << 8;
    wire [57:0] S258_216S3_sh = S258_216S3 << 16;
    wire [49:0] S274_232S3_sh = S274_232S3 << 8;
    wire [57:0] S282_240S3_sh = S282_240S3 << 16;
    wire [64:0] S289_248S3_sh = S289_248S3 << 24;
    wire [57:0] S314_264S3_sh = S314_264S3 << 8;
    wire [73:0] S330_280S3_sh = S330_280S3 << 24;
    wire [87:0] S383_312S3_sh = S383_312S3 << 16;

    reg S3_valid;

    // Cycle 3

    reg [99:0] S99_0S4;
    reg [87:0] S383_296S4;
    reg [74:0] S139_64S4, S331_256S4;
    reg [65:0] S290_224S4;
    reg [58:0] S163_104S4, S187_128S4, S211_152S4, S235_176S4 ,S259_200S4;

    wire [138:0] S139_64S4_sh = S139_64S4 << 64;
    wire [82:0] S187_128S4_sh = S187_128S4 << 24;
    wire [82:0] S235_176S4_sh = S235_176S4 << 24;
    wire [89:0] S290_224S4_sh = S290_224S4 << 24;
    wire [127:0] S383_296S4_sh = S383_296S4 << 40;

    reg S4_valid;

    // Cycle 5

    reg [140:0] S140_0S5;
    reg [127:0] S383_256S5;
    reg [90:0] S291_200S5;
    reg [83:0] S188_104S5, S236_152S5;

    wire [187:0] S188_104S5_sh = S188_104S5 << 104;
    wire [138:0] S291_200S5_sh = S291_200S5 << 48;

    reg S5_valid;

    // Cycle 5

    reg [189:0] S189_0S6;
    reg [139:0] S292_152S6;
    reg [127:0] S383_256S6;

    wire [231:0] S383_256S6_sh = S383_256S6 << 104;

    reg S6_valid;

    // Cycle 7

    reg [231:0] S383_152S7;
    reg [189:0] S189_0S7;

    wire [383:0] S383_152S7_sh = S383_152S7 << 152;

    reg S7_valid;

    always @(posedge clock) begin
        if(reset) begin
            out_valid <= 1'b0;
            P <= 384'b0;
            S1_valid <= 1'b0;
            S2_valid <= 1'b0;
            S3_valid <= 1'b0;
            S4_valid <= 1'b0;
            S5_valid <= 1'b0;
            S6_valid <= 1'b0;
            S7_valid <= 1'b0;
        end
        else begin

            // Cycle 1

            Z0_S1 <= X[23:0] * Y[15:0];
            Z2_S1 <= X[23:0] * Y[31:16];
            Z3_S1 <= X[47:24] * Y[15:0];
            Z4_S1 <= X[23:0] * Y[47:32];
            Z5_S1 <= X[47:24] * Y[31:16];
            Z7_S1 <= X[47:24] * Y[47:32];
            Z12_S1 <= X[71:48] * Y[63:48];
            Z14_S1 <= X[71:48] * Y[79:64];
            Z15_0S1 <= X[95:72] * Y[63:48]; // X9Y6
            Z15_1S1 <= X[143:120] * Y[15:0]; // X15Y0
            Z15_2S1 <= X[47:24] * Y[111:96]; // X3Y12
            Z16_0S1 <= X[71:48] * Y[95:80]; // X6Y10
            Z16_1S1 <= X[119:96] * Y[47:32]; // X12Y4
            Z17_0S1 <= X[95:72] * Y[79:64]; // X9Y8
            Z17_1S1 <= X[143:120] * Y[31:16]; // X15Y2
            Z17_2S1 <= X[47:24] * Y[127:112]; // X3Y14
            Z18_S1 <= X[167:144] * Y[15:0];
            Z19_0S1 <= X[95:72] * Y[95:80]; // X9Y10
            Z19_1S1 <= X[143:120] * Y[47:32]; // X15Y4
            Z20_S1 <= X[167:144] * Y[31:16];
            Z21_0S1 <= X[191:168] * Y[15:0]; // X21Y0
            Z21_1S1 <= X[143:120] * Y[63:48]; // X15Y6
            Z21_2S1 <= X[95:72] * Y[111:96]; // X9Y12
            Z22_0S1 <= X[167:144] * Y[47:32]; // X18Y4
            Z22_1S1 <= X[119:96] * Y[95:80]; // X12Y10
            Z23_0S1 <= X[191:168] * Y[31:16]; // X21Y2
            Z23_1S1 <= X[143:120] * Y[79:64]; // X15Y8
            Z23_2S1 <= X[95:72] * Y[127:112]; // X9Y14
            Z24_S1 <= X[119:96] * Y[111:96];
            Z25_0S1 <= X[191:168] * Y[47:32]; // X21Y4
            Z25_1S1 <= X[143:120] * Y[95:80];
            Z26_S1 <= X[119:96] * Y[127:112];
            Z27_S1 <= X[191:168] * Y[63:48];
            Z28_0S1 <= X[215:192] * Y[47:32]; // X24Y4
            Z28_1S1 <= X[167:144] * Y[95:80]; // X18Y10
            Z29_S1 <= X[191:168] * Y[79:64];
            Z30_S1 <= X[215:192] * Y[63:48];
            Z32_S1 <= X[215:192] * Y[79:64];
            Z37_S1 <= X[239:216] * Y[95:80];
            Z39_S1 <= X[239:216] * Y[111:96];
            Z40_S1 <= X[255:240] * Y[95:80]; // 32 Bits
            Z41_S1 <= X[239:216] * Y[127:112];
            Z42_S1 <= X[255:240] * Y[111:96]; // 32 Bits
            Z44_S1 <= X[255:240] * Y[127:112]; // 32 Bits

            diffX6_0S1 <= $signed({1'b0, X[71:48]}) - $signed({1'b0, X[23:0]});
            diffX12_0S1 <= $signed({1'b0, X[119:96]}) - $signed({1'b0, X[23:0]});
            diffX9_3S1 <= $signed({1'b0, X[95:72]}) - $signed({1'b0, X[47:24]});
            diffX12_6S1 <= $signed({1'b0, X[119:96]}) - $signed({1'b0, X[71:48]});
            diffX27_15S1 <= $signed({1'b0, X[239:216]}) - $signed({1'b0, X[143:120]});
            diffX24_18S1 <= $signed({1'b0, X[215:192]}) - $signed({1'b0, X[167:144]});
            diffX30_18S1 <= $signed({1'b0, X[255:240]}) - $signed({1'b0, X[167:144]});
            diffX27_21S1 <= $signed({1'b0, X[239:216]}) - $signed({1'b0, X[191:168]});
            diffX30_24S1 <= $signed({1'b0, X[255:240]}) - $signed({1'b0, X[215:192]});

            diffY0_6S1 <= $signed({1'b0, Y[15:0]}) - $signed({1'b0, Y[63:48]});
            diffY0_12S1 <= $signed({1'b0, Y[15:0]}) - $signed({1'b0, Y[111:96]});
            diffY2_8S1 <= $signed({1'b0, Y[31:16]}) - $signed({1'b0, Y[79:64]});
            diffY2_14S1 <= $signed({1'b0, Y[31:16]}) - $signed({1'b0, Y[127:112]});
            diffY4_10S1 <= $signed({1'b0, Y[47:32]}) - $signed({1'b0, Y[95:80]});
            diffY6_12S1 <= $signed({1'b0, Y[63:48]}) - $signed({1'b0, Y[111:96]});
            diffY8_14S1 <= $signed({1'b0, Y[79:64]}) - $signed({1'b0, Y[127:112]});

            S1_valid <= in_valid;

            // Cycle 2

            Z0_S2 <= Z0_S1;
            Z2_S2 <= Z2_S1;
            Z3_S2 <= Z3_S1;
            Z4_S2 <= Z4_S1;
            Z5_S2 <= Z5_S1;
            Z7_S2 <= Z7_S1;
            Z12_S2 <= Z12_S1;
            Z14_S2 <= Z14_S1;
            Z15_0S2 <= Z15_0S1;
            Z15_1S2 <= Z15_1S1;
            Z15_2S2 <= Z15_2S1;
            Z16_0S2 <= Z16_0S1;
            Z16_1S2 <= Z16_1S1;
            Z17_0S2 <= Z17_0S1;
            Z17_1S2 <= Z17_1S1;
            Z17_2S2 <= Z17_2S1;
            Z18_S2 <= Z18_S1;
            Z19_0S2 <= Z19_0S1;
            Z19_1S2 <= Z19_1S1;
            Z20_S2 <= Z20_S1;
            Z21_0S2 <= Z21_0S1;
            Z21_1S2 <= Z21_1S1;
            Z21_2S2 <= Z21_2S1;
            Z22_0S2 <= Z22_0S1;
            Z22_1S2 <= Z22_1S1;
            Z23_0S2 <= Z23_0S1;
            Z23_1S2 <= Z23_1S1;
            Z23_2S2 <= Z23_2S1;
            Z24_S2 <= Z24_S1;
            Z25_0S2 <= Z25_0S1;
            Z25_1S2 <= Z25_1S1;
            Z26_S2 <= Z26_S1;
            Z27_S2 <= Z27_S1;
            Z28_0S2 <= Z28_0S1;
            Z28_1S2 <= Z28_1S1;
            Z29_S2 <= Z29_S1;
            Z30_S2 <= Z30_S1;
            Z32_S2 <= Z32_S1;
            Z37_S2 <= Z37_S1;
            Z39_S2 <= Z39_S1;
            Z40_S2 <= Z40_S1;
            Z41_S2 <= Z41_S1;
            Z42_S2 <= Z42_S1;
            Z44_S2 <= Z44_S1;

            M6_S2 <= $signed(diffX6_0S1) * $signed(diffY0_6S1);
            M8_S2 <= $signed(diffX6_0S1) * $signed(diffY2_8S1);
            M9_S2 <= $signed(diffX9_3S1) * $signed(diffY0_6S1);
            M10_S2 <= $signed(diffX6_0S1) * $signed(diffY4_10S1);
            M11_S2 <= $signed(diffX9_3S1) * $signed(diffY2_8S1);
            M12_S2 <= $signed(diffX12_0S1) * $signed(diffY0_12S1);
            M13_S2 <= $signed(diffX9_3S1) * $signed(diffY4_10S1);
            M14_S2 <= $signed(diffX12_0S1) * $signed(diffY2_14S1);
            M18_S2 <= $signed(diffX12_6S1) * $signed(diffY6_12S1);
            M20_S2 <= $signed(diffX12_6S1) * $signed(diffY8_14S1);
            M24_S2 <= $signed(diffX24_18S1) * $signed(diffY0_6S1);
            M26_S2 <= $signed(diffX24_18S1) * $signed(diffY2_8S1);
            M27_S2 <= $signed(diffX27_15S1) * $signed(diffY0_12S1);
            M29_S2 <= $signed(diffX27_15S1) * $signed(diffY2_14S1);
            M30_S2 <= $signed(diffX30_18S1) * $signed(diffY0_12S1);
            M31_S2 <= $signed(diffX27_21S1) * $signed(diffY4_10S1);
            M32_S2 <= $signed(diffX30_18S1) * $signed(diffY2_14S1);
            M33_S2 <= $signed(diffX27_21S1) * $signed(diffY6_12S1);
            M34_S2 <= $signed(diffX30_24S1) * $signed(diffY4_10S1);
            M35_S2 <= $signed(diffX27_21S1) * $signed(diffY8_14S1);
            M36_S2 <= $signed(diffX30_24S1) * $signed(diffY6_12S1);
            M38_S2 <= $signed(diffX30_24S1) * $signed(diffY8_14S1);

            S2_valid <= S1_valid;

            // Cycle 3

            S81_0S3 <= {Z5_S2, Z0_S2} + {24'b0, Z2_S2_sh} + {16'b0, Z3_S2_sh} + {8'b0, Z4_S2_sh};
            S98_48S3 <= {7'b0, Z6_S3} + Z7_S2_sh;
            S114_64S3 <= {8'b0, Z8_S3} + Z9_S3_sh;
            S130_80S3 <= {8'b0, Z10_S3} + Z11_S3_sh;
            S138_96S3 <= Z12_S3;
            S145_104S3 <= Z13_S3;
            S154_112S3 <= Z14_S3;
            S162_120S3 <= Z15_S3;
            S169_128S3 <= Z16_S3;
            S178_136S3 <= Z17_S3;
            S186_144S3 <= Z18_S3;
            S193_152S3 <= Z19_S3;
            S202_160S3 <= Z20_S3;
            S210_168S3 <= Z21_S3;
            S217_176S3 <= Z22_S3;
            S226_184S3 <= Z23_S3;
            S234_192S3 <= Z24_S3;
            S241_200S3 <= Z25_S3;
            S250_208S3 <= Z26_S3;
            S258_216S3 <= Z27_S3;
            S265_224S3 <= Z28_S3;
            S274_232S3 <= Z29_S3;
            S282_240S3 <= Z30_S3;
            S289_248S3 <= Z31_S3;
            S298_256S3 <= Z32_S3;
            S314_264S3 <= {8'b0, Z33_S3} + Z34_S3_sh;
            S330_280S3 <= {8'b0, Z35_S3} + Z36_S3_sh;
            S346_296S3 <= {9'b0, Z37_S2} + Z38_S3_sh;
            S383_312S3 <= {Z44_S2, Z39_S2} + {32'b0, Z40_S2_sh} + {16'b0, Z41_S2_sh} + {16'b0, Z42_S2_sh};

            S3_valid <= S2_valid;

            // Cycle 4
            S99_0S4 <= {16'b0, S81_0S3} + S98_48S3_sh;
            S139_64S4 <= {24'b0, S114_64S3} + {8'b0, S130_80S3_sh} + S138_96S3_sh;
            S163_104S4 <= {17'b0, S145_104S3} + {8'b0, S154_112S3_sh} + S162_120S3_sh;
            S187_128S4 <= {17'b0, S169_128S3} + {8'b0, S178_136S3_sh} + S186_144S3_sh;
            S211_152S4 <= {17'b0, S193_152S3} + {8'b0, S202_160S3_sh} + S210_168S3_sh;
            S235_176S4 <= {17'b0, S217_176S3} + {8'b0, S226_184S3_sh} + S234_192S3_sh;
            S259_200S4 <= {17'b0, S241_200S3} + {8'b0, S250_208S3_sh} + S258_216S3_sh;
            S290_224S4 <= {24'b0, S265_224S3} + {15'b0, S274_232S3_sh} + {7'b0, S282_240S3_sh} + S289_248S3_sh;
            S331_256S4 <= {32'b0, S298_256S3} + {16'b0, S314_264S3_sh} + S330_280S3_sh;
            S383_296S4 <= {38'b0, S346_296S3} + S383_312S3_sh;

            S4_valid <= S3_valid;

            // Cycle 5
            S140_0S5 <= {39'b0, S99_0S4} + S139_64S4_sh;
            S188_104S5 <= {24'b0, S163_104S4} + S187_128S4_sh;
            S236_152S5 <= {24'b0, S211_152S4} + S235_176S4_sh;
            S291_200S5 <= {24'b0, S259_200S4} + S290_224S4_sh;
            S383_256S5 <= {53'b0, S331_256S4} + S383_296S4_sh;

            S5_valid <= S4_valid;

            // Cycle 6
            S189_0S6 <= {47'b0, S140_0S5} + S188_104S5_sh;
            S292_152S6 <= {55'b0, S236_152S5} + S291_200S5_sh;
            S383_256S6 <= S383_256S5;

            S6_valid <= S5_valid;

            // Cycle 7
            S189_0S7 <= S189_0S6;
            S383_152S7 <= {92'b0, S292_152S6} + S383_256S6_sh;

            S7_valid <= S6_valid;

            // Cycle 8
            P <= {94'b0, S189_0S7} + S383_152S7_sh;

            out_valid <= S7_valid;

        end
    end

endmodule