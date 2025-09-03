`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01.09.2025 23:14:50
// Design Name: 
// Module Name: topTopModule
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


module topTopModule(
	input clock,
	input reset_all,
	input Rx,
    input en_Rx,
    input start_Tx,
    input start_MM,
    output Tx,
    output Tx_done,
    output MM_done,
    output Rx_done
    );
    
    wire [255:0] X, Y, Q;
    
    topModule top(.clock(clock),.rst(reset_all),.X(X),.Y(Y),.start(start_MM),.Q(Q),.done(MM_done));
	Tx_top TxD(.clock(clock),.start(start_Tx),.reset(reset_all),.Q(Q),.done(Tx_done),.Tx(Tx));
	Rx_top RxD(.clock(clock),.en_Rx(en_Rx),.reset(reset_all),.Rx(Rx),.X(X),.Y(Y),.ready(Rx_done));
	    
endmodule
