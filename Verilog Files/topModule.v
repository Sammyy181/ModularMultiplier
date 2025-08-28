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

	// Pre-Computed moduli storage
	localparam [255:0] MOD0 = 256'h92e5c273477d21d8361651a6eea3cb5b1c424d77f1b750a99cc6df2b0ee713a2;
	localparam [255:0] MOD1 = 256'hc56ce43b644eaeb5d6bd39635f168bc7e83d30b2bec503941e239b49273483a0;
	localparam [255:0] MOD2 = 256'h01c4a9ab1122c444ac8e846947958353d241fce4c5e67cd7522eda3380d35a12;
		
	reg [1:0] selMod;
	wire [255:0] C;
	assign C = (selMod == 2'b00) ? MOD0 :
			   (selMod == 2'b01) ? MOD1 :
			   (selMod == 2'b10) ? MOD2 : 256'b0;	
    
    // Karatsuba Multiplier inputs and outputs
    wire [255:0] x, y;
    wire [511:0] prod;
    reg rst_mult, start_mult;
    reg [383:0] store_prod;
    wire done_mult;
    
    // Select pins for X & Y MUX in karatsuba multiplication modules
    reg init_mult;
    reg [1:0] fold_level;
    
    // Coarse Grain Reduction BRAM inputs and outputs
    reg en_CGSBRAM;
    reg [8:0] addr_BRAM256, addr_BRAM265, addr_BRAM274;
	reg [6:0] addr_BRAM283;
    wire [255:0] doutA_BRAM256, doutA_BRAM265, doutA_BRAM274, doutA_BRAM283;
    
    blk_mem_gen_0 BRAM256 (.clka(clk),.ena(en_CGSBRAM),.wea(1'b0),.addra(addr_BRAM256),.dina(256'b0),.douta(doutA_BRAM256));
	blk_mem_gen_2 BRAM265 (.clka(clk),.ena(en_CGSBRAM),.wea(1'b0),.addra(addr_BRAM265),.dina(256'b0),.douta(doutA_BRAM265));
	blk_mem_gen_3 BRAM274 (.clka(clk),.ena(en_CGSBRAM),.wea(1'b0),.addra(addr_BRAM274),.dina(256'b0),.douta(doutA_BRAM274));
	blk_mem_gen_4 BRAM283 (.clka(clk),.ena(en_CGSBRAM),.wea(1'b0),.addra(addr_BRAM283),.dina(256'b0),.douta(doutA_BRAM283));
    
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
    assign y = init_mult? Y : C; 
    assign x = fold_level[1]? (fold_level[0]? fold_3 : fold_2) : (fold_level[0]? fold_1 : X); 
    
    // Selection for Register input
    assign dataStoreSel[383:0] = selReg[1]? {95'b0, sumFold2[288:0]} : (selReg[0]? {64'b0, sumFold1[319:0]} : prod[383:0]);
    
    // End of Folding Stages
    // 290-bit output of Folding stages stored in sumFold3
    // Coarse Grain Reduction
    
	wire [258:0] CGS;
	assign CGS = foldOut[255:0] + doutA_BRAM256 + doutA_BRAM265 + doutA_BRAM274 + doutA_BRAM283;
    reg [258:0] coarseGrainSum;
     
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
    
    wire [255:0] Q1;
    wire [256:0] Q2;
    assign Q1 = coarseGrainSum - doutA_BRAM2a;
    assign Q2 = coarseGrainSum - doutA_BRAM2b;
    
    // FSM
    reg [4:0] state;
    reg [1:0] counter;
    
    parameter IDLE = 5'b0, MULT1 = 5'b1, WAIT1 = 5'b10, FOLD1 = 5'b11 ,STORE1 = 5'b100, WAIT2 = 5'b101, FOLD2 = 5'b110, STORE2 = 5'b111, WAIT3 = 5'b1000, WAIT4 = 5'b1001, FOLD3 = 5'b1010, STORE3 = 5'b1011, WAIT5 = 5'b1100;
    parameter COARSEGRAINLOAD = 5'b1101, COARSEGRAINWAIT = 5'b1110, COARSEGRAIN = 5'b1111, FINEGRAIN1 = 5'b10000, FINEGRAIN2 = 5'b10001, DONE = 5'b10010;
    
    always @(posedge clk) begin
    	if (rst) begin
    		rst_mult <= 1'b1;
    		done <= 1'b0;
    		Q <= 256'b0;
    		state <= IDLE;
    	end
    	case(state)
    		IDLE: begin
    			rst_mult <= 1'b0;
    			counter <= 1'b0;
    			coarseGrainSum <= 259'b0;
				en_CGSBRAM <= 1'b0;
    			start_mult <= 1'b0;
    			storeLSB <= 384'b0;
    			selReg <= 2'b0;
				selMod <= 2'b0;
    			foldOut <= 290'b0;
    			coarseGrainSum <= 259'b0;
    			enA_BRAM2 <= 1'b0;
				fold_level <= 2'b00;
				init_mult <= 1'b1;
				
    			if(start & !done) state <= MULT1;
			end
			
			MULT1: begin
				start_mult <= 1'b1;
				selReg <= 2'b00;
				state <= WAIT1;
			end	
			
			WAIT1: begin
				start_mult <= 1'b0;
				if(done_mult) begin
					init_mult <= 1'b0;
					selMod <= 2'b0;
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
				if(done_mult) begin
					selMod <= 2'b01;
					fold_level <= 2'b10;
					state <= WAIT2;
				end					
			end

			WAIT2: state <= FOLD2;
			
			FOLD2: begin
				start_mult <= 1'b1;
				state <= STORE2;
			end	
			
			STORE2: begin
				start_mult <= 1'b0;
				storeLSB <= dataStoreSel;
				state <= WAIT3;
			end	
			
			WAIT3: begin
				selReg <= 2'b10;
				if(done_mult) begin
					selMod <= 2'b10;
					fold_level <= 2'b11;
					state <= WAIT4;
				end
			end

			WAIT4: state <= FOLD3;
			
			FOLD3: begin
				start_mult <= 1'b1;
				state <= STORE3;
			end
			
			STORE3: begin
				start_mult <= 1'b0;
				storeLSB <= dataStoreSel;
				state <= WAIT5;
			end	
			
			WAIT5: begin
				if(done_mult) begin
					counter[0] <= ~counter[0];
				end
				if(counter[0]) begin
					counter[0] <= 1'b0;
					foldOut <= sumFold3;
					en_CGSBRAM <= 1'b1;
					state <= COARSEGRAINLOAD;
				end	
			end	
			
			// Correctly Functional Until Here
			COARSEGRAINLOAD: begin
				addr_BRAM283 <= foldOut[289:283];
				addr_BRAM274 <= foldOut[282:274];
				addr_BRAM265 <= foldOut[273:265];
				addr_BRAM256 <= foldOut[264:256];
				state <= COARSEGRAINWAIT;
			end
			
			COARSEGRAINWAIT: begin
				// Wait for two clocks for the BRAM data to load
				counter <= counter + 1'b1;
				if(counter == 2'b10) begin
					counter <= 2'b0;
					en_CGSBRAM <= 1'b0;
					enA_BRAM2 <= 1'b1;
					state <= COARSEGRAIN;
				end
			end
			
			COARSEGRAIN: begin
				coarseGrainSum <= CGS;
				state <= FINEGRAIN1;
			end
			
			FINEGRAIN1: begin
				counter[0] <= ~counter[0];
				if(counter[0]) begin
					enA_BRAM2 <= 1'b0;
					counter <= 0;
					state <= FINEGRAIN2;	
				end	
			end	
			
			FINEGRAIN2: begin
				Q <= (Q2[256])? Q1 : Q2[255:0];
				state <= DONE;
			end
			
			DONE: begin
				done <= 1;
				state <= IDLE;
			end
			
			default: state <= IDLE;				
		endcase
	end			  
endmodule