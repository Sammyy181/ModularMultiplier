`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 27.01.2026 17:01:54
// Design Name: 
// Module Name: fastKaratsuba
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


module fastKaratsuba(
    input wire clock,
    input wire reset,
    input wire [255:0] X,
    input wire [255:0] Y,
    input wire in_valid,
    output reg [511:0] P,
    output reg out_valid
);

    // Cycle 1
    reg [39:0] Z0_S1, Z2_S1, Z3_S1, Z4_S1, Z5_S1, Z7_S1, Z8_S1, Z9_S1,
                Z10_S1, Z12_S1, Z14_S1, Z15_S1, Z16_S1, Z17_S1, Z19_S1,
                Z20_S1, Z21_S1, Z22_S1, Z24_S1, Z26_S1, Z27_S1, Z28_S1, Z29_S1,
                Z31_S1, Z32_S1, Z33_S1, Z34_S1, Z36_S1, Z38_S1, Z39_S1, Z40_S1,
                Z41_S1, Z43_S1, Z44_S1, Z45_S1, Z46_S1, Z48_S1,
                Z50_S1, Z51_S1, Z52_S1, Z53_S1, Z55_S1, Z57_S1;
    reg [31:0] Z56_S1, Z58_S1, Z60_S1;
    
    wire [55:0] Z2_S1_sh = Z2_S1 << 16;
    wire [63:0] Z3_S1_sh = Z3_S1 << 24;
    wire [71:0] Z4_S1_sh = Z4_S1 << 32;
    wire [47:0] Z7_S1_sh = Z7_S1 << 8;
    wire [47:0] Z53_S1_sh = Z53_S1 << 8;
    wire [47:0] Z55_S1_sh = Z55_S1 << 8;
    wire [47:0] Z56_S1_sh = Z56_S1 << 16;
    wire [39:0] Z58_S1_sh = Z58_S1 << 8;
    wire [55:0] Z60_S1_sh = Z60_S1 << 24;

    reg [40:0] M6_S1, M8_S1, M9_S1, M10_S1, M11_S1, M12_S1, M13_S1, M14_S1, M15_S1, M16_S1, M17_S1, M18_0S1, M18_1S1, M19_S1,
                M20_0S1, M20_1S1, M21_0S1, M21_1S1, M22_0S1, M22_1S1, M23_0S1, M23_1S1, M24_0S1, M24_1S1, M25_0S1, M25_1S1,
                M26_0S1, M26_1S1, M27_0S1, M27_1S1, M28_0S1, M28_1S1, M29_0S1, M29_1S1, M30_0S1, M30_1S1, M30_2S1, M31_0S1,
                M31_1S1, M32_0S1, M32_1S1, M33_0S1, M33_1S1, M34_0S1, M34_1S1, M35_0S1, M35_1S1, M36_0S1, M36_1S1, M37_0S1,
                M37_1S1, M38_0S1, M38_1S1, M39_0S1, M39_1S1, M40_0S1, M40_1S1, M41_S1, M42_0S1, M42_1S1, M43_S1, M44_S1, M45_S1,
                M46_S1, M47_S1, M48_S1, M49_S1, M50_S1, M51_S1, M52_S1, M54_S1; 
    reg S1_valid;

    // Cycle 2
    wire [40:0] Z6_S2, Z8_S2, Z9_S2, Z10_S2, Z11_S2, Z13_S2, Z18_0S2, Z18_1S2, Z42_0S2, Z42_1S2, Z47_S2, Z49_S2, Z50_S2, Z51_S2, Z52_S2, Z54_S2;
    wire [41:0] Z12_S2, Z14_S2, Z15_S2, Z16_S2, Z17_S2, Z19_S2, Z41_S2, Z43_S2, Z44_S2, Z45_S2, Z46_S2, Z48_S2;
    wire [42:0] Z20_S2, Z21_S2, Z22_S2, Z23_S2, Z24_S2, Z25_S2, Z26_S2, Z27_S2, Z28_S2, Z29_S2, Z30_S2, Z31_S2, Z32_S2, Z33_S2, Z34_S2, Z35_S2, Z36_S2, Z37_S2, Z38_S2, 
                Z39_S2, Z40_S2;
                
    wire [56:0] Z8_S2_sh = Z8_S2 << 16;
    wire [48:0] Z10_S2_sh = Z10_S2 << 8;
    wire [49:0] Z12_S2_sh = Z12_S2 << 8;
    wire [49:0] Z14_S2_sh = Z14_S2 << 8;
    wire [49:0] Z16_S2_sh = Z16_S2 << 8;
    wire [48:0] Z18_0S2_sh = Z18_0S2 << 8;
    wire [49:0] Z19_S2_sh = Z19_S2 << 8;
    wire [48:0] Z42_0S2_sh = Z42_0S2 << 8;
    wire [49:0] Z43_S2_sh = Z43_S2 << 8;
    wire [49:0] Z45_S2_sh = Z45_S2 << 8;
    wire [48:0] Z47_S2_sh = Z47_S2 << 8;
    wire [48:0] Z49_S2_sh = Z49_S2 << 8;
    wire [48:0] Z51_S2_sh = Z51_S2 << 8;

    reg [80:0] S80_0S2;
    reg [57:0] S106_48S2;
    reg [56:0] S489_432S2; 
    reg [55:0] S511_456S2;
    reg [50:0] S139_88S2, S155_104S2, S171_120S2, S195_144S2, S387_336S2, S403_352S2;
    reg [49:0] S122_72S2, S186_136S2, S378_328S2, S418_368S2, S434_384S2, S450_400S2;
    reg [48:0] S465_416S2;
    reg [42:0] S203_160S2, S211_168S2, S219_176S2, S227_184S2, S235_192S2, S243_200S2, S251_208S2, S259_216S2, S267_224S2, S275_232S2, S283_240S2,
                S291_248S2, S299_256S2, S307_264S2, S315_272S2, S323_280S2, S331_288S2, S339_296S2, S347_304S2, S355_312S2, S363_320S2;
	
	wire [105:0] S106_48S2_sh = S106_48S2 << 48;
	wire [121:0] S122_72S2_sh = S122_72S2 << 72;
	wire [66:0] S155_104S2_sh = S155_104S2 << 16;
	wire [82:0] S171_120S2_sh = S171_120S2 << 32;
	wire [97:0] S186_136S2_sh = S186_136S2 << 48;
	wire [58:0] S203_160S2_sh = S203_160S2 << 16;
	wire [66:0] S211_168S2_sh = S211_168S2 << 24;
	wire [74:0] S219_176S2_sh = S219_176S2 << 32;
	wire [50:0] S235_192S2_sh = S235_192S2 << 8;
	wire [58:0] S243_200S2_sh = S243_200S2 << 16;
	wire [66:0] S251_208S2_sh = S251_208S2 << 24;
	wire [50:0] S267_224S2_sh = S267_224S2 << 8;
	wire [58:0] S275_232S2_sh = S275_232S2 << 16;
	wire [66:0] S283_240S2_sh = S283_240S2 << 24;
	wire [50:0] S299_256S2_sh = S299_256S2 << 8;
	wire [58:0] S307_264S2_sh = S307_264S2 << 16;
	wire [66:0] S315_272S2_sh = S315_272S2 << 24;
	wire [50:0] S331_288S2_sh = S331_288S2 << 8;
	wire [58:0] S339_296S2_sh = S339_296S2 << 16;
	wire [66:0] S347_304S2_sh = S347_304S2 << 24;
	wire [50:0] S363_320S2_sh = S363_320S2 << 8;
	wire [65:0] S378_328S2_sh = S378_328S2 << 16;
	wire [74:0] S387_336S2_sh = S387_336S2 << 24;
	wire [65:0] S418_368S2_sh = S418_368S2 << 16;
	wire [81:0] S434_384S2_sh = S434_384S2 << 32;
	wire [97:0] S450_400S2_sh = S450_400S2 << 48;
	wire [72:0] S489_432S2_sh = S489_432S2 << 16;
	wire [95:0] S511_456S2_sh = S511_456S2 << 40;
	
    reg S2_valid;

    assign Z6_S2 = $signed(M6_S1) + $signed({1'b0, Z0_S1}) + $signed({1'b0, Z12_S1});
    assign Z8_S2 = $signed(M8_S1) + $signed({1'b0, Z2_S1}) + $signed({1'b0, Z14_S1});
    assign Z9_S2 = $signed(M9_S1) + $signed({1'b0, Z3_S1}) + $signed({1'b0, Z15_S1});
    assign Z10_S2 = $signed(M10_S1) + $signed({1'b0, Z4_S1}) + $signed({1'b0, Z16_S1});
    assign Z11_S2 = $signed(M11_S1) + $signed({1'b0, Z5_S1}) + $signed({1'b0, Z17_S1});
    assign Z12_S2 = $signed(M12_S1) + $signed({1'b0, Z12_S1}) + $signed({1'b0, Z0_S1}) + $signed({1'b0, Z24_S1});
    assign Z13_S2 = $signed(M13_S1) + $signed({1'b0, Z7_S1}) + $signed({1'b0, Z19_S1});
    assign Z14_S2 = $signed(M14_S1) + $signed({1'b0, Z14_S1}) + $signed({1'b0, Z2_S1}) + $signed({1'b0, Z26_S1});
    assign Z15_S2 = $signed(M15_S1) + $signed({1'b0, Z15_S1}) + $signed({1'b0, Z3_S1}) + $signed({1'b0, Z27_S1});
    assign Z16_S2 = $signed(M16_S1) + $signed({1'b0, Z16_S1}) + $signed({1'b0, Z4_S1}) + $signed({1'b0, Z28_S1});
    assign Z17_S2 = $signed(M17_S1) + $signed({1'b0, Z17_S1}) + $signed({1'b0, Z5_S1}) + $signed({1'b0, Z29_S1});
    assign Z18_0S2 = $signed(M18_0S1) + $signed({1'b0, Z12_S1}) + $signed({1'b0, Z24_S1});
    assign Z18_1S2 = $signed(M18_1S1) + $signed({1'b0, Z0_S1}) + $signed({1'b0, Z36_S1});
    assign Z19_S2 = $signed(M19_S1) + $signed({1'b0, Z19_S1}) + $signed({1'b0, Z7_S1}) + $signed({1'b0, Z31_S1});
    assign Z20_S2 = $signed(M20_0S1) + $signed(M20_1S1) + $signed({1'b0, Z14_S1}) + $signed({1'b0, Z26_S1}) + $signed({1'b0, Z2_S1}) + $signed({1'b0, Z38_S1});
    assign Z21_S2 = $signed(M21_0S1) + $signed(M21_1S1) + $signed({1'b0, Z15_S1}) + $signed({1'b0, Z27_S1}) + $signed({1'b0, Z3_S1}) + $signed({1'b0, Z39_S1});
    assign Z22_S2 = $signed(M22_0S1) + $signed(M22_1S1) + $signed({1'b0, Z16_S1}) + $signed({1'b0, Z28_S1}) + $signed({1'b0, Z4_S1}) + $signed({1'b0, Z40_S1});
    assign Z23_S2 = $signed(M23_0S1) + $signed(M23_1S1) + $signed({1'b0, Z17_S1}) + $signed({1'b0, Z29_S1}) + $signed({1'b0, Z5_S1}) + $signed({1'b0, Z41_S1});
    assign Z24_S2 = $signed(M24_0S1) + $signed(M24_1S1) + $signed({1'b0, Z24_S1}) + $signed({1'b0, Z12_S1}) + $signed({1'b0, Z36_S1}) + $signed({1'b0, Z0_S1}) + $signed({1'b0, Z48_S1});
    assign Z25_S2 = $signed(M25_0S1) + $signed(M25_1S1) + $signed({1'b0, Z19_S1}) + $signed({1'b0, Z31_S1}) + $signed({1'b0, Z7_S1}) + $signed({1'b0, Z43_S1});
    assign Z26_S2 = $signed(M26_0S1) + $signed(M26_1S1) + $signed({1'b0, Z26_S1}) + $signed({1'b0, Z14_S1}) + $signed({1'b0, Z38_S1}) + $signed({1'b0, Z2_S1}) + $signed({1'b0, Z50_S1});
    assign Z27_S2 = $signed(M27_0S1) + $signed(M27_1S1) + $signed({1'b0, Z27_S1}) + $signed({1'b0, Z15_S1}) + $signed({1'b0, Z39_S1}) + $signed({1'b0, Z3_S1}) + $signed({1'b0, Z51_S1});
    assign Z28_S2 = $signed(M28_0S1) + $signed(M28_1S1) + $signed({1'b0, Z28_S1}) + $signed({1'b0, Z16_S1}) + $signed({1'b0, Z40_S1}) + $signed({1'b0, Z4_S1}) + $signed({1'b0, Z52_S1});
    assign Z29_S2 = $signed(M29_0S1) + $signed(M29_1S1) + $signed({1'b0, Z29_S1}) + $signed({1'b0, Z17_S1}) + $signed({1'b0, Z41_S1}) + $signed({1'b0, Z5_S1}) + $signed({1'b0, Z53_S1});
    assign Z30_S2 = $signed(M30_0S1) + $signed(M30_1S1) + $signed(M30_2S1) + $signed({1'b0, Z0_S1}) + $signed({1'b0, Z12_S1}) + $signed({1'b0, Z24_S1}) + $signed({1'b0, Z36_S1}) + $signed({1'b0, Z48_S1}) + $signed({1'b0, Z60_S1});
    assign Z31_S2 = $signed(M31_0S1) + $signed(M31_1S1) + $signed({1'b0, Z31_S1}) + $signed({1'b0, Z19_S1}) + $signed({1'b0, Z43_S1}) + $signed({1'b0, Z7_S1}) + $signed({1'b0, Z55_S1});
    assign Z32_S2 = $signed(M32_0S1) + $signed(M32_1S1) + $signed({1'b0, Z32_S1}) + $signed({1'b0, Z20_S1}) + $signed({1'b0, Z44_S1}) + $signed({1'b0, Z8_S1}) + $signed({1'b0, Z56_S1});
    assign Z33_S2 = $signed(M33_0S1) + $signed(M33_1S1) + $signed({1'b0, Z33_S1}) + $signed({1'b0, Z21_S1}) + $signed({1'b0, Z45_S1}) + $signed({1'b0, Z9_S1}) + $signed({1'b0, Z57_S1});
    assign Z34_S2 = $signed(M34_0S1) + $signed(M34_1S1) + $signed({1'b0, Z34_S1}) + $signed({1'b0, Z22_S1}) + $signed({1'b0, Z46_S1}) + $signed({1'b0, Z10_S1}) + $signed({1'b0, Z58_S1});
    assign Z35_S2 = $signed(M35_0S1) + $signed(M35_1S1) + $signed({1'b0, Z29_S1}) + $signed({1'b0, Z41_S1}) + $signed({1'b0, Z17_S1}) + $signed({1'b0, Z53_S1});
    assign Z36_S2 = $signed(M36_0S1) + $signed(M36_1S1) + $signed({1'b0, Z36_S1}) + $signed({1'b0, Z12_S1}) + $signed({1'b0, Z24_S1}) + $signed({1'b0, Z48_S1}) + $signed({1'b0, Z60_S1});
    assign Z37_S2 = $signed(M37_0S1) + $signed(M37_1S1) + $signed({1'b0, Z31_S1}) + $signed({1'b0, Z43_S1}) + $signed({1'b0, Z19_S1}) + $signed({1'b0, Z55_S1});
    assign Z38_S2 = $signed(M38_0S1) + $signed(M38_1S1) + $signed({1'b0, Z32_S1}) + $signed({1'b0, Z44_S1}) + $signed({1'b0, Z20_S1}) + $signed({1'b0, Z56_S1});
    assign Z39_S2 = $signed(M39_0S1) + $signed(M39_1S1) + $signed({1'b0, Z33_S1}) + $signed({1'b0, Z45_S1}) + $signed({1'b0, Z21_S1}) + $signed({1'b0, Z57_S1});
    assign Z40_S2 = $signed(M40_0S1) + $signed(M40_1S1) + $signed({1'b0, Z34_S1}) + $signed({1'b0, Z46_S1}) + $signed({1'b0, Z22_S1}) + $signed({1'b0, Z58_S1});
    assign Z41_S2 = $signed(M41_S1) + $signed({1'b0, Z41_S1}) + $signed({1'b0, Z29_S1}) + $signed({1'b0, Z53_S1});
    assign Z42_0S2 = $signed(M42_0S1) + $signed({1'b0, Z36_S1}) + $signed({1'b0, Z48_S1});
    assign Z42_1S2 = $signed(M42_1S1) + $signed({1'b0, Z24_S1}) + $signed({1'b0, Z60_S1});
    assign Z43_S2 = $signed(M43_S1) + $signed({1'b0, Z43_S1}) + $signed({1'b0, Z31_S1}) + $signed({1'b0, Z55_S1});
    assign Z44_S2 = $signed(M44_S1) + $signed({1'b0, Z44_S1}) + $signed({1'b0, Z32_S1}) + $signed({1'b0, Z56_S1});
    assign Z45_S2 = $signed(M45_S1) + $signed({1'b0, Z45_S1}) + $signed({1'b0, Z33_S1}) + $signed({1'b0, Z57_S1});
    assign Z46_S2 = $signed(M46_S1) + $signed({1'b0, Z46_S1}) + $signed({1'b0, Z34_S1}) + $signed({1'b0, Z58_S1});
    assign Z47_S2 = $signed(M47_S1) + $signed({1'b0, Z41_S1}) + $signed({1'b0, Z53_S1}); 
    assign Z48_S2 = $signed(M48_S1) + $signed({1'b0, Z48_S1}) + $signed({1'b0, Z36_S1}) + $signed({1'b0, Z60_S1});
    assign Z49_S2 = $signed(M49_S1) + $signed({1'b0, Z43_S1}) + $signed({1'b0, Z55_S1});
    assign Z50_S2 = $signed(M50_S1) + $signed({1'b0, Z44_S1}) + $signed({1'b0, Z56_S1});
    assign Z51_S2 = $signed(M51_S1) + $signed({1'b0, Z45_S1}) + $signed({1'b0, Z57_S1});
    assign Z52_S2 = $signed(M52_S1) + $signed({1'b0, Z46_S1}) + $signed({1'b0, Z58_S1});
    assign Z54_S2 = $signed(M54_S1) + $signed({1'b0, Z48_S1}) + $signed({1'b0, Z60_S1}); 

    // Cycle 3
    reg [123:0] S123_0S3;
    reg [98:0] S187_88S3, S451_352S3;
    reg [95:0] S511_416S3;
    reg [75:0] S220_144S3, S388_312S3;
    reg [67:0] S252_184S3, S284_216S3, S316_248S3, S348_280S3;
    
    wire [186:0] S187_88S3_sh = S187_88S3 << 88;
    wire [107:0] S252_184S3_sh = S252_184S3 << 40;
    wire [99:0] S316_248S3_sh = S316_248S3 << 32;
    wire [107:0] S388_312S3_sh = S388_312S3 << 32;
    wire [159:0] S511_416S3_sh = S511_416S3 << 64;
    
    reg S3_valid;

    // Cycle 4
    reg [188:0] S188_0S4;
    reg [159:0] S511_352S4;
    reg [108:0] S253_144S4, S389_280S4;
    reg [100:0] S317_216S4;
    
    wire [252:0] S253_144S4_sh = S253_144S4 << 144;
    wire [172:0] S389_280S4_sh = S389_280S4 << 64;

    reg S4_valid;

    // Cycle 5
    reg [254:0] S254_0S5;
    reg [173:0] S390_216S5;
    reg [159:0] S511_352S5;
    
    wire [389:0] S390_216S5_sh = S390_216S5 << 216;

    reg S5_valid;

    // Cycle 6
    reg [391:0] S391_0S6;
    reg [159:0] S511_352S6;
    
    wire [511:0] S511_352S6_sh = S511_352S6 << 352;

    reg S6_valid;

    always @(posedge clock) begin
        if(reset) begin
            P <= 256'b0;
            S1_valid <= 1'b0;
            S2_valid <= 1'b0;
            S3_valid <= 1'b0;
            out_valid <= 1'b0;
        end
        else begin

            // Cycle 1
            Z0_S1 <= X[15:0] * Y[23:0];
            Z2_S1 <= X[31:16] * Y[23:0];
            Z3_S1 <= X[15:0] * Y[47:24];
            Z4_S1 <= X[47:32] * Y[23:0];
            Z5_S1 <= X[31:16] * Y[47:24];
            Z7_S1 <= X[47:32] * Y[47:24];
            Z8_S1 <= X[31:16] * Y[71:48];
            Z9_S1 <= X[63:48] * Y[47:24];
            Z10_S1 <= X[47:32] * Y[71:48];
            Z12_S1 <= X[63:48] * Y[71:48];
            Z14_S1 <= X[79:64] * Y[71:48];
            Z15_S1 <= X[63:48] * Y[95:72];
            Z16_S1 <= X[95:80] * Y[71:48];
            Z17_S1 <= X[79:64] * Y[95:72];
            Z19_S1 <= X[95:80] * Y[95:72];
            Z20_S1 <= X[79:64] * Y[119:96];
            Z21_S1 <= X[111:96] * Y[95:72];
            Z22_S1 <= X[95:80] * Y[119:96];
            Z24_S1 <= X[111:96] * Y[119:96];
            Z26_S1 <= X[127:112] * Y[119:96];
            Z27_S1 <= X[111:96] * Y[143:120];
            Z28_S1 <= X[143:128] * Y[119:96];
            Z29_S1 <= X[127:112] * Y[143:120];
            Z31_S1 <= X[143:128] * Y[143:120];
            Z32_S1 <= X[127:112] * Y[167:144];
            Z33_S1 <= X[159:144] * Y[143:120];
            Z34_S1 <= X[143:128] * Y[167:144];
            Z36_S1 <= X[159:144] * Y[167:144];
            Z38_S1 <= X[175:160] * Y[167:144];
            Z39_S1 <= X[159:144] * Y[191:168];
            Z40_S1 <= X[191:176] * Y[167:144];
            Z41_S1 <= X[175:160] * Y[191:168];
            Z43_S1 <= X[191:176] * Y[191:168];
            Z44_S1 <= X[175:160] * Y[215:192];
            Z45_S1 <= X[207:192] * Y[191:168];
            Z46_S1 <= X[191:176] * Y[215:192];
            Z48_S1 <= X[207:192] * Y[215:192];
            Z50_S1 <= X[223:208] * Y[215:192];
            Z51_S1 <= X[207:192] * Y[239:216];
            Z52_S1 <= X[239:224] * Y[215:192];
            Z53_S1 <= X[223:208] * Y[239:216];
            Z55_S1 <= X[239:224] * Y[239:216];
            Z56_S1 <= X[223:208] * Y[255:240]; // 32 BITS
            Z57_S1 <= X[255:240] * Y[239:216];
            Z58_S1 <= X[239:224] * Y[255:240]; // 32 BITS
            Z60_S1 <= X[255:240] * Y[255:240]; // 32 BITS

            M6_S1 <= ($signed({1'b0, X[15:0]}) - $signed({1'b0, X[63:48]})) * ($signed({1'b0, Y[71:48]}) - $signed({1'b0, Y[23:0]}));
            M8_S1 <= ($signed({1'b0, X[31:16]}) - $signed({1'b0, X[79:64]})) * ($signed({1'b0, Y[71:48]}) - $signed({1'b0, Y[23:0]}));
            M9_S1 <= ($signed({1'b0, X[15:0]}) - $signed({1'b0, X[63:48]})) * ($signed({1'b0, Y[95:72]}) - $signed({1'b0, Y[47:24]}));
            M10_S1 <= ($signed({1'b0, X[47:32]}) - $signed({1'b0, X[95:80]})) * ($signed({1'b0, Y[71:48]}) - $signed({1'b0, Y[23:0]}));
            M11_S1 <= ($signed({1'b0, X[31:16]}) - $signed({1'b0, X[79:64]})) * ($signed({1'b0, Y[95:72]}) - $signed({1'b0, Y[47:24]}));
            M12_S1 <= ($signed({1'b0, X[15:0]}) - $signed({1'b0, X[111:96]})) * ($signed({1'b0, Y[119:96]}) - $signed({1'b0, Y[23:0]}));
            M13_S1 <= ($signed({1'b0, X[47:32]}) - $signed({1'b0, X[95:80]})) * ($signed({1'b0, Y[95:72]}) - $signed({1'b0, Y[47:24]}));
            M14_S1 <= ($signed({1'b0, X[31:16]}) - $signed({1'b0, X[127:112]})) * ($signed({1'b0, Y[119:96]}) - $signed({1'b0, Y[23:0]}));
            M15_S1 <= ($signed({1'b0, X[15:0]}) - $signed({1'b0, X[111:96]})) * ($signed({1'b0, Y[143:120]}) - $signed({1'b0, Y[47:24]}));
            M16_S1 <= ($signed({1'b0, X[47:32]}) - $signed({1'b0, X[143:128]})) * ($signed({1'b0, Y[119:96]}) - $signed({1'b0, Y[23:0]}));
            M17_S1 <= ($signed({1'b0, X[31:16]}) - $signed({1'b0, X[127:112]})) * ($signed({1'b0, Y[143:120]}) - $signed({1'b0, Y[47:24]}));
            M18_0S1 <= ($signed({1'b0, X[63:48]}) - $signed({1'b0, X[111:96]})) * ($signed({1'b0, Y[119:96]}) - $signed({1'b0, Y[71:48]}));
            M18_1S1 <= ($signed({1'b0, X[15:0]}) - $signed({1'b0, X[159:144]})) * ($signed({1'b0, Y[167:144]}) - $signed({1'b0, Y[23:0]}));
            M19_S1 <= ($signed({1'b0, X[47:32]}) - $signed({1'b0, X[143:128]})) * ($signed({1'b0, Y[143:120]}) - $signed({1'b0, Y[47:24]}));
            M20_0S1 <= ($signed({1'b0, X[79:64]}) - $signed({1'b0, X[127:112]})) * ($signed({1'b0, Y[119:96]}) - $signed({1'b0, Y[71:48]}));
            M20_1S1 <= ($signed({1'b0, X[31:16]}) - $signed({1'b0, X[175:160]})) * ($signed({1'b0, Y[167:144]}) - $signed({1'b0, Y[23:0]}));
            M21_0S1 <= ($signed({1'b0, X[15:0]}) - $signed({1'b0, X[159:144]})) * ($signed({1'b0, Y[191:168]}) - $signed({1'b0, Y[47:24]}));
            M21_1S1 <= ($signed({1'b0, X[63:48]}) - $signed({1'b0, X[111:96]})) * ($signed({1'b0, Y[143:120]}) - $signed({1'b0, Y[95:72]}));
            M22_0S1 <= ($signed({1'b0, X[95:80]}) - $signed({1'b0, X[143:128]})) * ($signed({1'b0, Y[119:96]}) - $signed({1'b0, Y[71:48]}));
            M22_1S1 <= ($signed({1'b0, X[47:32]}) - $signed({1'b0, X[191:176]})) * ($signed({1'b0, Y[167:144]}) - $signed({1'b0, Y[23:0]}));
            M23_0S1 <= ($signed({1'b0, X[79:64]}) - $signed({1'b0, X[127:112]})) * ($signed({1'b0, Y[143:120]}) - $signed({1'b0, Y[95:72]}));
            M23_1S1 <= ($signed({1'b0, X[31:16]}) - $signed({1'b0, X[175:160]})) * ($signed({1'b0, Y[191:168]}) - $signed({1'b0, Y[47:24]}));
            M24_0S1 <= ($signed({1'b0, X[15:0]}) - $signed({1'b0, X[207:192]})) * ($signed({1'b0, Y[215:192]}) - $signed({1'b0, Y[23:0]}));
            M24_1S1 <= ($signed({1'b0, X[63:48]}) - $signed({1'b0, X[159:144]})) * ($signed({1'b0, Y[167:144]}) - $signed({1'b0, Y[71:48]}));
            M25_0S1 <= ($signed({1'b0, X[95:80]}) - $signed({1'b0, X[143:128]})) * ($signed({1'b0, Y[143:120]}) - $signed({1'b0, Y[95:72]}));
            M25_1S1 <= ($signed({1'b0, X[47:32]}) - $signed({1'b0, X[191:176]})) * ($signed({1'b0, Y[191:168]}) - $signed({1'b0, Y[47:24]}));
            M26_0S1 <= ($signed({1'b0, X[31:16]}) - $signed({1'b0, X[223:208]})) * ($signed({1'b0, Y[215:192]}) - $signed({1'b0, Y[23:0]}));
            M26_1S1 <= ($signed({1'b0, X[79:64]}) - $signed({1'b0, X[175:160]})) * ($signed({1'b0, Y[167:144]}) - $signed({1'b0, Y[71:48]}));
            M27_0S1 <= ($signed({1'b0, X[15:0]}) - $signed({1'b0, X[207:192]})) * ($signed({1'b0, Y[239:216]}) - $signed({1'b0, Y[47:24]}));
            M27_1S1 <= ($signed({1'b0, X[63:48]}) - $signed({1'b0, X[159:144]})) * ($signed({1'b0, Y[191:168]}) - $signed({1'b0, Y[95:72]}));
            M28_0S1 <= ($signed({1'b0, X[47:32]}) - $signed({1'b0, X[239:224]})) * ($signed({1'b0, Y[215:192]}) - $signed({1'b0, Y[23:0]}));
            M28_1S1 <= ($signed({1'b0, X[95:80]}) - $signed({1'b0, X[191:176]})) * ($signed({1'b0, Y[167:144]}) - $signed({1'b0, Y[71:48]}));
            M29_0S1 <= ($signed({1'b0, X[31:16]}) - $signed({1'b0, X[223:208]})) * ($signed({1'b0, Y[239:216]}) - $signed({1'b0, Y[47:24]}));
            M29_1S1 <= ($signed({1'b0, X[79:64]}) - $signed({1'b0, X[175:160]})) * ($signed({1'b0, Y[191:168]}) - $signed({1'b0, Y[95:72]}));
            M30_0S1 <= ($signed({1'b0, X[15:0]}) - $signed({1'b0, X[255:240]})) * ($signed({1'b0, Y[255:240]}) - $signed({1'b0, Y[23:0]})); 
            M30_1S1 <= ($signed({1'b0, X[63:48]}) - $signed({1'b0, X[207:192]})) * ($signed({1'b0, Y[215:192]}) - $signed({1'b0, Y[71:48]}));
            M30_2S1 <= ($signed({1'b0, X[111:96]}) - $signed({1'b0, X[159:144]})) * ($signed({1'b0, Y[167:144]}) - $signed({1'b0, Y[119:96]}));
            M31_0S1 <= ($signed({1'b0, X[47:32]}) - $signed({1'b0, X[239:224]})) * ($signed({1'b0, Y[239:216]}) - $signed({1'b0, Y[47:24]}));
            M31_1S1 <= ($signed({1'b0, X[95:80]}) - $signed({1'b0, X[191:176]})) * ($signed({1'b0, Y[191:168]}) - $signed({1'b0, Y[95:72]}));
            M32_0S1 <= ($signed({1'b0, X[79:64]}) - $signed({1'b0, X[175:160]})) * ($signed({1'b0, Y[215:192]}) - $signed({1'b0, Y[119:96]}));
            M32_1S1 <= ($signed({1'b0, X[31:16]}) - $signed({1'b0, X[223:208]})) * ($signed({1'b0, Y[255:240]}) - $signed({1'b0, Y[71:48]}));
            M33_0S1 <= ($signed({1'b0, X[63:48]}) - $signed({1'b0, X[255:240]})) * ($signed({1'b0, Y[239:216]}) - $signed({1'b0, Y[47:24]}));
            M33_1S1 <= ($signed({1'b0, X[111:96]}) - $signed({1'b0, X[207:192]})) * ($signed({1'b0, Y[191:168]}) - $signed({1'b0, Y[95:72]}));
            M34_0S1 <= ($signed({1'b0, X[47:32]}) - $signed({1'b0, X[239:224]})) * ($signed({1'b0, Y[255:240]}) - $signed({1'b0, Y[71:48]}));
            M34_1S1 <= ($signed({1'b0, X[95:80]}) - $signed({1'b0, X[191:176]})) * ($signed({1'b0, Y[215:192]}) - $signed({1'b0, Y[119:96]}));
            M35_0S1 <= ($signed({1'b0, X[127:112]}) - $signed({1'b0, X[175:160]})) * ($signed({1'b0, Y[191:168]}) - $signed({1'b0, Y[143:120]}));
            M35_1S1 <= ($signed({1'b0, X[79:64]}) - $signed({1'b0, X[223:208]})) * ($signed({1'b0, Y[239:216]}) - $signed({1'b0, Y[95:72]}));
            M36_0S1 <= ($signed({1'b0, X[63:48]}) - $signed({1'b0, X[255:240]})) * ($signed({1'b0, Y[255:240]}) - $signed({1'b0, Y[71:48]}));
            M36_1S1 <= ($signed({1'b0, X[111:96]}) - $signed({1'b0, X[207:192]})) * ($signed({1'b0, Y[215:192]}) - $signed({1'b0, Y[119:96]}));
            M37_0S1 <= ($signed({1'b0, X[143:128]}) - $signed({1'b0, X[191:176]})) * ($signed({1'b0, Y[191:168]}) - $signed({1'b0, Y[143:120]}));
            M37_1S1 <= ($signed({1'b0, X[95:80]}) - $signed({1'b0, X[239:224]})) * ($signed({1'b0, Y[239:216]}) - $signed({1'b0, Y[95:72]}));
            M38_0S1 <= ($signed({1'b0, X[79:64]}) - $signed({1'b0, X[223:208]})) * ($signed({1'b0, Y[255:240]}) - $signed({1'b0, Y[119:96]}));
            M38_1S1 <= ($signed({1'b0, X[127:112]}) - $signed({1'b0, X[175:160]})) * ($signed({1'b0, Y[215:192]}) - $signed({1'b0, Y[167:144]}));
            M39_0S1 <= ($signed({1'b0, X[111:96]}) - $signed({1'b0, X[255:240]})) * ($signed({1'b0, Y[239:216]}) - $signed({1'b0, Y[95:72]}));
            M39_1S1 <= ($signed({1'b0, X[159:144]}) - $signed({1'b0, X[207:192]})) * ($signed({1'b0, Y[191:168]}) - $signed({1'b0, Y[143:120]}));
            M40_0S1 <= ($signed({1'b0, X[95:80]}) - $signed({1'b0, X[239:224]})) * ($signed({1'b0, Y[255:240]}) - $signed({1'b0, Y[119:96]}));
            M40_1S1 <= ($signed({1'b0, X[143:128]}) - $signed({1'b0, X[191:176]})) * ($signed({1'b0, Y[215:192]}) - $signed({1'b0, Y[167:144]}));
            M41_S1 <= ($signed({1'b0, X[127:112]}) - $signed({1'b0, X[223:208]})) * ($signed({1'b0, Y[239:216]}) - $signed({1'b0, Y[143:120]}));
            M42_0S1 <= ($signed({1'b0, X[159:144]}) - $signed({1'b0, X[207:192]})) * ($signed({1'b0, Y[215:192]}) - $signed({1'b0, Y[167:144]}));
            M42_1S1 <= ($signed({1'b0, X[111:96]}) - $signed({1'b0, X[255:240]})) * ($signed({1'b0, Y[255:240]}) - $signed({1'b0, Y[119:96]}));
            M43_S1 <= ($signed({1'b0, X[143:128]}) - $signed({1'b0, X[239:224]})) * ($signed({1'b0, Y[239:216]}) - $signed({1'b0, Y[143:120]}));
            M44_S1 <= ($signed({1'b0, X[127:112]}) - $signed({1'b0, X[223:208]})) * ($signed({1'b0, Y[255:240]}) - $signed({1'b0, Y[167:144]}));
            M45_S1 <= ($signed({1'b0, X[159:144]}) - $signed({1'b0, X[255:240]})) * ($signed({1'b0, Y[239:216]}) - $signed({1'b0, Y[143:120]}));
            M46_S1 <= ($signed({1'b0, X[143:128]}) - $signed({1'b0, X[239:224]})) * ($signed({1'b0, Y[255:240]}) - $signed({1'b0, Y[167:144]}));
            M47_S1 <= ($signed({1'b0, X[175:160]}) - $signed({1'b0, X[223:208]})) * ($signed({1'b0, Y[239:216]}) - $signed({1'b0, Y[191:168]}));
            M48_S1 <= ($signed({1'b0, X[159:144]}) - $signed({1'b0, X[255:240]})) * ($signed({1'b0, Y[255:240]}) - $signed({1'b0, Y[167:144]}));
            M49_S1 <= ($signed({1'b0, X[191:176]}) - $signed({1'b0, X[239:224]})) * ($signed({1'b0, Y[239:216]}) - $signed({1'b0, Y[191:168]}));
            M50_S1 <= ($signed({1'b0, X[175:160]}) - $signed({1'b0, X[223:208]})) * ($signed({1'b0, Y[255:240]}) - $signed({1'b0, Y[215:192]}));
            M51_S1 <= ($signed({1'b0, X[207:192]}) - $signed({1'b0, X[255:240]})) * ($signed({1'b0, Y[239:216]}) - $signed({1'b0, Y[191:168]}));
            M52_S1 <= ($signed({1'b0, X[191:176]}) - $signed({1'b0, X[239:224]})) * ($signed({1'b0, Y[255:240]}) - $signed({1'b0, Y[215:192]}));
            M54_S1 <= ($signed({1'b0, X[207:192]}) - $signed({1'b0, X[255:240]})) * ($signed({1'b0, Y[255:240]}) - $signed({1'b0, Y[215:192]}));

            S1_valid <= in_valid;
            
            // Cycle 2
            S80_0S2 <= {Z5_S1, Z0_S1} + {24'b0, Z2_S1_sh} + {16'b0, Z3_S1_sh} + {8'b0, Z4_S1_sh};
            S106_48S2 <= {16'b0, Z6_S2} + {9'b0, Z7_S1_sh} + Z8_S2_sh;
            S122_72S2 <= {8'b0, Z9_S2} + Z10_S2_sh;
            S139_88S2 <= {9'b0, Z11_S2} + Z12_S2_sh;
            S155_104S2 <= {9'b0, Z13_S2} + Z14_S2_sh;
            S171_120S2 <= {8'b0, Z15_S2} + Z16_S2_sh;
            S186_136S2 <= {7'b0, Z17_S2} + Z18_0S2_sh;
            S195_144S2 <= {9'b0, Z18_1S2} + Z19_S2_sh;
            S203_160S2 <= Z20_S2;
            S211_168S2 <= Z21_S2;
            S219_176S2 <= Z22_S2;
            S227_184S2 <= Z23_S2;
            S235_192S2 <= Z24_S2;
            S243_200S2 <= Z25_S2;
            S251_208S2 <= Z26_S2;
            S259_216S2 <= Z27_S2;
            S267_224S2 <= Z28_S2;
            S275_232S2 <= Z29_S2;
            S283_240S2 <= Z30_S2;
            S291_248S2 <= Z31_S2;
            S299_256S2 <= Z32_S2;
            S307_264S2 <= Z33_S2;
            S315_272S2 <= Z34_S2;
            S323_280S2 <= Z35_S2;
            S331_288S2 <= Z36_S2;
            S339_296S2 <= Z37_S2;
            S347_304S2 <= Z38_S2;
            S355_312S2 <= Z39_S2;
            S363_320S2 <= Z40_S2;
            S378_328S2 <= {7'b0, Z41_S2} + Z42_0S2_sh;
            S387_336S2 <= {9'b0, Z42_1S2} + Z43_S2_sh;
            S403_352S2 <= {8'b0, Z44_S2} + Z45_S2_sh;
            S418_368S2 <= {7'b0, Z46_S2} + Z47_S2_sh;
            S434_384S2 <= {7'b0, Z48_S2} + Z49_S2_sh;
            S450_400S2 <= {8'b0, Z50_S2} + Z51_S2_sh;
            S465_416S2 <= {7'b0, Z52_S2} + Z53_S1_sh;
            S489_432S2 <= {7'b0, Z54_S2} + Z55_S1_sh + Z56_S1_sh;
            S511_456S2 <= {16'b0, Z57_S1} + {16'b0, Z58_S1_sh} + Z60_S1_sh;

            S2_valid <= S1_valid;

            // Cycle 3
            S123_0S3 <= {41'b0, S80_0S2} + {16'b0, S106_48S2_sh} + S122_72S2_sh;
            S187_88S3 <= {47'b0, S139_88S2} + {31'b0, S155_104S2_sh} + {15'b0, S171_120S2_sh} + S186_136S2_sh;
            S220_144S3 <= {24'b0, S195_144S2} + {16'b0, S203_160S2_sh} + {8'b0, S211_168S2_sh} + S219_176S2_sh;
            S252_184S3 <= {24'b0, S227_184S2} + {16'b0, S235_192S2_sh} + {8'b0, S243_200S2_sh} + S251_208S2_sh;
            S284_216S3 <= {24'b0, S259_216S2} + {16'b0, S267_224S2_sh} + {8'b0, S275_232S2_sh} + S283_240S2_sh;
            S316_248S3 <= {24'b0, S291_248S2} + {16'b0, S299_256S2_sh} + {8'b0, S307_264S2_sh} + S315_272S2_sh;
            S348_280S3 <= {24'b0, S323_280S2} + {16'b0, S331_288S2_sh} + {8'b0, S339_296S2_sh} + S347_304S2_sh;
            S388_312S3 <= {32'b0, S355_312S2} + {24'b0, S363_320S2_sh} + {9'b0, S378_328S2_sh} + S387_336S2_sh;
            S451_352S3 <= {47'b0, S403_352S2} + {32'b0, S418_368S2_sh} + {16'b0, S434_384S2_sh} + S450_400S2_sh;
            S511_416S3 <= {46'b0, S465_416S2} + {22'b0, S489_432S2_sh} + S511_456S2_sh;

            S3_valid <= S2_valid;

            // Cycle 4 
            S188_0S4 <= {63'b0, S123_0S3} + S187_88S3_sh;
            S253_144S4 <= {32'b0, S220_144S3} + S252_184S3_sh;
            S317_216S4 <= {32'b0, S284_216S3} + S316_248S3_sh;
            S389_280S4 <= {40'b0, S348_280S3} + S388_312S3_sh;
            S511_352S4 <= {60'b0, S451_352S3} + S511_416S3_sh;

            S4_valid <= S3_valid;

            // Cycle 5
            S254_0S5 <= {64'b0, S188_0S4} + S253_144S4_sh;
            S390_216S5 <= {72'b0, S317_216S4} + S389_280S4_sh;
            S511_352S5 <= S511_352S4;

            S5_valid <= S4_valid;

             // Cycle 6
            S391_0S6 <= {145'b0, S254_0S5} + S390_216S5_sh;
            S511_352S6 <= S511_352S5;

            S6_valid <= S5_valid;

            // Cycle 7
            P <= {119'b0, S391_0S6} + S511_352S6_sh;

            out_valid <= S6_valid;
        end
    end

endmodule