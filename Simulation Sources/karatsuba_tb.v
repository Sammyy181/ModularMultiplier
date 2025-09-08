`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.08.2025 12:28:07
// Design Name: 
// Module Name: karatsuba_tb
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


module karatsuba_tb();

    reg [255:0] A, B;
    reg start, reset;
    wire done;
    wire [511:0] P;
    reg clk = 1'b0;
    wire [131:0] tempP;
    
    karatsuba K1(.clock(clk), .A(A), .B(B), .start(start), .reset(reset), .done(done), .P(P));
    initial begin
        /*for(i = 0; i < 8; i = i + 1) begin 
            A[32*i +: 32] = $random(seed);
        end
        
        for(i = 0; i < 8; i = i + 1) begin
            B[32*i +: 32] = $random(seed);
        end*/
        A = 256'd68374361576449959379811878238702970795767227995234058958640265755013581201577;
        B = 256'd69709006495262083753438964270882567809667203355268795714903518762464260067737;
        //A = 256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF;
        //B = 256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF;
        start = 0;
        reset = 1;
        
        #15 reset = 0;
        #10 start = 1;
        #20 start = 0;
       
    end
    
    initial begin
        forever
            #10 clk = !clk;
    end
endmodule