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

    fastKaratsuba dut (
        .clock(clock),
        .reset(reset),
        .in_valid(in_valid),
        .X(X),
        .Y(Y),
        .P(P),
        .out_valid(out_valid)
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
        $display("P = %h", P);
        reset = 0;

        // Apply input
        @(posedge clock);
        X = 256'h123456789ABCDEF0123456789ABCDEF0123456789ABCDEF0123456789ABCDEF0;
        Y = 256'hFEDCBA9876543210FEDCBA9876543210FEDCBA9876543210FEDCBA9876543210;
        in_valid = 1;

        wait(dut.out_valid);
        // --------------------------------------------------
        // Display results
        // --------------------------------------------------
        #20
        $display("====================================");
        $display("X = %h", X);
        $display("Y = %h", Y);
        $display("P = %h", P);
        $display("Expected = %h", X * Y);
        $display("====================================");
        $finish;

    end

endmodule