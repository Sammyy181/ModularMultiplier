`timescale 1ns/1ps

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
    reg [40:0] M6_S1, M8_S1, M9_S1, M10_S1, M11_S1, M12_S1, M13_S1, M14_S1, M18_S1, M20_S1, M24_S1, M26_S1, M27_S1, M29_S1, M30_S1, M31_S1,
                M32_S1, M33_S1, M34_S1, M35_S1, M36_S1, M38_S1;
    reg S1_valid;

    // Cycle 2
    reg S2_valid;

    wire [40:0] Z6_S2, Z8_S2, Z9_S2, Z10_S2, Z11_S2, Z13_S2, Z16_S2, Z19_S2, Z22_S2, Z25_S2, Z28_S2, Z31_S2, Z33_S2, Z34_S2, Z35_S2, Z36_S2, Z38_S2;
    wire [41:0] Z12_S2, Z14_S2, Z15_S2, Z17_S2, Z18_S2, Z20_S2, Z21_S2, Z23_S2, Z24_S2, Z26_S2, Z27_S2, Z29_S2, Z30_S2, Z32_S2;
    
    reg [81:0] S81_0S2;
    reg [71:0] S383_312S2;
    reg [49:0] S98_48S2, S114_64S2, S130_80S2, S314_264S2, S330_280S2, S346_296S2;
    reg [41:0] S138_96S2, S154_112S2, S162_120S2, S178_136S2, S186_144S2, S202_160S2, S210_168S2, S226_184S2, S234_192S2, S250_208S2, S258_216S2, S274_232S2, S282_240S2, S298_256S2;
    reg [40:0] S145_104S2, S169_128S2, S193_152S2, S217_176S2, S241_200S2, S265_224S2, S289_248S2;

    assign Z6_S2 = $signed(M6_S1) + $signed({1'b0, Z0_S1}) + $signed({1'b0, Z12_S1});
    assign Z8_S2 = $signed(M8_S1) + $signed({1'b0, Z2_S1}) + $signed({1'b0, Z14_S1});
    assign Z9_S2 = $signed(M9_S1) + $signed({1'b0, Z15_0S1}) + $signed({1'b0, Z3_S1});
    assign Z10_S2 = $signed(M10_S1) + $signed({1'b0, Z16_0S1}) + $signed({1'b0, Z4_S1});
    assign Z11_S2 = $signed(M11_S1) + $signed({1'b0, Z17_0S1}) + $signed({1'b0, Z5_S1});
    assign Z12_S2 = $signed(M12_S1) + $signed({1'b0, Z12_S1}) + $signed({1'b0, Z0_S1}) + $signed({1'b0, Z24_S1});
    assign Z13_S2 = $signed(M13_S1) + $signed({1'b0, Z19_0S1}) + $signed({1'b0, Z7_S1});
    assign Z14_S2 = $signed(M14_S1) + $signed({1'b0, Z14_S1}) + $signed({1'b0, Z26_S1}) + $signed({1'b0, Z2_S1});
    assign Z15_S2 = $unsigned(Z15_0S1) + $unsigned(Z15_1S1) + $unsigned(Z15_2S1);
    assign Z16_S2 = $unsigned(Z16_0S1) + $unsigned(Z16_1S1);
    assign Z17_S2 = $unsigned(Z17_0S1) + $unsigned(Z17_1S1) + $unsigned(Z17_2S1);
    assign Z18_S2 = $signed(M18_S1) + $signed({1'b0, Z18_S1}) + $signed({1'b0, Z12_S1}) + $signed({1'b0, Z24_S1});
    assign Z19_S2 = $unsigned(Z19_0S1) + $unsigned(Z19_1S1);
    assign Z20_S2 = $signed(M20_S1) + $signed({1'b0, Z20_S1}) + $signed({1'b0, Z26_S1}) + $signed({1'b0, Z14_S1});
    assign Z21_S2 = $unsigned(Z21_0S1) + $unsigned(Z21_1S1) + $unsigned(Z21_2S1);
    assign Z22_S2 = $unsigned(Z22_0S1) + $unsigned(Z22_1S1);
    assign Z23_S2 = $unsigned(Z23_0S1) + $unsigned(Z23_1S1) + $unsigned(Z23_2S1);
    assign Z24_S2 = $signed(M24_S1) + $signed({1'b0, Z24_S1}) + $signed({1'b0, Z30_S1}) + $signed({1'b0, Z18_S1});
    assign Z25_S2 = $unsigned(Z25_0S1) + $unsigned(Z25_1S1);
    assign Z26_S2 = $signed(M26_S1) + $signed({1'b0, Z26_S1}) + $signed({1'b0, Z32_S1}) + $signed({1'b0, Z20_S1});
    assign Z27_S2 = $signed(M27_S1) + $signed({1'b0, Z27_S1}) + $signed({1'b0, Z39_S1}) + $signed({1'b0, Z15_1S1});
    assign Z28_S2 = $unsigned(Z28_0S1) + $unsigned(Z28_1S1);
    assign Z29_S2 = $signed(M29_S1) + $signed({1'b0, Z29_S1}) + $signed({1'b0, Z41_S1}) + $signed({1'b0, Z17_1S1});
    assign Z30_S2 = $signed(M30_S1) + $signed({1'b0, Z30_S1}) + $signed({1'b0, Z42_S1}) + $signed({1'b0, Z18_S1});
    assign Z31_S2 = $signed(M31_S1) + $signed({1'b0, Z37_S1}) + $signed({1'b0, Z25_0S1});
    assign Z32_S2 = $signed(M32_S1) + $signed({1'b0, Z32_S1}) + $signed({1'b0, Z20_S1}) + $signed({1'b0, Z44_S1});
    assign Z33_S2 = $signed(M33_S1) + $signed({1'b0, Z39_S1}) + $signed({1'b0, Z27_S1});
    assign Z34_S2 = $signed(M34_S1) + $signed({1'b0, Z40_S1}) + $signed({1'b0, Z28_0S1});
    assign Z35_S2 = $signed(M35_S1) + $signed({1'b0, Z41_S1}) + $signed({1'b0, Z29_S1});
    assign Z36_S2 = $signed(M36_S1) + $signed({1'b0, Z42_S1}) + $signed({1'b0, Z30_S1});
    assign Z38_S2 = $signed(M38_S1) + $signed({1'b0, Z44_S1}) + $signed({1'b0, Z32_S1});

    // Cycle 3
    reg S3_valid;

    reg [99:0] S99_0S3;
    reg [87:0] S383_296S3;
    reg [74:0] S139_64S3, S331_256S3;
    reg [65:0] S290_224S3;
    reg [58:0] S163_104S3, S187_128S3, S211_152S3, S235_176S3 ,S259_200S3;

    // Cycle 4
    reg S4_valid;

    reg [140:0] S140_0S4;
    reg [127:0] S383_256S4;
    reg [90:0] S291_200S4;
    reg [83:0] S188_104S4, S236_152S4;

    // Cycle 5
    reg S5_valid;

    reg [189:0] S189_0S5;
    reg [139:0] S292_152S5;
    reg [127:0] S383_256S5;

    // Cycle 6
    reg S6_valid;

    reg [231:0] S383_152S6;
    reg [189:0] S189_0S6;

    always @(posedge clock) begin
        if(reset) begin
            out_valid <= 1'b0;
            P <= 384'b0;
            S1_valid <= 1'b0;
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

            M6_S1 <= ($signed({1'b0, X[71:48]}) - $signed({1'b0, X[23:0]})) * ($signed({1'b0, Y[15:0]}) - $signed({1'b0, Y[63:48]}));
            M8_S1 <= ($signed({1'b0, X[71:48]}) - $signed({1'b0, X[23:0]})) * ($signed({1'b0, Y[31:16]}) - $signed({1'b0, Y[79:64]}));
            M9_S1 <= ($signed({1'b0, X[95:72]}) - $signed({1'b0, X[47:24]})) * ($signed({1'b0, Y[15:0]}) - $signed({1'b0, Y[63:48]}));
            M10_S1 <= ($signed({1'b0, X[71:48]}) - $signed({1'b0, X[23:0]})) * ($signed({1'b0, Y[47:32]}) - $signed({1'b0, Y[95:80]}));
            M11_S1 <= ($signed({1'b0, X[95:72]}) - $signed({1'b0, X[47:24]})) * ($signed({1'b0, Y[31:16]}) - $signed({1'b0, Y[79:64]}));
            M12_S1 <= ($signed({1'b0, X[119:96]}) - $signed({1'b0, X[23:0]})) * ($signed({1'b0, Y[15:0]}) - $signed({1'b0, Y[111:96]}));
            M13_S1 <= ($signed({1'b0, X[95:72]}) - $signed({1'b0, X[47:24]})) * ($signed({1'b0, Y[47:32]}) - $signed({1'b0, Y[95:80]}));
            M14_S1 <= ($signed({1'b0, X[119:96]}) - $signed({1'b0, X[23:0]})) * ($signed({1'b0, Y[31:16]}) - $signed({1'b0, Y[127:112]}));
            M18_S1 <= ($signed({1'b0, X[119:96]}) - $signed({1'b0, X[71:48]})) * ($signed({1'b0, Y[63:48]}) - $signed({1'b0, Y[111:96]}));
            M20_S1 <= ($signed({1'b0, X[119:96]}) - $signed({1'b0, X[71:48]})) * ($signed({1'b0, Y[79:64]}) - $signed({1'b0, Y[127:112]}));
            M24_S1 <= ($signed({1'b0, X[215:192]}) - $signed({1'b0, X[167:144]})) * ($signed({1'b0, Y[15:0]}) - $signed({1'b0, Y[63:48]}));
            M26_S1 <= ($signed({1'b0, X[215:192]}) - $signed({1'b0, X[167:144]})) * ($signed({1'b0, Y[31:16]}) - $signed({1'b0, Y[79:64]}));
            M27_S1 <= ($signed({1'b0, X[239:216]}) - $signed({1'b0, X[143:120]})) * ($signed({1'b0, Y[15:0]}) - $signed({1'b0, Y[111:96]}));
            M29_S1 <= ($signed({1'b0, X[239:216]}) - $signed({1'b0, X[143:120]})) * ($signed({1'b0, Y[31:16]}) - $signed({1'b0, Y[127:112]}));
            M30_S1 <= ($signed({1'b0, X[255:240]}) - $signed({1'b0, X[167:144]})) * ($signed({1'b0, Y[15:0]}) - $signed({1'b0, Y[111:96]}));
            M31_S1 <= ($signed({1'b0, X[239:216]}) - $signed({1'b0, X[191:168]})) * ($signed({1'b0, Y[47:32]}) - $signed({1'b0, Y[95:80]}));
            M32_S1 <= ($signed({1'b0, X[255:240]}) - $signed({1'b0, X[167:144]})) * ($signed({1'b0, Y[31:16]}) - $signed({1'b0, Y[127:112]}));
            M33_S1 <= ($signed({1'b0, X[239:216]}) - $signed({1'b0, X[191:168]})) * ($signed({1'b0, Y[63:48]}) - $signed({1'b0, Y[111:96]}));
            M34_S1 <= ($signed({1'b0, X[255:240]}) - $signed({1'b0, X[215:192]})) * ($signed({1'b0, Y[47:32]}) - $signed({1'b0, Y[95:80]}));
            M35_S1 <= ($signed({1'b0, X[239:216]}) - $signed({1'b0, X[191:168]})) * ($signed({1'b0, Y[79:64]}) - $signed({1'b0, Y[127:112]}));
            M36_S1 <= ($signed({1'b0, X[255:240]}) - $signed({1'b0, X[215:192]})) * ($signed({1'b0, Y[63:48]}) - $signed({1'b0, Y[111:96]}));
            M38_S1 <= ($signed({1'b0, X[255:240]}) - $signed({1'b0, X[215:192]})) * ($signed({1'b0, Y[79:64]}) - $signed({1'b0, Y[127:112]}));

            S1_valid <= in_valid;

            // Cycle 2
            S81_0S2 <= {Z5_S1, Z0_S1} + {Z2_S1, 16'b0} + {Z3_S1, 24'b0} + {Z4_S1, 32'b0};
            S98_48S2 <= Z6_S2 + {Z7_S1, 8'b0};
            S114_64S2 <= Z8_S2 + {Z9_S2, 8'b0};
            S130_80S2 <= Z10_S2 + {Z11_S2, 8'b0};
            S138_96S2 <= Z12_S2;
            S145_104S2 <= Z13_S2;
            S154_112S2 <= Z14_S2;
            S162_120S2 <= Z15_S2;
            S169_128S2 <= Z16_S2;
            S178_136S2 <= Z17_S2;
            S186_144S2 <= Z18_S2;
            S193_152S2 <= Z19_S2;
            S202_160S2 <= Z20_S2;
            S210_168S2 <= Z21_S2;
            S217_176S2 <= Z22_S2;
            S226_184S2 <= Z23_S2;
            S234_192S2 <= Z24_S2;
            S241_200S2 <= Z25_S2;
            S250_208S2 <= Z26_S2;
            S258_216S2 <= Z27_S2;
            S265_224S2 <= Z28_S2;
            S274_232S2 <= Z29_S2;
            S282_240S2 <= Z30_S2;
            S289_248S2 <= Z31_S2;
            S298_256S2 <= Z32_S2;
            S314_264S2 <= Z33_S2 + {Z34_S2, 8'b0};
            S330_280S2 <= Z35_S2 + {Z36_S2, 8'b0};
            S346_296S2 <= Z37_S1 + {Z38_S2, 8'b0};
            S383_312S2 <= {Z44_S1, Z39_S1} + {Z40_S1, 8'b0} + {Z41_S1, 16'b0} + {Z42_S1, 24'b0};

            S2_valid <= S1_valid;

            // Cycle 3
            S99_0S3 <= S81_0S2 + {S98_48S2, 48'b0};
            S139_64S3 <= S114_64S2 + {S130_80S2, 16'b0} + {S138_96S2, 32'b0};
            S163_104S3 <= S145_104S2 + {S154_112S2, 8'b0} + {S162_120S2, 16'b0};
            S187_128S3 <= S169_128S2 + {S178_136S2, 8'b0} + {S186_144S2, 16'b0};
            S211_152S3 <= S193_152S2 + {S202_160S2, 8'b0} + {S210_168S2, 16'b0};
            S235_176S3 <= S217_176S2 + {S226_184S2, 8'b0} + {S234_192S2, 16'b0};
            S259_200S3 <= S241_200S2 + {S250_208S2, 8'b0} + {S258_216S2, 16'b0};
            S290_224S3 <= S265_224S2 + {S274_232S2, 8'b0} + {S282_240S2, 16'b0} + {S289_248S2, 24'b0};
            S331_256S3 <= S298_256S2 + {S314_264S2, 8'b0} + {S330_280S2, 24'b0};
            S383_296S3 <= S346_296S2 + {S383_312S2, 16'b0};

            S3_valid <= S2_valid;

            // Cycle 4
            S140_0S4 <= S99_0S3 + {S139_64S3, 64'b0};
            S188_104S4 <= S163_104S3 + {S187_128S3, 24'b0};
            S236_152S4 <= S211_152S3 + {S235_176S3, 24'b0};
            S291_200S4 <= S259_200S3 + {S290_224S3, 24'b0};
            S383_256S4 <= S331_256S3 + {S383_296S3, 40'b0};

            S4_valid <= S3_valid;

            // Cycle 5
            S189_0S5 <= S140_0S4 + {S188_104S4, 104'b0};
            S292_152S5 <= S236_152S4 + {S291_200S4, 48'b0};
            S383_256S5 <= S383_256S4;

            S5_valid <= S4_valid;

            // Cycle 6
            S189_0S6 <= S189_0S5;
            S383_152S6 <= S292_152S5 + {S383_256S5, 104'b0};

            S6_valid <= S5_valid;

            // Cycle 7
            P <= S189_0S6 + {S383_152S6, 152'b0};

            out_valid <= S6_valid;

        end
    end

endmodule