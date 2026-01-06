`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.09.2025 11:19:29
// Design Name: 
// Module Name: foldKaratsuba_tb
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


module foldKaratsuba_tb();

    reg clock, reset, in_valid;
    reg [127:0] X;
    reg [64:0] X1X0;

    wire [383:0] P;
    wire out_valid;

    foldKaratsuba fK1 (.clock(clock),.reset(reset),.in_valid(in_valid),.X(X),.X1X0(X1X0),.P(P),.out_valid(out_valid));

    initial begin
        clock <= 1'b0;
        forever begin
            #10 clock <= ~clock;
        end
    end

    initial begin
        reset <= 1'b1;

        #15 reset <= 1'b0;
        in_valid <= 1'b1;
        //X <= 128'h5b013b70ddf11560736ff50d7c982339;
        X <= 128'hffffffffffffffffffffffffffffffff;
        X1X0 <= 65'h1fffffffffffffffe;
        
        #20 X <= 128'h5b013b70ddf11560736ff50d7c982339;
        X1X0 <= 65'h1fffffffffffffffe;

        $monitor("Time: %0t | P: %h | out_valid: %b", $time, P, out_valid);

        #10000 $finish;
    end


endmodule