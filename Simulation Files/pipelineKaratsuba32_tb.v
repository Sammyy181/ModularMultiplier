`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06.10.2025 12:23:03
// Design Name: 
// Module Name: pipelineKaratsuba32_tb
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


`timescale 1ns / 1ps

module pipelineKaratsuba32_tb();
    reg clock;
    reg reset;
    reg [63:0] Xin;
    reg [63:0] Yin;
    wire [127:0] P;
    wire [63:0] high, low;
    wire [64:0] mid;
    
    // Expected results storage
    reg [127:0] expected [0:7];
    integer cycle_count;
    integer test_num;
    
    // Instantiate the module
    karatsuba32 dut (
        .clock(clock),
        .reset(reset),
        .Xin(Xin),
        .Yin(Yin),
        .P(P),
        .high(high),
        .low(low),
        .mid(mid)
    );
    
    // Clock generation
    initial begin
        clock = 0;
        forever #5 clock = ~clock;
    end
    
    // Test sequence
    initial begin
        // Initialize
        reset = 1;
        Xin = 0;
        Yin = 0;
        cycle_count = 0;
        test_num = 0;
        
        // Pre-calculate expected results
        expected[0] = 64'd1234 * 64'd5678;
        expected[1] = 64'd9999 * 64'd8888;
        expected[2] = 64'd12345 * 64'd67890;
        expected[3] = 64'd11111 * 64'd22222;
        expected[4] = 64'd0 * 64'd99999;
        expected[5] = 64'd65535 * 64'd65535;
        expected[6] = 64'hFFFFFFFFFFFFFFFF * 64'hFFFFFFFFFFFFFFFF;
        expected[7] = 64'd123456789 * 64'd987654321;
        
        $display("=== Karatsuba32 Pipeline Test ===");
        $display("Time\tCycle\tXin\t\t\tYin\t\t\tP\t\t\t\tExpected\t\t\tMatch");
        $display("--------------------------------------------------------------------------------------------");
        
        // Release reset
        #10;
        reset = 0;
        
        // Feed inputs back-to-back to test pipelining
        @(posedge clock);
        Xin = 64'd1234;
        Yin = 64'd5678;
        cycle_count = cycle_count + 1;
        $display("%0t\t%0d\tInput: %0d\t%0d", $time, cycle_count, Xin, Yin);
        
        @(posedge clock);
        Xin = 64'd9999;
        Yin = 64'd8888;
        cycle_count = cycle_count + 1;
        $display("%0t\t%0d\tInput: %0d\t%0d", $time, cycle_count, Xin, Yin);
        
        @(posedge clock);
        Xin = 64'd12345;
        Yin = 64'd67890;
        cycle_count = cycle_count + 1;
        $display("%0t\t%0d\tInput: %0d\t%0d", $time, cycle_count, Xin, Yin);
        
        @(posedge clock);
        Xin = 64'd11111;
        Yin = 64'd22222;
        cycle_count = cycle_count + 1;
        $display("%0t\t%0d\tInput: %0d\t%0d\tOutput: %0d\tExpected: %0d\t%s", 
                 $time, cycle_count, Xin, Yin, P, expected[0], 
                 (P == expected[0]) ? "PASS" : "FAIL");
        
        @(posedge clock);
        Xin = 64'd0;
        Yin = 64'd99999;
        cycle_count = cycle_count + 1;
        $display("%0t\t%0d\tInput: %0d\t%0d\tOutput: %0d\tExpected: %0d\t%s", 
                 $time, cycle_count, Xin, Yin, P, expected[1], 
                 (P == expected[1]) ? "PASS" : "FAIL");
        
        @(posedge clock);
        Xin = 64'd65535;
        Yin = 64'd65535;
        cycle_count = cycle_count + 1;
        $display("%0t\t%0d\tInput: %0d\t%0d\tOutput: %0d\tExpected: %0d\t%s", 
                 $time, cycle_count, Xin, Yin, P, expected[2], 
                 (P == expected[2]) ? "PASS" : "FAIL");
        
        @(posedge clock);
        Xin = 64'hFFFFFFFFFFFFFFFF;
        Yin = 64'hFFFFFFFFFFFFFFFF;
        cycle_count = cycle_count + 1;
        $display("%0t\t%0d\tInput: %0d\t%0d\tOutput: %0d\tExpected: %0d\t%s", 
                 $time, cycle_count, Xin, Yin, P, expected[3], 
                 (P == expected[3]) ? "PASS" : "FAIL");
        
        @(posedge clock);
        Xin = 64'd123456789;
        Yin = 64'd987654321;
        cycle_count = cycle_count + 1;
        $display("%0t\t%0d\tInput: %0d\t%0d\tOutput: %0d\tExpected: %0d\t%s", 
                 $time, cycle_count, Xin, Yin, P, expected[4], 
                 (P == expected[4]) ? "PASS" : "FAIL");
        
        // Continue for remaining outputs
        @(posedge clock);
        cycle_count = cycle_count + 1;
        $display("%0t\t%0d\t\t\t\t\tOutput: %0d\tExpected: %0d\t%s", 
                 $time, cycle_count, P, expected[5], 
                 (P == expected[5]) ? "PASS" : "FAIL");
        
        @(posedge clock);
        cycle_count = cycle_count + 1;
        $display("%0t\t%0d\t\t\t\t\tOutput: %0d\tExpected: %0d\t%s", 
                 $time, cycle_count, P, expected[6], 
                 (P == expected[6]) ? "PASS" : "FAIL");
        
        @(posedge clock);
        cycle_count = cycle_count + 1;
        $display("%0t\t%0d\t\t\t\t\tOutput: %0d\tExpected: %0d\t%s", 
                 $time, cycle_count, P, expected[7], 
                 (P == expected[7]) ? "PASS" : "FAIL");
        
        #20;
        $display("\n=== Test Complete ===");
        $display("If all outputs match expected values with consistent 3-cycle latency,");
        $display("then karatsuba32 is properly pipelined.");
        $finish;
    end
endmodule