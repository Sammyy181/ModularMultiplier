`timescale 1ns / 1ps
`include "../Verilog Files/fastKaratsuba.v"

module fastKaratsuba_tb();

    reg         clock;
    reg         reset;
    reg         in_valid;
    reg [255:0] X;
    reg [255:0] Y;

    wire [511:0] P;
    wire         out_valid;

    wire [39:0] Z0_S1, Z2_S1, Z3_S1, Z4_S1, Z5_S1, Z7_S1, Z8_S1, Z9_S1,
                Z10_S1, Z12_S1, Z14_S1, Z15_S1, Z16_S1, Z17_S1, Z19_S1,
                Z20_S1, Z21_S1, Z22_S1, Z24_S1, Z26_S1, Z27_S1, Z28_S1, Z29_S1,
                Z31_S1, Z32_S1, Z33_S1, Z34_S1, Z36_S1, Z38_S1, Z39_S1,
                Z40_S1, Z41_S1, Z43_S1, Z44_S1, Z45_S1, Z46_S1, Z48_S1,
                Z50_S1, Z51_S1, Z52_S1, Z53_S1, Z55_S1, Z57_S1;
    wire [31:0] Z56_S1, Z58_S1, Z60_S1;
    wire [42:0] M6_S1, M8_S1, M9_S1, M10_S1, M11_S1, M12_S1, M13_S1, M14_S1, M15_S1, M16_S1, M17_S1, M18_0S1, M18_1S1, M19_S1,
                M20_0S1, M20_1S1, M21_0S1, M21_1S1, M22_0S1, M22_1S1, M23_0S1, M23_1S1, M24_0S1, M24_1S1, M25_0S1, M25_1S1,
                M26_0S1, M26_1S1, M27_0S1, M27_1S1, M28_0S1, M28_1S1, M29_0S1, M29_1S1, M30_0S1, M30_1S1, M30_2S1, M31_0S1,
                M31_1S1, M32_0S1, M32_1S1, M33_0S1, M33_1S1, M34_0S1, M34_1S1, M35_0S1, M35_1S1, M36_0S1, M36_1S1, M37_0S1,
                M37_1S1, M38_0S1, M38_1S1, M39_0S1, M39_1S1, M40_0S1, M40_1S1, M41_S1, M42_0S1, M42_1S1, M43_S1, M44_S1, M45_S1,
                M46_S1, M47_S1, M48_S1, M49_S1, M50_S1, M51_S1, M52_S1, M54_S1;

    fastKaratsuba dut (
        .clock(clock),
        .reset(reset),
        .in_valid(in_valid),
        .X(X),
        .Y(Y),
        .P(P),
        .out_valid(out_valid),

        .Z0_S1(Z0_S1), .Z2_S1(Z2_S1), .Z3_S1(Z3_S1), .Z4_S1(Z4_S1),
        .Z5_S1(Z5_S1), .Z7_S1(Z7_S1), .Z8_S1(Z8_S1), .Z9_S1(Z9_S1),
        .Z10_S1(Z10_S1), .Z12_S1(Z12_S1), .Z14_S1(Z14_S1), .Z15_S1(Z15_S1),
        .Z16_S1(Z16_S1), .Z17_S1(Z17_S1), .Z19_S1(Z19_S1),
        .Z20_S1(Z20_S1), .Z21_S1(Z21_S1), .Z22_S1(Z22_S1),
        .Z24_S1(Z24_S1), .Z26_S1(Z26_S1), .Z27_S1(Z27_S1),
        .Z28_S1(Z28_S1), .Z29_S1(Z29_S1),
        .Z31_S1(Z31_S1), .Z32_S1(Z32_S1), .Z33_S1(Z33_S1),
        .Z34_S1(Z34_S1), .Z36_S1(Z36_S1), .Z38_S1(Z38_S1),
        .Z39_S1(Z39_S1), .Z40_S1(Z40_S1), .Z41_S1(Z41_S1),
        .Z43_S1(Z43_S1), .Z44_S1(Z44_S1), .Z45_S1(Z45_S1),
        .Z46_S1(Z46_S1), .Z48_S1(Z48_S1),
        .Z50_S1(Z50_S1), .Z51_S1(Z51_S1), .Z52_S1(Z52_S1),
        .Z53_S1(Z53_S1), .Z55_S1(Z55_S1), .Z56_S1(Z56_S1),
        .Z57_S1(Z57_S1), .Z58_S1(Z58_S1), .Z60_S1(Z60_S1),

        .M6_S1(M6_S1), .M8_S1(M8_S1), .M9_S1(M9_S1), .M10_S1(M10_S1),
        .M11_S1(M11_S1), .M12_S1(M12_S1), .M13_S1(M13_S1), .M14_S1(M14_S1),
        .M15_S1(M15_S1), .M16_S1(M16_S1), .M17_S1(M17_S1), .M18_0S1(M18_0S1),
        .M18_1S1(M18_1S1), .M19_S1(M19_S1), .M20_0S1(M20_0S1), .M20_1S1(M20_1S1),
        .M21_0S1(M21_0S1), .M21_1S1(M21_1S1), .M22_0S1(M22_0S1), .M22_1S1(M22_1S1),
        .M23_0S1(M23_0S1), .M23_1S1(M23_1S1), .M24_0S1(M24_0S1), .M24_1S1(M24_1S1),
        .M25_0S1(M25_0S1), .M25_1S1(M25_1S1), .M26_0S1(M26_0S1), .M26_1S1(M26_1S1),
        .M27_0S1(M27_0S1), .M27_1S1(M27_1S1), .M28_0S1(M28_0S1), .M28_1S1(M28_1S1),
        .M29_0S1(M29_0S1), .M29_1S1(M29_1S1), .M30_0S1(M30_0S1), .M30_1S1(M30_1S1),
        .M30_2S1(M30_2S1), .M31_0S1(M31_0S1), .M31_1S1(M31_1S1), .M32_0S1(M32_0S1),
        .M32_1S1(M32_1S1), .M33_0S1(M33_0S1), .M33_1S1(M33_1S1), .M34_0S1(M34_0S1),
        .M34_1S1(M34_1S1), .M35_0S1(M35_0S1), .M35_1S1(M35_1S1), .M36_0S1(M36_0S1),
        .M36_1S1(M36_1S1), .M37_0S1(M37_0S1), .M37_1S1(M37_1S1), .M38_0S1(M38_0S1),
        .M38_1S1(M38_1S1), .M39_0S1(M39_0S1), .M39_1S1(M39_1S1), .M40_0S1(M40_0S1),
        .M40_1S1(M40_1S1), .M41_S1(M41_S1), .M42_0S1(M42_0S1), .M42_1S1(M42_1S1),
        .M43_S1(M43_S1), .M44_S1(M44_S1), .M45_S1(M45_S1), .M46_S1(M46_S1),
        .M47_S1(M47_S1), .M48_S1(M48_S1), .M49_S1(M49_S1), .M50_S1(M50_S1),
        .M51_S1(M51_S1), .M52_S1(M52_S1), .M54_S1(M54_S1)
    );

    // clock
    always #5 clock = ~clock;

    initial begin
        
        clock = 0;
        reset = 1;
        in_valid = 0;
        X = 0;
        Y = 0;

        #20;
        reset = 0;

        // Apply input
        @(posedge clock);
        X = 2**256 - 1;
        Y = 2**256 - 1;
        in_valid = 1;

        #50
        // --------------------------------------------------
        // Display results
        // --------------------------------------------------
        $display("====================================");
        $display("X = %h", X);
        $display("Y = %h", Y);
        $display("P = %h", P);
        $display("Expected = %h", X * Y);
        $display("====================================");

        $display("Z0_S1  = %0b", Z0_S1);
        $display("Z2_S1  = %0b", Z2_S1);
        $display("Z3_S1  = %0b", Z3_S1);
        $display("Z4_S1  = %0b", Z4_S1);
        $display("Z5_S1  = %0b", Z5_S1);
        $display("Z7_S1  = %0b", Z7_S1);
        $display("Z8_S1  = %0b", Z8_S1);
        $display("Z9_S1  = %0b", Z9_S1);
        $display("Z10_S1 = %0b", Z10_S1);
        $display("Z12_S1 = %0b", Z12_S1);
        $display("Z14_S1 = %0b", Z14_S1);
        $display("Z15_S1 = %0b", Z15_S1);
        $display("Z16_S1 = %0b", Z16_S1);
        $display("Z17_S1 = %0b", Z17_S1);
        $display("Z19_S1 = %0b", Z19_S1);

        $display("Z20_S1 = %0b", Z20_S1);
        $display("Z21_S1 = %0b", Z21_S1);
        $display("Z22_S1 = %0b", Z22_S1);
        $display("Z24_S1 = %0b", Z24_S1);
        $display("Z26_S1 = %0b", Z26_S1);
        $display("Z27_S1 = %0b", Z27_S1);
        $display("Z28_S1 = %0b", Z28_S1);
        $display("Z29_S1 = %0b", Z29_S1);

        $display("Z31_S1 = %0b", Z31_S1);
        $display("Z32_S1 = %0b", Z32_S1);
        $display("Z33_S1 = %0b", Z33_S1);
        $display("Z34_S1 = %0b", Z34_S1);
        $display("Z36_S1 = %0b", Z36_S1);
        $display("Z38_S1 = %0b", Z38_S1);
        $display("Z39_S1 = %0b", Z39_S1);

        $display("Z40_S1 = %0b", Z40_S1);
        $display("Z41_S1 = %0b", Z41_S1);
        $display("Z43_S1 = %0b", Z43_S1);
        $display("Z44_S1 = %0b", Z44_S1);
        $display("Z45_S1 = %0b", Z45_S1);
        $display("Z46_S1 = %0b", Z46_S1);
        $display("Z48_S1 = %0b", Z48_S1);

        $display("Z50_S1 = %0b", Z50_S1);
        $display("Z51_S1 = %0b", Z51_S1);
        $display("Z52_S1 = %0b", Z52_S1);
        $display("Z53_S1 = %0b", Z53_S1);
        $display("Z55_S1 = %0b", Z55_S1);
        $display("Z56_S1 = %0b", Z56_S1);
        $display("Z57_S1 = %0b", Z57_S1);
        $display("Z58_S1 = %0b", Z58_S1);
        $display("Z60_S1 = %0b", Z60_S1);

        $display("M6_S1   = %0b", M6_S1);
        $display("M8_S1   = %0b", M8_S1);
        $display("M9_S1   = %0b", M9_S1);
        $display("M10_S1  = %0b", M10_S1);
        $display("M11_S1  = %0b", M11_S1);
        $display("M12_S1  = %0b", M12_S1);
        $display("M13_S1  = %0b", M13_S1);
        $display("M14_S1  = %0b", M14_S1);
        $display("M15_S1  = %0b", M15_S1);
        $display("M16_S1  = %0b", M16_S1);
        $display("M17_S1  = %0b", M17_S1);
        $display("M18_0S1 = %0b", M18_0S1);
        $display("M18_1S1 = %0b", M18_1S1);
        $display("M19_S1  = %0b", M19_S1);

        $display("M20_0S1 = %0b", M20_0S1);
        $display("M20_1S1 = %0b", M20_1S1);
        $display("M21_0S1 = %0b", M21_0S1);
        $display("M21_1S1 = %0b", M21_1S1);
        $display("M22_0S1 = %0b", M22_0S1);
        $display("M22_1S1 = %0b", M22_1S1);
        $display("M23_0S1 = %0b", M23_0S1);
        $display("M23_1S1 = %0b", M23_1S1);
        $display("M24_0S1 = %0b", M24_0S1);
        $display("M24_1S1 = %0b", M24_1S1);
        $display("M25_0S1 = %0b", M25_0S1);
        $display("M25_1S1 = %0b", M25_1S1);

        $display("M26_0S1 = %0b", M26_0S1);
        $display("M26_1S1 = %0b", M26_1S1);
        $display("M27_0S1 = %0b", M27_0S1);
        $display("M27_1S1 = %0b", M27_1S1);
        $display("M28_0S1 = %0b", M28_0S1);
        $display("M28_1S1 = %0b", M28_1S1);
        $display("M29_0S1 = %0b", M29_0S1);
        $display("M29_1S1 = %0b", M29_1S1);
        $display("M30_0S1 = %0b", M30_0S1);
        $display("M30_1S1 = %0b", M30_1S1);
        $display("M30_2S1 = %0b", M30_2S1);
        $display("M31_0S1 = %0b", M31_0S1);
        $display("M31_1S1 = %0b", M31_1S1);

        $display("M32_0S1 = %0b", M32_0S1);
        $display("M32_1S1 = %0b", M32_1S1);
        $display("M33_0S1 = %0b", M33_0S1);
        $display("M33_1S1 = %0b", M33_1S1);
        $display("M34_0S1 = %0b", M34_0S1);
        $display("M34_1S1 = %0b", M34_1S1);
        $display("M35_0S1 = %0b", M35_0S1);
        $display("M35_1S1 = %0b", M35_1S1);
        $display("M36_0S1 = %0b", M36_0S1);
        $display("M36_1S1 = %0b", M36_1S1);
        $display("M37_0S1 = %0b", M37_0S1);
        $display("M37_1S1 = %0b", M37_1S1);

        $display("M38_0S1 = %0b", M38_0S1);
        $display("M38_1S1 = %0b", M38_1S1);
        $display("M39_0S1 = %0b", M39_0S1);
        $display("M39_1S1 = %0b", M39_1S1);
        $display("M40_0S1 = %0b", M40_0S1);
        $display("M40_1S1 = %0b", M40_1S1);
        $display("M41_S1  = %0b", M41_S1);
        $display("M42_0S1 = %0b", M42_0S1);
        $display("M42_1S1 = %0b", M42_1S1);
        $display("M43_S1  = %0b", M43_S1);
        $display("M44_S1  = %0b", M44_S1);
        $display("M45_S1  = %0b", M45_S1);

        $display("M46_S1  = %0b", M46_S1);
        $display("M47_S1  = %0b", M47_S1);
        $display("M48_S1  = %0b", M48_S1);
        $display("M49_S1  = %0b", M49_S1);
        $display("M50_S1  = %0b", M50_S1);
        $display("M51_S1  = %0b", M51_S1);
        $display("M52_S1  = %0b", M52_S1);
        $display("M54_S1  = %0b", M54_S1);

        #20;
        $finish;

    end

endmodule