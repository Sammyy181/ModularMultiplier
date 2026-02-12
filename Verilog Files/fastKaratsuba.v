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
    (* use_dsp = "yes" *) reg [39:0] Z0_S1, Z2_S1, Z3_S1, Z4_S1, Z5_S1, Z7_S1, Z8_0S1, Z8_1S1, Z9_0S1, Z9_1S1,
                Z10_0S1, Z10_1S1, Z12_S1, Z14_S1, Z15_S1, Z16_S1, Z17_S1, Z19_S1,
                Z20_0S1, Z20_1S1, Z21_0S1, Z21_1S1, Z22_0S1, Z22_1S1, Z24_S1, Z26_S1, Z27_S1, Z28_S1, Z29_S1,
                Z31_S1, Z32_S1, Z33_S1, Z34_S1, Z36_S1, Z38_0S1, Z38_1S1, Z39_0S1, Z39_1S1, Z40_0S1, Z40_1S1, 
                Z41_S1, Z43_S1, Z44_S1, Z45_S1, Z46_S1, Z48_S1, Z50_0S1,
                Z51_0S1, Z51_1S1, Z52_0S1, Z53_S1, Z55_S1, Z57_S1;
    (* use_dsp = "yes" *) reg [31:0] Z50_1S1, Z52_1S1, Z56_S1, Z58_S1, Z60_S1;

    reg [17:0] diffX0_6S1, diffX2_8S1, diffX4_10S1, diffX0_12S1, diffX2_14S1, diffX4_16S1, diffX6_12S1, diffX0_18S1, diffX8_14S1, 
                diffX2_20S1, diffX10_16S1, diffX4_22S1, diffX0_24S1, diffX6_18S1, diffX2_26S1, diffX8_20S1, diffX4_28S1, diffX10_22S1,
                diffX0_30S1, diffX6_24S1, diffX12_18S1, diffX6_30S1, diffX14_20S1, diffX8_26S1, diffX12_24S1, diffX16_22S1, diffX10_28S1, 
                diffX12_30S1, diffX18_24S1, diffX16_28S1, diffX14_26S1, diffX18_30S1, diffX20_26S1, diffX22_28S1, diffX24_30S1;

    reg [24:0] diffY6_0S1, diffY9_3S1, diffY12_0S1, diffY15_3S1, diffY12_6S1, diffY18_0S1, diffY21_3S1, diffY15_9S1, diffY24_0S1, diffY18_6S1, 
                diffY27_3S1, diffY21_9S1, diffY30_0S1, diffY24_6S1, diffY18_12S1, diffY24_12S1, diffY30_6S1, diffY27_9S1, diffY21_15S1, diffY30_12S1,
                diffY24_18S1, diffY27_15S1, diffY30_18S1, diffY27_21S1, diffY30_24S1;

    reg S1_valid;

    // Cycle 2
    reg [39:0] Z0_S2, Z2_S2, Z3_S2, Z4_S2, Z5_S2, Z7_S2, Z8_S2, Z9_S2,
                Z10_S2, Z12_S2, Z14_S2, Z15_S2, Z16_S2, Z17_S2, Z19_S2,
                Z20_S2, Z21_S2, Z22_S2, Z24_S2, Z26_S2, Z27_S2, Z28_S2, Z29_S2,
                Z31_S2, Z32_S2, Z33_S2, Z34_S2, Z36_S2, Z38_S2, Z39_S2, Z40_S2,
                Z41_S2, Z43_S2, Z44_S2, Z45_S2, Z46_S2, Z48_S2,
                Z50_S2, Z51_S2, Z52_S2, Z53_S2, Z55_S2, Z57_S2;
    reg [31:0] Z56_S2, Z58_S2, Z60_S2;

    reg [40:0] C8_S2, C9_S2, C10_S2, C20_S2, C21_S2, C22_S2, C38_S2, C39_S2, C40_S2, C50_S2, C51_S2, C52_S2;

    wire [55:0] Z2_S2_sh = Z2_S2 << 16;
    wire [63:0] Z3_S2_sh = Z3_S2 << 24;
    wire [71:0] Z4_S2_sh = Z4_S2 << 32;
    wire [47:0] Z7_S2_sh = Z7_S2 << 8;
    wire [47:0] Z53_S2_sh = Z53_S2 << 8;
    wire [47:0] Z55_S2_sh = Z55_S2 << 8;
    wire [47:0] Z56_S2_sh = Z56_S2 << 16;
    wire [39:0] Z58_S2_sh = Z58_S2 << 8;
    wire [55:0] Z60_S2_sh = Z60_S2 << 24;

    wire [56:0] C8_S2_sh = C8_S2 << 16;
    wire [48:0] C10_S2_sh = C10_S2 << 8;
    wire [48:0] C51_S2_sh = C51_S2 << 8;

    (* use_dsp = "yes" *) reg [40:0] M6_S2, M11_S2, M12_S2, M13_S2, M14_S2, M15_S2, M16_S2, M17_S2, M18_0S2, M18_1S2, M19_S2,
                M20_S2, M21_S2, M22_S2, M23_0S2, M23_1S2, M24_0S2, M24_1S2, M25_0S2, M25_1S2,
                M26_0S2, M26_1S2, M27_0S2, M27_1S2, M28_0S2, M28_1S2, M29_0S2, M29_1S2, M30_0S2, M30_1S2, M30_2S2, M31_0S2,
                M31_1S2, M32_0S2, M32_1S2, M33_0S2, M33_1S2, M34_0S2, M34_1S2, M35_0S2, M35_1S2, M36_0S2, M36_1S2, M37_0S2,
                M37_1S2, M38_S2, M39_S2, M40_S2, M41_S2, M42_0S2, M42_1S2, M43_S2, M44_S2, M45_S2,
                M46_S2, M47_S2, M48_S2, M49_S2, M54_S2; 

    reg S2_valid;

    // Cycle 3
    wire [40:0] Z6_S3, Z11_S3, Z13_S3, Z18_0S3, Z18_1S3, Z42_0S3, Z42_1S3, Z47_S3, Z49_S3, Z50_S3, Z51_S3, Z52_S3, Z54_S3;
    wire [41:0] Z12_S3, Z14_S3, Z15_S3, Z16_S3, Z17_S3, Z19_S3, Z41_S3, Z43_S3, Z44_S3, Z45_S3, Z46_S3, Z48_S3;
    wire [42:0] Z20_S3, Z21_S3, Z22_S3, Z23_S3, Z24_S3, Z25_S3, Z26_S3, Z27_S3, Z28_S3, Z29_S3, Z30_S3, Z31_S3, Z32_S3, Z33_S3, Z34_S3, Z35_S3, Z36_S3, Z37_S3, Z38_S3, 
                Z39_S3, Z40_S3;

    assign Z6_S3 = $signed(M6_S2) + $signed({1'b0, Z0_S2}) + $signed({1'b0, Z12_S2});
    assign Z11_S3 = $signed(M11_S2) + $signed({1'b0, Z5_S2}) + $signed({1'b0, Z17_S2});
    assign Z12_S3 = $signed(M12_S2) + $signed({1'b0, Z12_S2}) + $signed({1'b0, Z0_S2}) + $signed({1'b0, Z24_S2});
    assign Z13_S3 = $signed(M13_S2) + $signed({1'b0, Z7_S2}) + $signed({1'b0, Z19_S2});
    assign Z14_S3 = $signed(M14_S2) + $signed({1'b0, Z14_S2}) + $signed({1'b0, Z2_S2}) + $signed({1'b0, Z26_S2});
    assign Z15_S3 = $signed(M15_S2) + $signed({1'b0, Z15_S2}) + $signed({1'b0, Z3_S2}) + $signed({1'b0, Z27_S2});
    assign Z16_S3 = $signed(M16_S2) + $signed({1'b0, Z16_S2}) + $signed({1'b0, Z4_S2}) + $signed({1'b0, Z28_S2});
    assign Z17_S3 = $signed(M17_S2) + $signed({1'b0, Z17_S2}) + $signed({1'b0, Z5_S2}) + $signed({1'b0, Z29_S2});
    assign Z18_0S3 = $signed(M18_0S2) + $signed({1'b0, Z12_S2}) + $signed({1'b0, Z24_S2});
    assign Z18_1S3 = $signed(M18_1S2) + $signed({1'b0, Z0_S2}) + $signed({1'b0, Z36_S2});
    assign Z19_S3 = $signed(M19_S2) + $signed({1'b0, Z19_S2}) + $signed({1'b0, Z7_S2}) + $signed({1'b0, Z31_S2});
    assign Z20_S3 = $signed({1'b0, C20_S2}) + $signed(M20_S2) + $signed({1'b0, Z2_S2}) + $signed({1'b0, Z38_S2});
    assign Z21_S3 = $signed({1'b0, C21_S2}) + $signed(M21_S2) + $signed({1'b0, Z3_S2}) + $signed({1'b0, Z39_S2});
    assign Z22_S3 = $signed({1'b0, C22_S2}) + $signed(M22_S2) + $signed({1'b0, Z4_S2}) + $signed({1'b0, Z40_S2});
    assign Z23_S3 = $signed(M23_0S2) + $signed(M23_1S2) + $signed({1'b0, Z17_S2}) + $signed({1'b0, Z29_S2}) + $signed({1'b0, Z5_S2}) + $signed({1'b0, Z41_S2});
    assign Z24_S3 = $signed(M24_0S2) + $signed(M24_1S2) + $signed({1'b0, Z24_S2}) + $signed({1'b0, Z12_S2}) + $signed({1'b0, Z36_S2}) + $signed({1'b0, Z0_S2}) + $signed({1'b0, Z48_S2});
    assign Z25_S3 = $signed(M25_0S2) + $signed(M25_1S2) + $signed({1'b0, Z19_S2}) + $signed({1'b0, Z31_S2}) + $signed({1'b0, Z7_S2}) + $signed({1'b0, Z43_S2});
    assign Z26_S3 = $signed(M26_0S2) + $signed(M26_1S2) + $signed({1'b0, Z26_S2}) + $signed({1'b0, Z14_S2}) + $signed({1'b0, Z38_S2}) + $signed({1'b0, Z2_S2}) + $signed({1'b0, Z50_S2});
    assign Z27_S3 = $signed(M27_0S2) + $signed(M27_1S2) + $signed({1'b0, Z27_S2}) + $signed({1'b0, Z15_S2}) + $signed({1'b0, Z39_S2}) + $signed({1'b0, Z3_S2}) + $signed({1'b0, Z51_S2});
    assign Z28_S3 = $signed(M28_0S2) + $signed(M28_1S2) + $signed({1'b0, Z28_S2}) + $signed({1'b0, Z16_S2}) + $signed({1'b0, Z40_S2}) + $signed({1'b0, Z4_S2}) + $signed({1'b0, Z52_S2});
    assign Z29_S3 = $signed(M29_0S2) + $signed(M29_1S2) + $signed({1'b0, Z29_S2}) + $signed({1'b0, Z17_S2}) + $signed({1'b0, Z41_S2}) + $signed({1'b0, Z5_S2}) + $signed({1'b0, Z53_S2});
    assign Z30_S3 = $signed(M30_0S2) + $signed(M30_1S2) + $signed(M30_2S2) + $signed({1'b0, Z0_S2}) + $signed({1'b0, Z12_S2}) + $signed({1'b0, Z24_S2}) + $signed({1'b0, Z36_S2}) + $signed({1'b0, Z48_S2}) + $signed({1'b0, Z60_S2});
    assign Z31_S3 = $signed(M31_0S2) + $signed(M31_1S2) + $signed({1'b0, Z31_S2}) + $signed({1'b0, Z19_S2}) + $signed({1'b0, Z43_S2}) + $signed({1'b0, Z7_S2}) + $signed({1'b0, Z55_S2});
    assign Z32_S3 = $signed(M32_0S2) + $signed(M32_1S2) + $signed({1'b0, Z32_S2}) + $signed({1'b0, Z20_S2}) + $signed({1'b0, Z44_S2}) + $signed({1'b0, Z8_S2}) + $signed({1'b0, Z56_S2});
    assign Z33_S3 = $signed(M33_0S2) + $signed(M33_1S2) + $signed({1'b0, Z33_S2}) + $signed({1'b0, Z21_S2}) + $signed({1'b0, Z45_S2}) + $signed({1'b0, Z9_S2}) + $signed({1'b0, Z57_S2});
    assign Z34_S3 = $signed(M34_0S2) + $signed(M34_1S2) + $signed({1'b0, Z34_S2}) + $signed({1'b0, Z22_S2}) + $signed({1'b0, Z46_S2}) + $signed({1'b0, Z10_S2}) + $signed({1'b0, Z58_S2});
    assign Z35_S3 = $signed(M35_0S2) + $signed(M35_1S2) + $signed({1'b0, Z29_S2}) + $signed({1'b0, Z41_S2}) + $signed({1'b0, Z17_S2}) + $signed({1'b0, Z53_S2});
    assign Z36_S3 = $signed(M36_0S2) + $signed(M36_1S2) + $signed({1'b0, Z36_S2}) + $signed({1'b0, Z12_S2}) + $signed({1'b0, Z24_S2}) + $signed({1'b0, Z48_S2}) + $signed({1'b0, Z60_S2});
    assign Z37_S3 = $signed(M37_0S2) + $signed(M37_1S2) + $signed({1'b0, Z31_S2}) + $signed({1'b0, Z43_S2}) + $signed({1'b0, Z19_S2}) + $signed({1'b0, Z55_S2});
    assign Z38_S3 = $signed({1'b0, C38_S2}) + $signed(M38_S2) + $signed({1'b0, Z20_S2}) + $signed({1'b0, Z56_S2});
    assign Z39_S3 = $signed({1'b0, C39_S2}) + $signed(M39_S2) + $signed({1'b0, Z21_S2}) + $signed({1'b0, Z57_S2});
    assign Z40_S3 = $signed({1'b0, C40_S2}) + $signed(M40_S2) + $signed({1'b0, Z22_S2}) + $signed({1'b0, Z58_S2});
    assign Z41_S3 = $signed(M41_S2) + $signed({1'b0, Z41_S2}) + $signed({1'b0, Z29_S2}) + $signed({1'b0, Z53_S2});
    assign Z42_0S3 = $signed(M42_0S2) + $signed({1'b0, Z36_S2}) + $signed({1'b0, Z48_S2});
    assign Z42_1S3 = $signed(M42_1S2) + $signed({1'b0, Z24_S2}) + $signed({1'b0, Z60_S2});
    assign Z43_S3 = $signed(M43_S2) + $signed({1'b0, Z43_S2}) + $signed({1'b0, Z31_S2}) + $signed({1'b0, Z55_S2});
    assign Z44_S3 = $signed(M44_S2) + $signed({1'b0, Z44_S2}) + $signed({1'b0, Z32_S2}) + $signed({1'b0, Z56_S2});
    assign Z45_S3 = $signed(M45_S2) + $signed({1'b0, Z45_S2}) + $signed({1'b0, Z33_S2}) + $signed({1'b0, Z57_S2});
    assign Z46_S3 = $signed(M46_S2) + $signed({1'b0, Z46_S2}) + $signed({1'b0, Z34_S2}) + $signed({1'b0, Z58_S2});
    assign Z47_S3 = $signed(M47_S2) + $signed({1'b0, Z41_S2}) + $signed({1'b0, Z53_S2}); 
    assign Z48_S3 = $signed(M48_S2) + $signed({1'b0, Z48_S2}) + $signed({1'b0, Z36_S2}) + $signed({1'b0, Z60_S2});
    assign Z49_S3 = $signed(M49_S2) + $signed({1'b0, Z43_S2}) + $signed({1'b0, Z55_S2});
    assign Z54_S3 = $signed(M54_S2) + $signed({1'b0, Z48_S2}) + $signed({1'b0, Z60_S2}); 
                
    wire [49:0] Z12_S3_sh = Z12_S3 << 8;
    wire [49:0] Z14_S3_sh = Z14_S3 << 8;
    wire [49:0] Z16_S3_sh = Z16_S3 << 8;
    wire [48:0] Z18_0S3_sh = Z18_0S3 << 8;
    wire [49:0] Z19_S3_sh = Z19_S3 << 8;
    wire [48:0] Z42_0S3_sh = Z42_0S3 << 8;
    wire [49:0] Z43_S3_sh = Z43_S3 << 8;
    wire [49:0] Z45_S3_sh = Z45_S3 << 8;
    wire [48:0] Z47_S3_sh = Z47_S3 << 8;
    wire [48:0] Z49_S3_sh = Z49_S3 << 8;

    reg [80:0] S80_0S3;
    reg [57:0] S106_48S3;
    reg [56:0] S489_432S3; 
    reg [55:0] S511_456S3;
    reg [50:0] S139_88S3, S155_104S3, S171_120S3, S195_144S3, S387_336S3, S403_352S3;
    reg [49:0] S122_72S3, S186_136S3, S378_328S3, S418_368S3, S434_384S3, S450_400S3;
    reg [48:0] S465_416S3;
    reg [42:0] S203_160S3, S211_168S3, S219_176S3, S227_184S3, S235_192S3, S243_200S3, S251_208S3, S259_216S3, S267_224S3, S275_232S3, S283_240S3,
                S291_248S3, S299_256S3, S307_264S3, S315_272S3, S323_280S3, S331_288S3, S339_296S3, S347_304S3, S355_312S3, S363_320S3;
	
	wire [105:0] S106_48S3_sh = S106_48S3 << 48;
	wire [121:0] S122_72S3_sh = S122_72S3 << 72;
	wire [66:0] S155_104S3_sh = S155_104S3 << 16;
	wire [82:0] S171_120S3_sh = S171_120S3 << 32;
	wire [97:0] S186_136S3_sh = S186_136S3 << 48;
	wire [58:0] S203_160S3_sh = S203_160S3 << 16;
	wire [66:0] S211_168S3_sh = S211_168S3 << 24;
	wire [74:0] S219_176S3_sh = S219_176S3 << 32;
	wire [50:0] S235_192S3_sh = S235_192S3 << 8;
	wire [58:0] S243_200S3_sh = S243_200S3 << 16;
	wire [66:0] S251_208S3_sh = S251_208S3 << 24;
	wire [50:0] S267_224S3_sh = S267_224S3 << 8;
	wire [58:0] S275_232S3_sh = S275_232S3 << 16;
	wire [66:0] S283_240S3_sh = S283_240S3 << 24;
	wire [50:0] S299_256S3_sh = S299_256S3 << 8;
	wire [58:0] S307_264S3_sh = S307_264S3 << 16;
	wire [66:0] S315_272S3_sh = S315_272S3 << 24;
	wire [50:0] S331_288S3_sh = S331_288S3 << 8;
	wire [58:0] S339_296S3_sh = S339_296S3 << 16;
	wire [66:0] S347_304S3_sh = S347_304S3 << 24;
	wire [50:0] S363_320S3_sh = S363_320S3 << 8;
	wire [65:0] S378_328S3_sh = S378_328S3 << 16;
	wire [74:0] S387_336S3_sh = S387_336S3 << 24;
	wire [65:0] S418_368S3_sh = S418_368S3 << 16;
	wire [81:0] S434_384S3_sh = S434_384S3 << 32;
	wire [97:0] S450_400S3_sh = S450_400S3 << 48;
	wire [72:0] S489_432S3_sh = S489_432S3 << 16;
	wire [95:0] S511_456S3_sh = S511_456S3 << 40;
	
    reg S3_valid;

    // Cycle 4
    reg [123:0] S123_0S4;
    reg [98:0] S187_88S4, S451_352S4;
    reg [95:0] S511_416S4;
    reg [75:0] S220_144S4, S388_312S4;
    reg [67:0] S252_184S4, S284_216S4, S316_248S4, S348_280S4;
    
    wire [186:0] S187_88S4_sh = S187_88S4 << 88;
    wire [107:0] S252_184S4_sh = S252_184S4 << 40;
    wire [99:0] S316_248S4_sh = S316_248S4 << 32;
    wire [107:0] S388_312S4_sh = S388_312S4 << 32;
    wire [159:0] S511_416S4_sh = S511_416S4 << 64;
    
    reg S4_valid;

    // Cycle 5
    reg [188:0] S188_0S5;
    reg [159:0] S511_352S5;
    reg [108:0] S253_144S5, S389_280S5;
    reg [100:0] S317_216S5;
    
    wire [252:0] S253_144S5_sh = S253_144S5 << 144;
    wire [172:0] S389_280S5_sh = S389_280S5 << 64;

    reg S5_valid;

    // Cycle 6
    reg [254:0] S254_0S6;
    reg [173:0] S390_216S6;
    reg [159:0] S511_352S6;
    
    wire [389:0] S390_216S6_sh = S390_216S6 << 216;

    reg S6_valid;

    // Cycle 7
    reg [391:0] S391_0S7;
    reg [159:0] S511_352S7;
    
    wire [511:0] S511_352S7_sh = S511_352S7 << 352;

    reg S7_valid;

    always @(posedge clock) begin
        if(reset) begin
            P <= 256'b0;
            S1_valid <= 1'b0;
            S2_valid <= 1'b0;
            S3_valid <= 1'b0;
            S4_valid <= 1'b0;
            S5_valid <= 1'b0;
            S6_valid <= 1'b0;
            S7_valid <= 1'b0;
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
            Z8_0S1 <= X[31:16] * Y[71:48];
            Z8_1S1 <= X[79:64] * Y[23:0];
            Z9_0S1 <= X[63:48] * Y[47:24];
            Z9_1S1 <= X[15:0] * Y[95:72];
            Z10_0S1 <= X[47:32] * Y[71:48];
            Z10_1S1 <= X[95:80] * Y[23:0];
            Z12_S1 <= X[63:48] * Y[71:48];
            Z14_S1 <= X[79:64] * Y[71:48];
            Z15_S1 <= X[63:48] * Y[95:72];
            Z16_S1 <= X[95:80] * Y[71:48];
            Z17_S1 <= X[79:64] * Y[95:72];
            Z19_S1 <= X[95:80] * Y[95:72];
            Z20_0S1 <= X[79:64] * Y[119:96];
            Z20_1S1 <= X[127:112] * Y[71:48];
            Z21_0S1 <= X[111:96] * Y[95:72];
            Z21_1S1 <= X[63:48] * Y[143:120];
            Z22_0S1 <= X[95:80] * Y[119:96];
            Z22_1S1 <= X[143:128] * Y[71:48];
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
            Z38_0S1 <= X[175:160] * Y[167:144];
            Z38_1S1 <= X[127:112] * Y[215:192];
            Z39_0S1 <= X[159:144] * Y[191:168];
            Z39_1S1 <= X[207:192] * Y[143:120];
            Z40_0S1 <= X[191:176] * Y[167:144];
            Z40_1S1 <= X[143:128] * Y[215:192];
            Z41_S1 <= X[175:160] * Y[191:168];
            Z43_S1 <= X[191:176] * Y[191:168];
            Z44_S1 <= X[175:160] * Y[215:192];
            Z45_S1 <= X[207:192] * Y[191:168];
            Z46_S1 <= X[191:176] * Y[215:192];
            Z48_S1 <= X[207:192] * Y[215:192];
            Z50_0S1 <= X[223:208] * Y[215:192];
            Z50_1S1 <= X[175:160] * Y[255:240]; // 32 BITS
            Z51_0S1 <= X[207:192] * Y[239:216];
            Z51_1S1 <= X[255:240] * Y[191:168];
            Z52_0S1 <= X[239:224] * Y[215:192];
            Z52_1S1 <= X[191:176] * Y[255:240]; // 32 BITS
            Z53_S1 <= X[223:208] * Y[239:216];
            Z55_S1 <= X[239:224] * Y[239:216];
            Z56_S1 <= X[223:208] * Y[255:240]; // 32 BITS
            Z57_S1 <= X[255:240] * Y[239:216];
            Z58_S1 <= X[239:224] * Y[255:240]; // 32 BITS
            Z60_S1 <= X[255:240] * Y[255:240]; // 32 BITS

            diffX0_6S1 <= $signed({1'b0, X[15:0]}) - $signed({1'b0, X[63:48]});
            diffX0_12S1 <= $signed({1'b0, X[15:0]}) - $signed({1'b0, X[111:96]});
            diffX0_18S1 <= $signed({1'b0, X[15:0]}) - $signed({1'b0, X[159:144]});
            diffX0_24S1 <= $signed({1'b0, X[15:0]}) - $signed({1'b0, X[207:192]});
            diffX0_30S1 <= $signed({1'b0, X[15:0]}) - $signed({1'b0, X[255:240]});
            diffX2_8S1 <= $signed({1'b0, X[31:16]}) - $signed({1'b0, X[79:64]});
            diffX2_14S1 <= $signed({1'b0, X[31:16]}) - $signed({1'b0, X[127:112]});
            diffX2_20S1 <= $signed({1'b0, X[31:16]}) - $signed({1'b0, X[175:160]});
            diffX2_26S1 <= $signed({1'b0, X[31:16]}) - $signed({1'b0, X[223:208]});
            diffX4_10S1 <= $signed({1'b0, X[47:32]}) - $signed({1'b0, X[95:80]});
            diffX4_16S1 <= $signed({1'b0, X[47:32]}) - $signed({1'b0, X[143:128]});
            diffX4_22S1 <= $signed({1'b0, X[47:32]}) - $signed({1'b0, X[191:176]});
            diffX4_28S1 <= $signed({1'b0, X[47:32]}) - $signed({1'b0, X[239:224]});
            diffX6_12S1 <= $signed({1'b0, X[63:48]}) - $signed({1'b0, X[111:96]});
            diffX6_18S1 <= $signed({1'b0, X[63:48]}) - $signed({1'b0, X[159:144]});
            diffX6_24S1 <= $signed({1'b0, X[63:48]}) - $signed({1'b0, X[207:192]});
            diffX6_30S1 <= $signed({1'b0, X[63:48]}) - $signed({1'b0, X[255:240]});
            diffX8_14S1 <= $signed({1'b0, X[79:64]}) - $signed({1'b0, X[127:112]});
            diffX8_20S1 <= $signed({1'b0, X[79:64]}) - $signed({1'b0, X[175:160]});
            diffX8_26S1 <= $signed({1'b0, X[79:64]}) - $signed({1'b0, X[223:208]});
            diffX10_16S1 <= $signed({1'b0, X[95:80]}) - $signed({1'b0, X[143:128]});
            diffX10_22S1 <= $signed({1'b0, X[95:80]}) - $signed({1'b0, X[191:176]});
            diffX10_28S1 <= $signed({1'b0, X[95:80]}) - $signed({1'b0, X[239:224]});
            diffX12_18S1 <= $signed({1'b0, X[111:96]}) - $signed({1'b0, X[159:144]});
            diffX12_24S1 <= $signed({1'b0, X[111:96]}) - $signed({1'b0, X[207:192]});
            diffX12_30S1 <= $signed({1'b0, X[111:96]}) - $signed({1'b0, X[255:240]});
            diffX14_20S1 <= $signed({1'b0, X[127:112]}) - $signed({1'b0, X[175:160]});
            diffX14_26S1 <= $signed({1'b0, X[127:112]}) - $signed({1'b0, X[223:208]});
            diffX16_22S1 <= $signed({1'b0, X[143:128]}) - $signed({1'b0, X[191:176]});
            diffX16_28S1 <= $signed({1'b0, X[143:128]}) - $signed({1'b0, X[239:224]});
            diffX18_24S1 <= $signed({1'b0, X[159:144]}) - $signed({1'b0, X[207:192]});
            diffX18_30S1 <= $signed({1'b0, X[159:144]}) - $signed({1'b0, X[255:240]});
            diffX20_26S1 <= $signed({1'b0, X[175:160]}) - $signed({1'b0, X[223:208]});
            diffX22_28S1 <= $signed({1'b0, X[191:176]}) - $signed({1'b0, X[239:224]});
            diffX24_30S1 <= $signed({1'b0, X[207:192]}) - $signed({1'b0, X[255:240]});

            diffY6_0S1 <= $signed({1'b0, Y[71:48]}) - $signed({1'b0, Y[23:0]});
            diffY9_3S1 <= $signed({1'b0, Y[95:72]}) - $signed({1'b0, Y[47:24]});
            diffY12_0S1 <= $signed({1'b0, Y[119:96]}) - $signed({1'b0, Y[23:0]});
            diffY12_6S1 <= $signed({1'b0, Y[119:96]}) - $signed({1'b0, Y[71:48]});
            diffY15_3S1 <= $signed({1'b0, Y[143:120]}) - $signed({1'b0, Y[47:24]});
            diffY15_9S1 <= $signed({1'b0, Y[143:120]}) - $signed({1'b0, Y[95:72]});
            diffY18_0S1 <= $signed({1'b0, Y[167:144]}) - $signed({1'b0, Y[23:0]});
            diffY18_6S1 <= $signed({1'b0, Y[167:144]}) - $signed({1'b0, Y[71:48]});
            diffY18_12S1 <= $signed({1'b0, Y[167:144]}) - $signed({1'b0, Y[119:96]});
            diffY21_3S1 <= $signed({1'b0, Y[191:168]}) - $signed({1'b0, Y[47:24]});
            diffY21_9S1 <= $signed({1'b0, Y[191:168]}) - $signed({1'b0, Y[95:72]});
            diffY21_15S1 <= $signed({1'b0, Y[191:168]}) - $signed({1'b0, Y[143:120]});
            diffY24_0S1 <= $signed({1'b0, Y[215:192]}) - $signed({1'b0, Y[23:0]});
            diffY24_6S1 <= $signed({1'b0, Y[215:192]}) - $signed({1'b0, Y[71:48]});
            diffY24_12S1 <= $signed({1'b0, Y[215:192]}) - $signed({1'b0, Y[119:96]});
            diffY24_18S1 <= $signed({1'b0, Y[215:192]}) - $signed({1'b0, Y[167:144]});
            diffY27_3S1 <= $signed({1'b0, Y[239:216]}) - $signed({1'b0, Y[47:24]});
            diffY27_9S1 <= $signed({1'b0, Y[239:216]}) - $signed({1'b0, Y[95:72]});
            diffY27_15S1 <= $signed({1'b0, Y[239:216]}) - $signed({1'b0, Y[143:120]});
            diffY27_21S1 <= $signed({1'b0, Y[239:216]}) - $signed({1'b0, Y[191:168]});
            diffY30_0S1 <= $signed({1'b0, Y[255:240]}) - $signed({1'b0, Y[23:0]}); 
            diffY30_6S1 <= $signed({1'b0, Y[255:240]}) - $signed({1'b0, Y[71:48]});
            diffY30_12S1 <= $signed({1'b0, Y[255:240]}) - $signed({1'b0, Y[119:96]});
            diffY30_18S1 <= $signed({1'b0, Y[255:240]}) - $signed({1'b0, Y[167:144]});
            diffY30_24S1 <= $signed({1'b0, Y[255:240]}) - $signed({1'b0, Y[215:192]});

            S1_valid <= in_valid;

            // Cycle 2

            Z0_S2 <= Z0_S1;
            Z2_S2 <= Z2_S1;
            Z3_S2 <= Z3_S1;
            Z4_S2 <= Z4_S1;
            Z5_S2 <= Z5_S1;
            Z7_S2 <= Z7_S1;
            Z8_S2 <= Z8_0S1;
            Z9_S2 <= Z9_0S1;
            Z10_S2 <= Z10_0S1;
            Z12_S2 <= Z12_S1;
            Z14_S2 <= Z14_S1;
            Z15_S2 <= Z15_S1;
            Z16_S2 <= Z16_S1;
            Z17_S2 <= Z17_S1;
            Z19_S2 <= Z19_S1;
            Z20_S2 <= Z20_0S1;
            Z21_S2 <= Z21_0S1;
            Z22_S2 <= Z22_0S1;
            Z24_S2 <= Z24_S1;
            Z26_S2 <= Z26_S1;
            Z27_S2 <= Z27_S1;
            Z28_S2 <= Z28_S1;
            Z29_S2 <= Z29_S1;
            Z31_S2 <= Z31_S1;
            Z32_S2 <= Z32_S1;
            Z33_S2 <= Z33_S1;
            Z34_S2 <= Z34_S1;
            Z36_S2 <= Z36_S1;
            Z38_S2 <= Z38_0S1;
            Z39_S2 <= Z39_0S1;
            Z40_S2 <= Z40_0S1;
            Z41_S2 <= Z41_S1;
            Z43_S2 <= Z43_S1;
            Z44_S2 <= Z44_S1;
            Z45_S2 <= Z45_S1;
            Z46_S2 <= Z46_S1;
            Z48_S2 <= Z48_S1;
            Z50_S2 <= Z50_0S1;
            Z51_S2 <= Z51_0S1;
            Z52_S2 <= Z52_0S1;
            Z53_S2 <= Z53_S1;
            Z55_S2 <= Z55_S1;
            Z56_S2 <= Z56_S1;
            Z57_S2 <= Z57_S1;
            Z58_S2 <= Z58_S1;
            Z60_S2 <= Z60_S1;

            M6_S2 <= $signed(diffX0_6S1) * $signed(diffY6_0S1);
            M11_S2 <= $signed(diffX2_8S1) * $signed(diffY9_3S1);
            M12_S2 <= $signed(diffX0_12S1) * $signed(diffY12_0S1);
            M13_S2 <= $signed(diffX4_10S1) * $signed(diffY9_3S1);
            M14_S2 <= $signed(diffX2_14S1) * $signed(diffY12_0S1);
            M15_S2 <= $signed(diffX0_12S1) * $signed(diffY15_3S1);
            M16_S2 <= $signed(diffX4_16S1) * $signed(diffY12_0S1);
            M17_S2 <= $signed(diffX2_14S1) * $signed(diffY15_3S1);
            M18_0S2 <= $signed(diffX6_12S1) * $signed(diffY12_6S1);
            M18_1S2 <= $signed(diffX0_18S1) * $signed(diffY18_0S1);
            M19_S2 <= $signed(diffX4_16S1) * $signed(diffY15_3S1);
            M20_S2 <= $signed(diffX2_20S1) * $signed(diffY18_0S1);
            M21_S2 <= $signed(diffX0_18S1) * $signed(diffY21_3S1);
            M22_S2 <= $signed(diffX4_22S1) * $signed(diffY18_0S1);
            M23_0S2 <= $signed(diffX8_14S1) * $signed(diffY15_9S1);
            M23_1S2 <= $signed(diffX2_20S1) * $signed(diffY21_3S1);
            M24_0S2 <= $signed(diffX0_24S1) * $signed(diffY24_0S1);
            M24_1S2 <= $signed(diffX6_18S1) * $signed(diffY18_6S1);
            M25_0S2 <= $signed(diffX10_16S1) * $signed(diffY15_9S1);
            M25_1S2 <= $signed(diffX4_22S1) * $signed(diffY21_3S1);
            M26_0S2 <= $signed(diffX2_26S1) * $signed(diffY24_0S1);
            M26_1S2 <= $signed(diffX8_20S1) * $signed(diffY18_6S1);
            M27_0S2 <= $signed(diffX0_24S1) * $signed(diffY27_3S1);
            M27_1S2 <= $signed(diffX6_18S1) * $signed(diffY21_9S1);
            M28_0S2 <= $signed(diffX4_28S1) * $signed(diffY24_0S1);
            M28_1S2 <= $signed(diffX10_22S1) * $signed(diffY18_6S1);
            M29_0S2 <= $signed(diffX2_26S1) * $signed(diffY27_3S1);
            M29_1S2 <= $signed(diffX8_20S1) * $signed(diffY21_9S1);
            M30_0S2 <= $signed(diffX0_30S1) * $signed(diffY30_0S1);
            M30_1S2 <= $signed(diffX6_24S1) * $signed(diffY24_6S1);
            M30_2S2 <= $signed(diffX12_18S1) * $signed(diffY18_12S1);
            M31_0S2 <= $signed(diffX4_28S1) * $signed(diffY27_3S1);
            M31_1S2 <= $signed(diffX10_22S1) * $signed(diffY21_9S1);
            M32_0S2 <= $signed(diffX8_20S1) * $signed(diffY24_12S1);
            M32_1S2 <= $signed(diffX2_26S1) * $signed(diffY30_6S1);
            M33_0S2 <= $signed(diffX6_30S1) * $signed(diffY27_3S1);
            M33_1S2 <= $signed(diffX12_24S1) * $signed(diffY21_9S1);
            M34_0S2 <= $signed(diffX4_28S1) * $signed(diffY30_6S1);
            M34_1S2 <= $signed(diffX10_22S1) * $signed(diffY24_12S1);
            M35_0S2 <= $signed(diffX14_20S1) * $signed(diffY21_15S1);
            M35_1S2 <= $signed(diffX8_26S1) * $signed(diffY27_9S1);
            M36_0S2 <= $signed(diffX6_30S1) * $signed(diffY30_6S1);
            M36_1S2 <= $signed(diffX12_24S1) * $signed(diffY24_12S1);
            M37_0S2 <= $signed(diffX16_22S1) * $signed(diffY21_15S1);
            M37_1S2 <= $signed(diffX10_28S1) * $signed(diffY27_9S1);
            M38_S2 <= $signed(diffX8_26S1) * $signed(diffY30_12S1);
            M39_S2 <= $signed(diffX12_30S1) * $signed(diffY27_9S1);
            M40_S2 <= $signed(diffX10_28S1) * $signed(diffY30_12S1);
            M41_S2 <= $signed(diffX14_26S1) * $signed(diffY27_15S1);
            M42_0S2 <= $signed(diffX18_24S1) * $signed(diffY24_18S1);
            M42_1S2 <= $signed(diffX12_30S1) * $signed(diffY30_12S1);
            M43_S2 <= $signed(diffX16_28S1) * $signed(diffY27_15S1);
            M44_S2 <= $signed(diffX14_26S1) * $signed(diffY30_18S1);
            M45_S2 <= $signed(diffX18_30S1) * $signed(diffY27_15S1);
            M46_S2 <= $signed(diffX16_28S1) * $signed(diffY30_18S1);
            M47_S2 <= $signed(diffX20_26S1) * $signed(diffY27_21S1);
            M48_S2 <= $signed(diffX18_30S1) * $signed(diffY30_18S1);
            M49_S2 <= $signed(diffX22_28S1) * $signed(diffY27_21S1);
            M54_S2 <= $signed(diffX24_30S1) * $signed(diffY30_24S1);

            C8_S2 <= Z8_0S1 + Z8_1S1;
            C9_S2 <= Z9_0S1 + Z9_1S1;
            C10_S2 <= Z10_0S1 + Z10_1S1;
            C20_S2 <= Z20_0S1 + Z20_1S1;
            C21_S2 <= Z21_0S1 + Z21_1S1;
            C22_S2 <= Z22_0S1 + Z22_1S1;
            C38_S2 <= Z38_0S1 + Z38_1S1;
            C39_S2 <= Z39_0S1 + Z39_1S1;
            C40_S2 <= Z40_0S1 + Z40_1S1;
            C50_S2 <= Z50_0S1 + Z50_1S1;
            C51_S2 <= Z51_0S1 + Z51_1S1;
            C52_S2 <= Z52_0S1 + Z52_1S1;

            S2_valid <= S1_valid;
            
            // Cycle 3
            S80_0S3 <= {Z5_S2, Z0_S2} + {24'b0, Z2_S2_sh} + {16'b0, Z3_S2_sh} + {8'b0, Z4_S2_sh};
            S106_48S3 <= {16'b0, Z6_S3} + {9'b0, Z7_S2_sh} + C8_S2_sh;
            S122_72S3 <= {8'b0, C9_S2} + C10_S2_sh;
            S139_88S3 <= {9'b0, Z11_S3} + Z12_S3_sh;
            S155_104S3 <= {9'b0, Z13_S3} + Z14_S3_sh;
            S171_120S3 <= {8'b0, Z15_S3} + Z16_S3_sh;
            S186_136S3 <= {7'b0, Z17_S3} + Z18_0S3_sh;
            S195_144S3 <= {9'b0, Z18_1S3} + Z19_S3_sh;
            S203_160S3 <= Z20_S3;
            S211_168S3 <= Z21_S3;
            S219_176S3 <= Z22_S3;
            S227_184S3 <= Z23_S3;
            S235_192S3 <= Z24_S3;
            S243_200S3 <= Z25_S3;
            S251_208S3 <= Z26_S3;
            S259_216S3 <= Z27_S3;
            S267_224S3 <= Z28_S3;
            S275_232S3 <= Z29_S3;
            S283_240S3 <= Z30_S3;
            S291_248S3 <= Z31_S3;
            S299_256S3 <= Z32_S3;
            S307_264S3 <= Z33_S3;
            S315_272S3 <= Z34_S3;
            S323_280S3 <= Z35_S3;
            S331_288S3 <= Z36_S3;
            S339_296S3 <= Z37_S3;
            S347_304S3 <= Z38_S3;
            S355_312S3 <= Z39_S3;
            S363_320S3 <= Z40_S3;
            S378_328S3 <= {7'b0, Z41_S3} + Z42_0S3_sh;
            S387_336S3 <= {9'b0, Z42_1S3} + Z43_S3_sh;
            S403_352S3 <= {8'b0, Z44_S3} + Z45_S3_sh;
            S418_368S3 <= {7'b0, Z46_S3} + Z47_S3_sh;
            S434_384S3 <= {7'b0, Z48_S3} + Z49_S3_sh;
            S450_400S3 <= {8'b0, C50_S2} + C51_S2_sh;
            S465_416S3 <= {7'b0, C52_S2} + Z53_S2_sh;
            S489_432S3 <= {7'b0, Z54_S3} + Z55_S2_sh + Z56_S2_sh;
            S511_456S3 <= {16'b0, Z57_S2} + {16'b0, Z58_S2_sh} + Z60_S2_sh;

            S3_valid <= S2_valid;

            // Cycle 4
            S123_0S4 <= {41'b0, S80_0S3} + {16'b0, S106_48S3_sh} + S122_72S3_sh;
            S187_88S4 <= {47'b0, S139_88S3} + {31'b0, S155_104S3_sh} + {15'b0, S171_120S3_sh} + S186_136S3_sh;
            S220_144S4 <= {24'b0, S195_144S3} + {16'b0, S203_160S3_sh} + {8'b0, S211_168S3_sh} + S219_176S3_sh;
            S252_184S4 <= {24'b0, S227_184S3} + {16'b0, S235_192S3_sh} + {8'b0, S243_200S3_sh} + S251_208S3_sh;
            S284_216S4 <= {24'b0, S259_216S3} + {16'b0, S267_224S3_sh} + {8'b0, S275_232S3_sh} + S283_240S3_sh;
            S316_248S4 <= {24'b0, S291_248S3} + {16'b0, S299_256S3_sh} + {8'b0, S307_264S3_sh} + S315_272S3_sh;
            S348_280S4 <= {24'b0, S323_280S3} + {16'b0, S331_288S3_sh} + {8'b0, S339_296S3_sh} + S347_304S3_sh;
            S388_312S4 <= {32'b0, S355_312S3} + {24'b0, S363_320S3_sh} + {9'b0, S378_328S3_sh} + S387_336S3_sh;
            S451_352S4 <= {47'b0, S403_352S3} + {32'b0, S418_368S3_sh} + {16'b0, S434_384S3_sh} + S450_400S3_sh;
            S511_416S4 <= {46'b0, S465_416S3} + {22'b0, S489_432S3_sh} + S511_456S3_sh;

            S4_valid <= S3_valid;

            // Cycle 5
            S188_0S5 <= {63'b0, S123_0S4} + S187_88S4_sh;
            S253_144S5 <= {32'b0, S220_144S4} + S252_184S4_sh;
            S317_216S5 <= {32'b0, S284_216S4} + S316_248S4_sh;
            S389_280S5 <= {40'b0, S348_280S4} + S388_312S4_sh;
            S511_352S5 <= {60'b0, S451_352S4} + S511_416S4_sh;

            S5_valid <= S4_valid;

            // Cycle 6
            S254_0S6 <= {64'b0, S188_0S5} + S253_144S5_sh;
            S390_216S6 <= {72'b0, S317_216S5} + S389_280S5_sh;
            S511_352S6 <= S511_352S5;

            S6_valid <= S5_valid;

            // Cycle 7
            S391_0S7 <= {145'b0, S254_0S6} + S390_216S6_sh;
            S511_352S7 <= S511_352S6;

            S7_valid <= S6_valid;

            // Cycle 8
            P <= {119'b0, S391_0S7} + S511_352S7_sh;

            out_valid <= S7_valid;
        end
    end

endmodule