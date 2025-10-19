`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04.09.2025 21:09:08
// Design Name: 
// Module Name: karatsubaTop
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


module karatsubaTop(
	input clock,
	input reset_all,
	input Rx,
	input en_Rx,
	input in_valid,
	input start_Tx,
	output Tx,
	output Tx_done,
	output out_valid,
	output Rx_done
    );
    
    wire [255:0] X, Y;
    wire [511:0] P;
    
    Rx_top RxD(.clock(clock),.en_Rx(en_Rx),.reset(reset_all),.Rx(Rx),.X(A),.Y(B),.ready(Rx_done));
    karatsuba K1(.clock(clock),.in_valid(in_valid),.Xin(X),.Yin(Y),.reset(reset_all),.P(P),.out_valid(out_valid));
    karatsuba_TxD TxD(.clock(clock),.start(start_Tx),.reset(reset_all),.Q(P),.done(Tx_done),.Tx(Tx));
    
endmodule