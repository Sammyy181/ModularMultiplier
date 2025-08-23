`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.08.2025 18:31:34
// Design Name: 
// Module Name: topModule
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


module topModule(
	input wire clk,
	input wire rst,
	input wire [255:0] X,
	input wire [255:0] Y,
	input wire start,
	output reg [255:0] Q,
	output reg done
    );
    
    // Karatsuba Multiplier inputs and outputs
    wire [255:0] x, y;
    wire [511:0] prod;
    reg rst_mult, start_mult;
    reg [383:0] store_prod;
    wire done_mult;
    
    // Select pins for X & Y MUX in karatsuba multiplication modules
    reg init_mult;
    reg [1:0] fold_level;
    
    // Big BRAM Inputs and Outputs
    reg enA_BRAM1;
    reg [10:0] addr_BRAM1;
    wire [255:0] doutA_BRAM1;
    
    blk_mem_gen_0 BRAM1(.clka(clk),.ena(enA_BRAM1),.wea(1'b0),.addra(addr_BRAM1),.dina(256'b0),.douta(doutA_BRAM1));
    
    // Karatsuba Submodule
    karatsuba K1(.clk(clk),.A(x),.B(y),.rst(rst_mult),.start(start_mult),.P(prod),.done(done_mult));
    
    // Storage and wires for Karatsuba
    wire [255:0] fold_1, fold_2, fold_3;
    reg [383:0] storeLSB; 
    wire [383:0] dataStoreSel;
    reg [1:0] selReg;
    
    // First Folding inputs and outputs
    wire [384:0] sumFold1;
    assign fold_1[255:0] = {128'b0, prod[511:384]};
    assign sumFold1[384:0] = prod[383:0] + storeLSB[383:0]; 
    
    // Second Folding inputs and outputs
    wire [321:0] sumFold2;
    assign fold_2[255:0] = {191'b0, sumFold1[384:320]};
    assign sumFold2[321:0] = prod[320:0] + storeLSB[320:0];
    
    // Third Folding inputs and outputs
    wire [289:0] sumFold3;
    reg [289:0] foldOut;
    assign fold_3[255:0] = {223'b0, sumFold2[321:289]};
    assign sumFold3[289:0] = prod[288:0] + storeLSB[288:0];
    
    
    // Get Karatsuba multiplier inputs
    assign y = init_mult? doutA_BRAM1 : Y; 
    assign x = fold_level[1]? (fold_level[0]? fold_3 : fold_2) : (fold_level[0]? fold_1 : X); 
    
    // Selection for Register input
    assign dataStoreSel[383:0] = selReg[1]? {95'b0, sumFold2[288:0]} : (selReg[0]? {64'b0, sumFold1[319:0]} : prod[383:0]);
    
    // End of Folding Stages
    // 290-bit output of Folding stages stored in sumFold3
    // Coarse Grain Reduction
    
    reg [1:0] BRAM_sel;
    wire [258:0] A;
    reg sel_A;
    
    wire [258:0] CGS;
    reg [258:0] coarseGrainSum;
    
    assign A[258:0] = sel_A? coarseGrainSum[258:0] : {3'b0, sumFold3[289:34]};
    assign CGS[258:0] = A[258:0] + {3'b0, doutA_BRAM1};
     
    // Fine Grain Reduction
    
    wire [3:0] fineGrainAddr;
    assign fineGrainAddr[3:0] = coarseGrainSum[258:255];
    
    // BRAM2 inputs & outputs
    reg enA_BRAM2;
    wire [3:0] addr_BRAM2a, addr_BRAM2b;
    wire [259:0] doutA_BRAM2a, doutA_BRAM2b;
    
    blk_mem_gen_1 BRAM2a(.clka(clk),.ena(enA_BRAM2),.wea(1'b0),.addra(addr_BRAM2a),.dina(260'b0),.douta(doutA_BRAM2a)); 
    blk_mem_gen_1 BRAM2b(.clka(clk),.ena(enA_BRAM2),.wea(1'b0),.addra(addr_BRAM2b),.dina(260'b0),.douta(doutA_BRAM2b));
    
    fineGrainMap FGM(.fineGrainAddr(fineGrainAddr),.addr_BRAM2a(addr_BRAM2a),.addr_BRAM2b(addr_BRAM2b));
    
    wire [256:0] Q1, Q2;
    assign Q1 = coarseGrainSum - doutA_BRAM2a;
    assign Q2 = coarseGrainSum - doutA_BRAM2b;
    
    // FSM
    reg [4:0] state;
    reg [1:0] counter;
    
    parameter IDLE = 5'b0, LOAD1 = 5'b1, MULT1 = 5'b10, WAIT1 = 5'b11, FOLD1 = 5'b100 ,STORE1 = 5'b101, FOLD2 = 5'b110, STORE2 = 5'b111, WAIT2 = 5'b1000, FOLD3 = 5'b1001, STORE3 = 5'b1010, WAIT3 = 5'b1011, COARSEGRAIN = 5'b1100;
    parameter COARSEGRAINWAIT1 = 5'b1101, COARSEGRAIN2 = 5'b1110, COARSEGRAIN3 = 5'b1111, COARSEGRAIN4 = 5'b10000, FINEGRAIN1 = 5'b10001, DONE = 5'b10010;
    
    always @(posedge clk) begin
    	case(state)
    		IDLE: begin
    			rst_mult <= 1'b1;
    			counter <= 1'b0;
    			sel_A <= 1'b0;
    			coarseGrainSum <= 259'b0;
    			enA_BRAM1 <= 1'b0;
    			start_mult <= 1'b0;
    			storeLSB <= 384'b0;
    			selReg <= 2'b0;
    			foldOut <= 290'b0;
    			BRAM_sel <= 2'b0;
    			coarseGrainSum <= 259'b0;
    			enA_BRAM2 <= 1'b0;
    			
    			
    			if (rst) begin 
					done <= 1'b0;
					Q <= 256'b0;
				end
    			else if(start) state <= LOAD1;
			end
			
			LOAD1: begin
				rst_mult <= 1'b0;
				fold_level <= 2'b00;
				init_mult <= 1'b1;
				state <= MULT1;
			end
			
			MULT1: begin
				start_mult <= 1'b1;
				selReg <= 2'b00;
				enA_BRAM1 <= 1'b1;
				state <= WAIT1;
			end	
			
			WAIT1: begin
				start_mult <= 1'b0;
				addr_BRAM1 <= 11'd1664; 
				if(done_mult) begin
					init_mult <= 1'b0;
					storeLSB <= dataStoreSel;
					fold_level <= 2'b01;
					state <= FOLD1;
				end
			end
			
			FOLD1: begin
				start_mult <= 1'b1;
				selReg <= 2'b01;
				state <= STORE1;
			end
			
			STORE1: begin
				start_mult <= 1'b0;
				addr_BRAM1 <= 11'd1665;
				if(done_mult) begin
					counter[0] <= ~counter[0];
				end
				if(counter[0]) begin
					counter[0] <= 1'b0;
					fold_level <= 2'b10;
					state <= FOLD2;
				end					
			end
			
			FOLD2: begin
				start_mult <= 1'b1;
				state <= STORE2;
			end	
			
			STORE2: begin
				start_mult <= 1'b0;
				addr_BRAM1 <= 11'd1666;
				storeLSB <= dataStoreSel;
				state <= WAIT2;
			end	
			
			WAIT2: begin
				selReg <= 2'b10;
				if(done_mult) begin
					counter[0] <= ~counter[0];
				end
				if(counter[0]) begin
					counter[0] <= 1'b0;
					fold_level <= 2'b11;
					state <= FOLD3;
				end
			end
			
			FOLD3: begin
				start_mult <= 1'b1;
				state <= STORE3;
			end
			
			STORE3: begin
				start_mult <= 1'b0;
				storeLSB <= dataStoreSel;
				state <= WAIT3;
			end	
			
			WAIT3: begin
				if(done_mult) begin
					counter[0] <= ~counter[0];
				end
				if(counter[0]) begin
					counter[0] <= 1'b0;
					foldOut <= sumFold3;
					state <= COARSEGRAIN;
				end	
			end	
			
			COARSEGRAIN: begin
				addr_BRAM1 <= {4'b1100, foldOut[289:283]};
				sel_A <= 1'b0;
				state <= COARSEGRAINWAIT1;
			end
			
			COARSEGRAINWAIT1: begin
				counter <= counter + 1'b1;
				if(&counter) begin
					coarseGrainSum <= CGS;
					addr_BRAM1 <= {2'b10, foldOut[282:274]};
					counter <= 2'b0;
					sel_A <= 1'b1;
					state <= COARSEGRAIN2;
				end
			end
			
			COARSEGRAIN2: begin
				counter <= counter + 1'b1;
				if (&counter) begin
					coarseGrainSum <= CGS;
					addr_BRAM1 <= {2'b01, foldOut[273:265]};
					counter <= 2'b0;
					state <= COARSEGRAIN3;
				end
			end
			
			COARSEGRAIN3: begin
				counter <= counter + 1'b1;
				if (&counter) begin
					coarseGrainSum <= CGS;
					addr_BRAM1 <= {2'b00, foldOut[264:256]};
					counter <= 2'b0;
					state <= COARSEGRAIN4;
				end	
			end	
			
			COARSEGRAIN4: begin
				counter <= counter + 1;
				if (&counter) begin
					enA_BRAM1 <= 1'b0;
					coarseGrainSum <= CGS;
					counter <= 2'b0;
					state <= FINEGRAIN1;
				end	
			end
			
			FINEGRAIN1: begin
				enA_BRAM2 <= 1'b1;
				counter <= counter + 1;
				if(&counter) begin
					enA_BRAM2 <= 1'b0;
					counter <= 0;
					Q <= (Q2 < 0)? Q1 : Q2;
					state <= DONE;	
				end	
			end	
			
			DONE: begin
				done <= 1;
				state <= IDLE;
			end
			
			default: state <= IDLE;				
		endcase
	end			  
endmodule
