`timescale 1ns/1ps
`include "../Verilog Files/constKaratsuba.v"

module constKaratsuba_tb();

    // Clock and reset
    reg clock;
    reg reset;

    // Inputs
    wire  [255:0] X;
    reg  [127:0] Y;
    reg          in_valid;

    // Outputs
    wire [383:0] P;
    wire         out_valid;

    // DUT
    constKaratsuba dut (
        .clock(clock),
        .reset(reset),
        .X(X),
        .Y(Y),
        .in_valid(in_valid),
        .P(P),
        .out_valid(out_valid)
    );

    initial begin
        clock = 1'b0;
        forever #5 clock = ~clock;
    end

    assign X = 256'h92e5c273477d21d8361651a6eea3cb5b1c424d77f1b750a99cc6df2b0ee713a2;

    integer i;

    // 30 test vectors: 20 structured + 10 random
    reg [127:0] Y_vec [0:29];

    initial begin
        // Test 1: All zeros - tests zero handling
        Y_vec[0] = 128'h00000000000000000000000000000000;

        // Test 2: All ones - tests all bits set
        Y_vec[1] = 128'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF;

        // Test 3: Single bit set in LSB - tests minimal multiplication
        Y_vec[2] = 128'h00000000000000000000000000000001;

        // Test 4: Single bit set in MSB - tests upper bit handling
        Y_vec[3] = 128'h80000000000000000000000000000000;

        // Test 5: Alternating bits pattern 1
        Y_vec[4] = 128'hAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA;

        // Test 6: Alternating bits pattern 2
        Y_vec[5] = 128'h55555555555555555555555555555555;

        // Test 7: Lower 64 bits set, upper 64 bits clear
        Y_vec[6] = 128'h00000000000000000FFFFFFFFFFFFFFFF;

        // Test 8: Upper 64 bits set, lower 64 bits clear
        Y_vec[7] = 128'hFFFFFFFFFFFFFFFF0000000000000000;

        // Test 9: Checkerboard pattern by nibbles
        Y_vec[8] = 128'hF0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0;

        // Test 10: Inverse checkerboard pattern
        Y_vec[9] = 128'h0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F;

        // Test 11: Progressive bit pattern - tests 24-bit boundaries
        Y_vec[10] = 128'h0000000100000001000000010000001;

        // Test 12: All bits set in specific 16-bit segments
        Y_vec[11] = 128'hFFFF0000FFFF0000FFFF0000FFFF0000;

        // Test 13: Sequential increments - tests carries
        Y_vec[12] = 128'h0123456789ABCDEF0FEDCBA987654321;

        // Test 14: Large prime-like number
        Y_vec[13] = 128'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC5;

        // Test 15: Power of 2 minus 1 (2^64 - 1 in lower half)
        Y_vec[14] = 128'h00000000000000000FFFFFFFFFFFFFFFF;

        // Test 16: Multiple 24-bit segment boundaries
        Y_vec[15] = 128'h00FFFFFF00FFFFFF00FFFFFF00FFFFFF;

        // Test 17: Testing signed/unsigned boundaries
        Y_vec[16] = 128'h7FFFFFFFFFFFFFFF8000000000000000;

        // Test 18: Consecutive ones in different positions
        Y_vec[17] = 128'h000000FFFFFFFFFF000000FFFFFFFFFF;

        // Test 19: Random-looking but structured pattern
        Y_vec[18] = 128'hDEADBEEFCAFEBABEFEEDFACE13579BDF;

        // Test 20: Bit rotation pattern
        Y_vec[19] = 128'h8000000040000000200000001000000;

        // Test 21-30: Completely random hex values
        Y_vec[20] = 128'h3F8A7B2E5D19C64F8E2A3B7D6F1C9E45;
        Y_vec[21] = 128'hB4E9F1C3A7D2856B4F3E8A1D7C592B6E;
        Y_vec[22] = 128'h7C3D9E4A2F8B1D5E6A9C4F2E8B3D7A1C;
        Y_vec[23] = 128'h91E6D4B8F2A5C7394E1D8B6F3A2C9E57;
        Y_vec[24] = 128'h5D8A3F9E1C7B4E2D6F8A9C3E5B7D1F4A;
        Y_vec[25] = 128'hC8F4E9A1D3B6279E5A4D8F1C3E7B9A26;
        Y_vec[26] = 128'h2E9D5A8F3C1B7E46D8F2A3C9B5E7D41A;
        Y_vec[27] = 128'hA7C4E8D1F93B6A25E8D1C4F7A2B9E356;
        Y_vec[28] = 128'h6B1F8E3D9A4C27E5F8B3D6A1C9E4F728;
        Y_vec[29] = 128'hD9A2F5E8B1C4736E2D8F9A3C6E5B1D4F;

        // Init
        reset    = 1'b1;
        in_valid = 1'b0;
        Y        = 128'd0;

        // Reset
        #20;
        reset = 1'b0;

        @(posedge clock);
        in_valid = 1'b1;

        // Drive 30 independent vectors, one per cycle
        for (i = 0; i < 30; i = i + 1) begin
            @(posedge clock);
            Y <= Y_vec[i];
            $display("Input %0d: Y = %h", i, Y_vec[i]);
        end

        @(posedge clock);
        in_valid <= 1'b0;
        Y        <= 128'd0;

        // Drain pipeline
        #600;
        $finish;
    end

    // Observe outputs
    always @(posedge clock) begin
        if (out_valid) begin
            $display("t=%0t | P = %h", $time, P);
        end
    end
endmodule