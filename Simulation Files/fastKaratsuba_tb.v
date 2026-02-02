`timescale 1ns/1ps
`include "../Verilog Files/fastKaratsuba.v"

module fastKaratsuba_tb;

    // Clock and reset
    reg clock;
    reg reset;

    // Inputs
    reg  [255:0] X;
    reg  [255:0] Y;
    reg          in_valid;

    // Outputs
    wire [511:0] P;
    wire         out_valid;

    // DUT
    fastKaratsuba dut (
        .clock(clock),
        .reset(reset),
        .X(X),
        .Y(Y),
        .in_valid(in_valid),
        .P(P),
        .out_valid(out_valid)
    );

    // Clock: 10 ns period
    initial begin
        clock = 1'b0;
        forever #5 clock = ~clock;
    end

    integer i;

    // Predefined, unrelated 256-bit stimuli
    reg [255:0] X_vec [0:10];
    reg [255:0] Y_vec [0:10];

    initial begin
        // Completely different 256-bit values
        X_vec[0] = 256'h0123456789ABCDEF_FEDCBA9876543210_0F0F0F0F0F0F0F0F_F0F0F0F0F0F0F0F0;
        Y_vec[0] = 256'h89ABCDEF01234567_76543210FEDCBA98_A5A5A5A5A5A5A5A5_5A5A5A5A5A5A5A5A;

        X_vec[1] = 256'hFFFFFFFFFFFFFFFF_0000000000000000_1234567890ABCDEF_0FEDCBA098765432;
        Y_vec[1] = 256'h0000000000000001_FFFFFFFFFFFFFFFF_FFFFFFFFFFFFFFFE_0000000000000002;

        X_vec[2] = 256'hAAAAAAAAAAAAAAAA_5555555555555555_DEADBEEFCAFEBABE_0123456789ABCDEF;
        Y_vec[2] = 256'h13579BDF2468ACE0_0F0E0D0C0B0A0908_FEDCBA9876543210_1111111111111111;

        X_vec[3] = 256'h0001020304050607_08090A0B0C0D0E0F_1011121314151617_18191A1B1C1D1E1F;
        Y_vec[3] = 256'hFFEEDDCCBBAA9988_7766554433221100_FF00FF00FF00FF00_00FF00FF00FF00FF;

        X_vec[4] = 256'h7FFFFFFFFFFFFFFF_8000000000000000_0000000000000001_FFFFFFFFFFFFFFFE;
        Y_vec[4] = 256'h3C3C3C3C3C3C3C3C_C3C3C3C3C3C3C3C3_AAAAAAAAAAAAAAAA_5555555555555555;

        X_vec[5] = 256'hCAFEBABEDEADBEEF_FEEDFACE12345678_87654321ABCDEF01_0BADF00DDEADC0DE;
        Y_vec[5] = 256'h0D15EA5EBAADF00D_0123456789ABCDEF_FFFFFFFFFFFFFFFF_0000000000000000;

        X_vec[6] = 256'hFFFFFFFF00000000_FFFFFFFF00000000_00000000FFFFFFFF_00000000FFFFFFFF;
        Y_vec[6] = 256'h1111111122222222_3333333344444444_5555555566666666_7777777788888888;

        X_vec[7] = 256'h13579BDF13579BDF_2468ACE02468ACE0_0F1E2D3C4B5A6978_8697A5B4C3D2E1F0;
        Y_vec[7] = 256'hFEDCBA9876543210_0123456789ABCDEF_89ABCDEF01234567_76543210FEDCBA98;

        X_vec[8] = 256'hAAAAAAAA00000000_55555555FFFFFFFF_DEADBEEF00000000_CAFEBABEFFFFFFFF;
        Y_vec[8] = 256'h00000000FFFFFFFF_FFFFFFFF00000000_123456789ABCDEF0_0FEDCBA987654321;

        X_vec[9] = 256'h0123456789ABCDEF_0011223344556677_8899AABBCCDDEEFF_FFEEDDCCBBAA9988;
        Y_vec[9] = 256'hF0F1F2F3F4F5F6F7_0807060504030201_1020304050607080_90A0B0C0D0E0F000;

        X_vec[10] = 256'h9132b63ef16287e4_e9c349e03602f8ac_10f1bc81448aaa9e_66b2bc5b50c187fc;
        Y_vec[10] = 256'he27a984d654821d0_7fcd9eb1a7cad415_366eb16f508ebad7_b7c93acfe059a0ee;

        // Init
        reset    = 1'b1;
        in_valid = 1'b0;
        X        = 256'd0;
        Y        = 256'd0;

        // Reset
        #20;
        reset = 1'b0;

        @(posedge clock);
        in_valid = 1'b1;

        // Drive 10 independent vectors, one per cycle
        for (i = 0; i < 11; i = i + 1) begin
            @(posedge clock);
            X <= X_vec[i];
            Y <= Y_vec[i];
        end

        @(posedge clock);
        in_valid <= 1'b0;
        X        <= 256'd0;
        Y        <= 256'd0;

        // Drain pipeline
        #400;
        $finish;
    end

    // Observe outputs
    always @(posedge clock) begin
        if (out_valid) begin
            $display("t=%0t | P = %h", $time, P);
        end
    end

endmodule