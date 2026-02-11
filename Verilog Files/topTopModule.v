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
	input wire clock,
	input wire reset_all,
	input wire en_Rx,
	input wire Rx,
	output wire ready,
    output wire out_valid
    );
    
    wire [255:0] X, Y;
    reg in_valid;
    reg done;
    wire [255:0] Q;
    
    Rx_top RxD(.clock(clock),.en_Rx(en_Rx),.reset(reset_all),.Rx(Rx),.X(X),.Y(Y),.ready(ready));
    topModule top(.clock(clock),.reset(reset_all),.X(X),.Y(Y),.in_valid(in_valid),.out_valid(out_valid),.Q(Q));
	ila_0 debugILA(.clk(clock), .probe0(X), .probe1(Y), .probe2(Q),.probe3(ready));
	
	always @(posedge clock) begin
		if(reset_all) begin
			in_valid <= 1'b0;
		end
		else if(ready) begin
			in_valid <= 1'b1;
		end	
	end
endmodule