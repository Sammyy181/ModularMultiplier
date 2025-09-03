`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.08.2025 16:12:51
// Design Name: 
// Module Name: Tx_top
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


module Tx_top(
	input clock,
	input start,
	input reset,
	input [255:0] Q,
	output reg done,
	output wire Tx
    );
    
    reg [4:0] dataCount;
    reg [2:0] state;
    reg i_data_avail;
    reg [7:0] i_data_byte;
    wire o_active, o_done;
    
    Tx_base T(.clock(clock),.i_data_avail(i_data_avail),.i_data_byte(i_data_byte),.o_active(o_active),.Tx(Tx),.o_done(o_done));
    
    parameter IDLE = 3'b00, LOAD = 3'b01, TRANSMIT = 3'b10, WAIT = 3'b11, DONE = 3'b100;
    
    always @(posedge clock) begin
    	if(reset) begin
    		done <= 1'b0;
    		dataCount <= 5'b0;
    		state <= IDLE;
    		i_data_byte <= 8'b0;
    		i_data_avail <= 1'b0;
		end
    	
    	else begin
    	case(state)
    		IDLE: begin
    			i_data_avail <= 1'b0;
    			if(start & !done) begin
    				state <= LOAD;
    				dataCount <= 5'b0;
				end
			end
			
			LOAD: begin
				i_data_byte <= Q[dataCount*8 +: 8];
				state <= TRANSMIT;
			end
			
			TRANSMIT: begin
				i_data_avail <= 1'b1;
				state <= WAIT;
			end
			
			WAIT: begin
				i_data_avail <= 1'b0;
				if (o_done) begin
					if (dataCount == 31) begin   // last byte just sent
						state <= DONE;
					end else begin
						dataCount <= dataCount + 1;
						state <= LOAD;
					end
				end
			end
			
			DONE: begin
				done <= 1'b1;
				state <= IDLE;
			end
			
			default: state <= IDLE;
			
		endcase
   		end
	end

endmodule
