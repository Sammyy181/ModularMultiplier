`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.09.2025 11:18:58
// Design Name: 
// Module Name: foldKaratsuba
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


module foldKaratsuba(
    input  wire         clock,
    input  wire         reset,
    input  wire         in_valid,
    input  wire [127:0] X,
    input  wire [64:0]  X1X0,
    output reg  [383:0] P,
    output reg          out_valid,
    output reg [127:0] result_4,
    output reg [129:0] sum_1,
    output reg [127:0] P00_2,
    output reg [128:0] T1K_2
);
	
	// Short Path registers and Y component
	reg [64:0]  X1X0_i;
	reg [127:0] X_i;
	wire [127:0] Y;
	wire [64:0] Y1Y0, Y2Y0, Y2Y1, Y3Y0, Y3Y1;
	
	assign Y = 128'h1c424d77f1b750a99cc6df2b0ee713a2;
	assign Y1Y0 = 65'hb9092ca3009e644b;
	assign Y2Y0 = 65'hd2dd30d1fd8adefd;
	assign Y2Y1 = 65'h52589f1ee05b1c04;
	assign Y3Y0 = 65'h12faca19e5664357a;
	assign Y3Y1 = 65'haf280feb39347281;
	
    // 1st Cycle
    wire [127:0] P00, P11;
    reg [129:0] S10;
    wire [128:0] S20, S21, S30, S31;
    reg valid_0;
    
    // 1.1, 1.2, 1.3 Cycles
    reg [129:0] S101, S102, S103;
    reg [127:0] P00_r, P11_r;
    reg [128:0] S20_r, S21_r, S30_r, S31_r;
    
    reg valid_1, valid_11, valid_12, valid_13;

    // 2nd Cycle
    reg [127:0] P00_1, P11_1;
    reg [128:0] P1P0;
    reg [128:0] M20, M21, M30;
    reg [127:0] T4K_1;
    reg [129:0] S10_1;
    reg valid_2;

    // 3rd Cycle
    //reg [127:0] P00_2;
    reg [128:0] T2K_2;//T1K_2
    reg [127:0] T4K_2;
    reg [129:0] T3K_2;
    reg valid_3;

    // 4th Cycle
    reg [63:0] result_3;
    //reg [129:0] sum_1;
    reg [63:0] T2K_L;
    reg [65:0] sum_3;
    reg [127:0] sum_4;
    reg valid_4;

    // 5th Cycle
    //reg [127:0] result_4;
    reg [66:0] sum_2;
    reg [191:0] upSum_4;
    reg valid_5;
    
    karatsuba32 K00(.clock(clock),.reset(reset),.Xin(X_i[63:0]),.Yin(Y[63:0]),.P(P00));
    karatsuba32 K11(.clock(clock),.reset(reset),.Xin(X_i[127:64]),.Yin(Y[127:64]),.P(P11));
    
    karatsuba33 K20(.clock(clock),.reset(reset),.Xin(Y2Y0[64:0]),.Yin(X_i[63:0]),.P(S20));
    karatsuba33 K21(.clock(clock),.reset(reset),.Xin(Y2Y1[64:0]),.Yin(X_i[127:64]),.P(S21));
    karatsuba33 K30(.clock(clock),.reset(reset),.Xin(Y3Y0[64:0]),.Yin(X_i[63:0]),.P(S30));
    karatsuba33 K31(.clock(clock),.reset(reset),.Xin(Y3Y1[64:0]),.Yin(X_i[127:64]),.P(S31));

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

            // 0th Cycle
            X_i <= X;
            X1X0_i <= X1X0;
            
            valid_0 <= in_valid;
            
            // 1st Cycle
            S10[129:0] <= X1X0_i[64:0] * Y1Y0[64:0];
            valid_1 <= valid_0;
            
            // 1.1 Cycle
            S101[129:0] <= S10[129:0];
            valid_11 <= valid_1;
            
            // 1.2 Cycle 
            S102[129:0] <= S101[129:0];
            valid_12 <= valid_11;
            
            // 1.3 Cycle
            S103[129:0] <= S102[129:0];
            
            P00_r <= P00;
            P11_r <= P11;
            
            S20_r <= S20;
            S21_r <= S21;
            S30_r <= S30;
            S31_r <= S31;
            
            valid_13 <= valid_12;

            // 2nd Cycle
            P1P0[128:0] <= P11[127:0] + P00[127:0];
            M20[128:0] <= S20[128:0] - P00[127:0];
            M21[128:0] <= S21[128:0] - P11[127:0];
            M30[128:0] <= S30[128:0] - P00[127:0];
            T4K_1[127:0] <= S31[128:0] - P11[127:0];

            P00_1 <= P00;
            P11_1 <= P11;
            S10_1 <= S103;

            valid_2 <= valid_13;

            // 3rd Cycle
            T1K_2[128:0] <= S10_1[129:0] - P1P0[128:0];
            T2K_2[128:0] <= M20[128:0] + P11_1[127:0];
            T3K_2[129:0] <= M30[128:0] + M21[128:0];

            P00_2 <= P00_1;
            T4K_2 <= T4K_1;

            valid_3 <= valid_2;

            // 4th Cycle
            result_3[63:0] <= P00_2[63:0];
            sum_1[129:0] <= T1K_2[128:0] + P00_2[127:64];
            sum_3[65:0] <= T2K_2[128:64] + T3K_2[63:0];
            sum_4[127:0] <= T3K_2[129:64] + T4K_2[127:0];

            T2K_L[63:0] <= T2K_2[63:0];

            valid_4 <= valid_3;

            // 5th Cycle
            result_4[127:0] <= {sum_1[63:0], result_3[63:0]};
            sum_2[66:0] <= T2K_L[63:0] + sum_1[129:64];
            upSum_4[191:0] <= {(sum_4[127:0] + sum_3[65:64]), sum_3[63:0]};

            valid_5 <= valid_4;

            // Final Cycle

            P[383:0] <= {(upSum_4[191:0] + sum_2[66:64]), sum_2[63:0], result_4[127:0]};
            out_valid <= valid_5;

        end
    end
endmodule