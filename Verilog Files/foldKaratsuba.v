module foldKaratsuba(
    input  wire         clock,
    input  wire         reset,
    input  wire         in_valid,
    input  wire [127:0] X,
    input  wire [64:0]  X1X0,
    input  wire [127:0] Y,
    input  wire [64:0]  Y1Y0,
    input  wire [64:0]  Y2Y0,
    input  wire [64:0]  Y2Y1,
    input  wire [64:0]  Y3Y0,
    input  wire [64:0]  Y3Y1,
    output reg  [383:0] P,
    output reg          out_valid
);

    // 1st Cycle
    reg [127:0] P00, P11;
    reg [129:0] S10;
    reg [128:0] S20, S21, S30, S31, S32;
    reg valid_0;

    // 2nd Cycle
    reg [127:0] P00_1, P11_1;
    reg [128:0] P1P0;
    reg [128:0] M20, M21, M30;
    reg [127:0] T4K_1;
    reg [129:0] S10_1;
    reg valid_1;

    // 3rd Cycle
    reg [127:0] P00_2;
    reg [128:0] T1K_2, T2K_2;
    reg [127:0] T4K_2;
    reg [129:0] T3K_2;
    reg valid_2;

    // 4th Cycle
    reg [63:0] result_3;
    reg [129:0] sum_1;
    reg [63:0] T2K_L;
    reg [65:0] sum_3;
    reg [127:0] sum_4;
    reg valid_3;

    // 5th Cycle
    reg [127:0] result_4;
    reg [66:0] sum_2;
    reg [191:0] upSum_4;
    reg valid_4;

    always @(posedge clock) begin
        if(reset) begin
            P <= 384'b0;
            out_valid <= 1'b0;
            valid_0 <= 1'b0;
            valid_1 <= 1'b0;
            valid_2 <= 1'b0;
            valid_3 <= 1'b0;
            valid_4 <= 1'b0;
        end
        else begin

            // 1st Cycle
            P00[127:0] <= X[63:0] * Y[63:0];
            P11[127:0] <= X[127:64] * Y[127:64];

            S10[129:0] <= X1X0[64:0] * Y1Y0[64:0];
            S20[128:0] <= Y2Y0[64:0] * X[63:0];
            S21[128:0] <= Y2Y1[64:0] * X[127:64];
            S30[128:0] <= Y3Y0[64:0] * X[63:0];
            S31[128:0] <= Y3Y1[64:0] * X[127:64];

            valid_0 <= in_valid;

            // 2nd Cycle
            P1P0[128:0] <= P11[127:0] + P00[127:0];
            M20[128:0] <= S20[128:0] - P00[127:0];
            M21[128:0] <= S21[128:0] - P11[127:0];
            M30[128:0] <= S30[128:0] - P00[127:0];
            T4K_1[127:0] <= S31[128:0] - P11[127:0];

            P00_1 <= P00;
            P11_1 <= P11;
            S10_1 <= S10;

            valid_1 <= valid_0;

            // 3rd Cycle
            T1K_2[128:0] <= S10_1[129:0] - P1P0[128:0];
            T2K_2[128:0] <= M20[128:0] + P11_1[127:0];
            T3K_2[129:0] <= M30[128:0] + M21[128:0];

            P00_2 <= P00_1;
            T4K_2 <= T4K_1;

            valid_2 <= valid_1;

            // 4th Cycle
            result_3[63:0] <= P00_2[63:0];
            sum_1[129:0] <= T1K_2[128:0] + P00_2[127:64];
            sum_3[65:0] <= T2K_2[128:64] + T3K_2[63:0];
            sum_4[127:0] <= T3K_2[129:64] + T4K_2[127:0];

            T2K_L[63:0] <= T2K_2[63:0];

            valid_3 <= valid_2;

            // 5th Cycle
            result_4[127:0] <= {sum_1[63:0], result_3[63:0]};
            sum_2[66:0] <= T2K_L[63:0] + sum_1[129:64];
            upSum_4[191:0] <= {(sum_4[127:0] + sum_3[65:64]), sum_3[63:0]};

            valid_4 <= valid_3;

            // Final Cycle

            P[383:0] <= {(upSum_4[191:0] + sum_2[66:64]), sum_2[63:0], result_4[127:0]};
            out_valid <= valid_4;

        end

    end


endmodule