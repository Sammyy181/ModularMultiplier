`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.08.2025 17:32:50
// Design Name: 
// Module Name: fineGrainMap
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


module fineGrainMap(
    input wire [3:0] fineGrainAddr,
    output reg [3:0] addr_BRAM2a,
    output reg [3:0] addr_BRAM2b
    );
    
        always @(*) begin
		case(fineGrainAddr)
			
			4'h0: begin
				addr_BRAM2a = 4'b0;
				addr_BRAM2b = 4'b1;
			end
			
			4'h1: begin
				addr_BRAM2a = 4'b0;
				addr_BRAM2b = 4'b1;
			end
			
			4'h2: begin
				addr_BRAM2a = 4'b1;
				addr_BRAM2b = 4'b10;
			end
			
			4'h3: begin
				addr_BRAM2a = 4'b1;
				addr_BRAM2b = 4'b10;
			end
			
			4'h4: begin
				addr_BRAM2a = 4'b10;
				addr_BRAM2b = 4'b11;
			end	
			
			4'h5: begin
				addr_BRAM2a = 4'b10;
				addr_BRAM2b = 4'b11;
			end
			
			4'h6: begin
				addr_BRAM2a = 4'b11;
				addr_BRAM2b = 4'b100;
			end
			
			4'h7: begin
				addr_BRAM2a = 4'b11;
				addr_BRAM2b = 4'b100;
			end
			
			4'h8: begin
				addr_BRAM2a = 4'b100;
				addr_BRAM2b = 4'b101;
			end
			
			4'h9: begin
				addr_BRAM2a = 4'b101;
				addr_BRAM2b = 4'b110;
			end
			
			4'ha: begin
				addr_BRAM2a = 4'b101;
				addr_BRAM2b = 4'b110;
			end
			
			4'hb: begin
				addr_BRAM2a = 4'b110;
				addr_BRAM2b = 4'b111;
			end
			
			4'hc: begin
				addr_BRAM2a = 4'b110;
				addr_BRAM2b = 4'b111;
			end
			
			4'hd: begin
				addr_BRAM2a = 4'b111;
				addr_BRAM2b = 4'b1000;
			end

			4'he: begin
				addr_BRAM2a = 4'b111;
				addr_BRAM2b = 4'b1000;
			end
			
			4'hf: begin
				addr_BRAM2a = 4'b1000;
				addr_BRAM2b = 4'b1001;
			end																											
		endcase
    end		
endmodule
