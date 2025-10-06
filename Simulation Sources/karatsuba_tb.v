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

	reg clk = 1'b0;
	wire [511:0] P;
    reg [255:0] X, Y;
    reg reset;
    reg in_valid;
    wire out_valid;
    wire [127:0] P00, T0K_1, T0K_2;
    wire [63:0] result_3;
    
    karatsuba K1(.clock(clk), .in_valid(in_valid), .Xin(X), .Yin(Y), .out_valid(out_valid), .reset(reset), .P(P),
    			.P00(P00),.result_3(result_3),.T0K_1(T0K_1),.T0K_2(T0K_2));
    		
    initial begin
        /*for(i = 0; i < 8; i = i + 1) begin 
            A[32*i +: 32] = $random(seed);
        end
        
        for(i = 0; i < 8; i = i + 1) begin
            B[32*i +: 32] = $random(seed);
        end*/
        X = 256'd68374361576449959379811878238702970795767227995234058958640265755013581201577;
        Y = 256'd69709006495262083753438964270882567809667203355268795714903518762464260067737;
        //A = 256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF;
        //B = 256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF;
        
        in_valid <= 0;
        reset <= 1;
        
        #15 reset = 0;
        in_valid <= 1;
       
    end
    
    initial begin
        forever
            #10 clk = !clk;
    end
endmodule