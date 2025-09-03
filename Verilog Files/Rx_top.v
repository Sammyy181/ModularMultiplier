`timescale 1ns/1ps

module Rx_top(
	input wire clock,
	input wire en_Rx,
	input wire reset,
	input wire Rx,
	output reg [255:0] X,
	output reg [255:0] Y,
	output reg ready
	);
	
	reg [5:0] dataCount;
	reg state;
	wire [7:0] o_data_byte;
	wire o_data_avail;
	
	Rx_base R(.clock(clock),.Rx(Rx),.o_data_byte(o_data_byte),.o_data_avail(o_data_avail));
	
	parameter ACCEPT = 1'b0, BLOCK = 1'b1;
	
	always @(posedge clock) begin
		if(reset) begin
			X <= 256'b0;
			Y <= 256'b0;
			dataCount <= 6'b0;
			ready <= 1'b0;
			state <= ACCEPT;
		end
		
		else if (en_Rx) begin
		case(state)
			ACCEPT: begin 
				if(o_data_avail) begin
					if (dataCount[5]) 
						Y[dataCount[4:0]*8 +: 8] <= o_data_byte;
					else
						X[dataCount[4:0]*8 +: 8] <= o_data_byte;
					
					if (&dataCount) begin
						state <= BLOCK;    
						ready <= 1'b1;
					end else begin
						dataCount <= dataCount + 1;
					end
				end
			end
			
			BLOCK: ready <= 1'b1;
			default: state <= ACCEPT;
		endcase
		end	
	end
	
endmodule