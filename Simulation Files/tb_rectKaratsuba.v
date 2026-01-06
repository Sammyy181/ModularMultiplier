`timescale 1ns / 1ps
`include "../Verilog Files/rectKaratsuba.v"

module tb_rectKaratsuba;

    reg         clock;
    reg         reset;
    reg         in_valid;
    reg [255:0] X;
    reg [255:0] Y;

    wire [511:0] P;
    wire         out_valid;

    wire [41:0] Z0_S1, Z3_S1, Z4_S1, Z6_S1, Z7_S1, Z8_S1, Z9_S1,
                Z10_S1, Z11_S1, Z13_S1, Z14_S1,  Z17_S1,
                Z20_S1, Z23_S1, Z24_S1, Z25_S1, Z26_S1, Z27_S1, Z28_S1,
                Z30_S1, Z31_S1, Z32_S1, Z33_S1, Z34_S1, Z35_S1, Z37_S1, Z38_S1,
                Z41_S1, Z44_S1, Z45_S1, Z47_S1, Z48_S1, Z49_S1,
                Z50_S1, Z51_S1, Z52_S1, Z54_S1, Z55_S1, Z56_S1, Z57_S1, Z58_S1, Z59_S1,
                Z62_S1, Z65_S1, Z68_S1, Z69_S1,
                Z71_S1, Z72_S1, Z75_S1;
    wire [33:0] Z73_S1, Z76_S1, Z79_S1;
    wire [27:0] Z74_S1, Z78_S1;
    wire [19:0] Z82_S1;

    rectKaratsuba dut (
        .clock(clock),
        .reset(reset),
        .in_valid(in_valid),
        .X(X),
        .Y(Y),
        .P(P),
        .out_valid(out_valid),

        .Z0_S1(Z0_S1), .Z3_S1(Z3_S1), .Z4_S1(Z4_S1), .Z6_S1(Z6_S1),
        .Z7_S1(Z7_S1), .Z8_S1(Z8_S1), .Z9_S1(Z9_S1),
        .Z10_S1(Z10_S1), .Z11_S1(Z11_S1),
        .Z13_S1(Z13_S1), .Z17_S1(Z17_S1),
        .Z20_S1(Z20_S1), .Z23_S1(Z23_S1), .Z24_S1(Z24_S1),
        .Z25_S1(Z25_S1), .Z26_S1(Z26_S1), .Z27_S1(Z27_S1),
        .Z28_S1(Z28_S1),
        .Z30_S1(Z30_S1), .Z31_S1(Z31_S1), .Z32_S1(Z32_S1),
        .Z33_S1(Z33_S1), .Z34_S1(Z34_S1), .Z35_S1(Z35_S1),
        .Z37_S1(Z37_S1), .Z38_S1(Z38_S1),
        .Z41_S1(Z41_S1), .Z44_S1(Z44_S1), .Z45_S1(Z45_S1),
        .Z47_S1(Z47_S1), .Z48_S1(Z48_S1), .Z49_S1(Z49_S1),
        .Z50_S1(Z50_S1), .Z51_S1(Z51_S1), .Z52_S1(Z52_S1),
        .Z54_S1(Z54_S1), .Z55_S1(Z55_S1), .Z56_S1(Z56_S1),
        .Z57_S1(Z57_S1), .Z58_S1(Z58_S1), .Z59_S1(Z59_S1),
        .Z68_S1(Z68_S1), .Z69_S1(Z69_S1), .Z71_S1(Z71_S1),
        .Z72_S1(Z72_S1), .Z73_S1(Z73_S1), .Z74_S1(Z74_S1),
        .Z75_S1(Z75_S1), .Z76_S1(Z76_S1), .Z78_S1(Z78_S1),
        .Z79_S1(Z79_S1), .Z82_S1(Z82_S1)
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

        // --------------------------------------------------
        // Display results
        // --------------------------------------------------
        wait(dut.S1_valid);
        $display("====================================");
        $display("X = %h", X);
        $display("Y = %h", Y);
        $display("P = %h", P);
        $display("Expected = %h", X * Y);
        $display("====================================");

        $display("Z0_S1  = %0b", Z0_S1);
        $display("Z3_S1  = %0b", Z3_S1);
        $display("Z4_S1  = %0b", Z4_S1);
        $display("Z6_S1  = %0b", Z6_S1);
        $display("Z7_S1  = %0b", Z7_S1);
        $display("Z8_S1  = %0b", Z8_S1);
        $display("Z9_S1  = %0b", Z9_S1);
        $display("Z10_S1 = %0b", Z10_S1);
        $display("Z11_S1 = %0b", Z11_S1);
        $display("Z13_S1 = %0b", Z13_S1);
        $display("Z17_S1 = %0b", Z17_S1);

        $display("Z20_S1 = %0b", Z20_S1);
        $display("Z23_S1 = %0b", Z23_S1);
        $display("Z24_S1 = %0b", Z24_S1);
        $display("Z25_S1 = %0b", Z25_S1);
        $display("Z26_S1 = %0b", Z26_S1);
        $display("Z27_S1 = %0b", Z27_S1);
        $display("Z28_S1 = %0b", Z28_S1);

        $display("Z30_S1 = %0b", Z30_S1);
        $display("Z31_S1 = %0b", Z31_S1);
        $display("Z32_S1 = %0b", Z32_S1);
        $display("Z33_S1 = %0b", Z33_S1);
        $display("Z34_S1 = %0b", Z34_S1);
        $display("Z35_S1 = %0b", Z35_S1);
        $display("Z37_S1 = %0b", Z37_S1);
        $display("Z38_S1 = %0b", Z38_S1);

        $display("Z41_S1 = %0b", Z41_S1);
        $display("Z44_S1 = %0b", Z44_S1);
        $display("Z45_S1 = %0b", Z45_S1);
        $display("Z47_S1 = %0b", Z47_S1);
        $display("Z48_S1 = %0b", Z48_S1);
        $display("Z49_S1 = %0b", Z49_S1);

        $display("Z50_S1 = %0b", Z50_S1);
        $display("Z51_S1 = %0b", Z51_S1);
        $display("Z52_S1 = %0b", Z52_S1);
        $display("Z54_S1 = %0b", Z54_S1);
        $display("Z55_S1 = %0b", Z55_S1);
        $display("Z56_S1 = %0b", Z56_S1);
        $display("Z57_S1 = %0b", Z57_S1);
        $display("Z58_S1 = %0b", Z58_S1);
        $display("Z59_S1 = %0b", Z59_S1);

        $display("Z68_S1 = %0b", Z68_S1);
        $display("Z69_S1 = %0b", Z69_S1);
        $display("Z71_S1 = %0b", Z71_S1);
        $display("Z72_S1 = %0b", Z72_S1);
        $display("Z73_S1 = %0b", Z73_S1);
        $display("Z74_S1 = %0b", Z74_S1);
        $display("Z75_S1 = %0b", Z75_S1);
        $display("Z76_S1 = %0b", Z76_S1);
        $display("Z78_S1 = %0b", Z78_S1);
        $display("Z79_S1 = %0b", Z79_S1);
        $display("Z82_S1 = %0b", Z82_S1);

        #20;
        $finish;


    end

endmodule