`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 31.01.2026 00:12:22
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
	input wire clock,
	input wire reset,
	input wire in_valid,
	input wire [255:0] X,
	input wire [255:0] Y,
	output reg [255:0] Q,
	output reg out_valid
    );
    
    wire [511:0] product;
    wire P511_valid;
    
    fastKaratsuba K1(.clock(clock),.reset(reset),.in_valid(in_valid),.X(X),.Y(Y),.P(product),.out_valid(P511_valid));
    
    wire [255:0] rem256;
    assign rem256 = 256'h92e5c273477d21d8361651a6eea3cb5b1c424d77f1b750a99cc6df2b0ee713a2;
    wire CK_valid;
    
    wire [383:0] constProduct;
    constKaratsuba CK(.clock(clock),.reset(reset),.in_valid(P511_valid),.X(rem256),.Y(product[511:384]),.P(constProduct),.out_valid(CK_valid));
    
    // Cycle 9
    reg [383:0] Plow_S9;
    reg valid_S9;
    
    // Cycle 10
    reg [383:0] Plow_S10;
    reg valid_S10;
    
    // Cycle 11
    reg [383:0] Plow_S11;
    reg valid_S11;
    
    // Cycle 12
    reg [383:0] Plow_S12;
    reg valid_S12;
    
    // Cycle 13
    reg [383:0] Plow_S13;
    reg valid_S13;
    
    // Cycle 14
    reg [383:0] Plow_S14;
    reg valid_S14;
    
	// Cycle 15
    reg [383:0] Plow_S15;
    reg valid_S15;
    
    // Cycle 16
    reg [383:0] Plow_S16;
    reg valid_S16;
    
    // Cycle 17
    reg [192:0] foldLow_S17, foldHigh_S17;
    reg valid_S17;
    
    // Cycle 18
    reg [384:0] rOut_S18;
    reg valid_S18;
    
    // Cycle 19 + BRAM blocks and associated wires;
    reg [255:0] coarseGrainLow_S19;
    reg valid_S19;
    
    wire [255:0] CG1, CG2, CG3, CG4, CG5, CG6, CG7, CG8, CG9, CG10, CG11, CG12, CG13, CG14, CG15;
    
	// BRAM For Coarse Grain Reduction
    blk_mem_gen_0  BRAM0 (.clka(clock),.ena(valid_S18),.wea(1'b0),.addra(rOut_S18[264:256]),.dina(256'b0),.douta(CG1)); 
    blk_mem_gen_1  BRAM1 (.clka(clock),.ena(valid_S18),.wea(1'b0),.addra(rOut_S18[273:265]),.dina(256'b0),.douta(CG2));
    blk_mem_gen_2  BRAM2 (.clka(clock),.ena(valid_S18),.wea(1'b0),.addra(rOut_S18[282:274]),.dina(256'b0),.douta(CG3));
    blk_mem_gen_3  BRAM3 (.clka(clock),.ena(valid_S18),.wea(1'b0),.addra(rOut_S18[291:283]),.dina(256'b0),.douta(CG4));
    blk_mem_gen_4  BRAM4 (.clka(clock),.ena(valid_S18),.wea(1'b0),.addra(rOut_S18[300:292]),.dina(256'b0),.douta(CG5));
    blk_mem_gen_5  BRAM5 (.clka(clock),.ena(valid_S18),.wea(1'b0),.addra(rOut_S18[309:301]),.dina(256'b0),.douta(CG6));
    blk_mem_gen_6  BRAM6 (.clka(clock),.ena(valid_S18),.wea(1'b0),.addra(rOut_S18[318:310]),.dina(256'b0),.douta(CG7));
    blk_mem_gen_7  BRAM7 (.clka(clock),.ena(valid_S18),.wea(1'b0),.addra(rOut_S18[327:319]),.dina(256'b0),.douta(CG8));
    blk_mem_gen_8  BRAM8 (.clka(clock),.ena(valid_S18),.wea(1'b0),.addra(rOut_S18[336:328]),.dina(256'b0),.douta(CG9));
    blk_mem_gen_9  BRAM9 (.clka(clock),.ena(valid_S18),.wea(1'b0),.addra(rOut_S18[345:337]),.dina(256'b0),.douta(CG10));
    blk_mem_gen_10 BRAM10(.clka(clock),.ena(valid_S18),.wea(1'b0),.addra(rOut_S18[354:346]),.dina(256'b0),.douta(CG11));
    blk_mem_gen_11 BRAM11(.clka(clock),.ena(valid_S18),.wea(1'b0),.addra(rOut_S18[363:355]),.dina(256'b0),.douta(CG12));
    blk_mem_gen_12 BRAM12(.clka(clock),.ena(valid_S18),.wea(1'b0),.addra(rOut_S18[372:364]),.dina(256'b0),.douta(CG13));
    blk_mem_gen_13 BRAM13(.clka(clock),.ena(valid_S18),.wea(1'b0),.addra(rOut_S18[381:373]),.dina(256'b0),.douta(CG14));
    blk_mem_gen_14 BRAM14(.clka(clock),.ena(valid_S18),.wea(1'b0),.addra(rOut_S18[384:382]),.dina(256'b0),.douta(CG15));
    
    // Cycle 20
    reg [255:0] coarseGrainLow_S20;
    reg valid_S20;
    
    // Cycle 21
    reg [256:0] cgSum0_S21, cgSum1_S21, cgSum2_S21, cgSum3_S21, cgSum4_S21, cgSum5_S21, cgSum6_S21, cgSum7_S21;
    reg valid_S21;
    
    // Cycle 22
    reg [257:0] cgSum0_S22, cgSum1_S22, cgSum2_S22, cgSum3_S22;
    reg valid_S22;
    
    // Cycle 23
    reg [258:0] cgSum0_S23, cgSum1_S23;
    reg valid_S23;
    
    // Cycle 24
    reg [259:0] coarseGrainSum_S24;
    reg valid_S24;
    
    // Cycle 25 + Fine Grain BRAM blocks and associated wires
    reg [259:0] coarseGrainSum_S25;
    reg valid_S25;
    
    wire [259:0] MK1, MK2;
    blk_mem_gen_15 FG1(.clka(clock),.ena(valid_S24),.wea(1'b0),.addra(coarseGrainSum_S24[259:255]),.dina(260'b0),.douta(MK1));
	blk_mem_gen_16 FG2(.clka(clock),.ena(valid_S24),.wea(1'b0),.addra(coarseGrainSum_S24[259:255]),.dina(260'b0),.douta(MK2));
    
    // Cycle 26
    reg [259:0] coarseGrainSum_S26;
    reg valid_S26;
    
    // Cycle 27
    reg [129:0] fineGrainH1_S27, fineGrainL1_S27, fineGrainH2_S27, fineGrainL2_S27;
    reg borrowL1_S27, borrowL2_S27;
    reg valid_S27;
    
    // Cycle 28
    reg [259:0] fineGrain1_S28, fineGrain2_S28;
    reg valid_S28;
    
    always @(posedge clock) begin
		if(reset) begin
			Q <= 256'b0;
			valid_S9 <= 1'b0;
			valid_S10 <= 1'b0;
			valid_S11 <= 1'b0;
			valid_S12 <= 1'b0;
			valid_S13 <= 1'b0;
			valid_S14 <= 1'b0;
			valid_S15 <= 1'b0;
			valid_S16 <= 1'b0;
			valid_S17 <= 1'b0;
			valid_S18 <= 1'b0;
			valid_S19 <= 1'b0;
			valid_S20 <= 1'b0;
			valid_S21 <= 1'b0;
			valid_S22 <= 1'b0;
			valid_S23 <= 1'b0;
			valid_S24 <= 1'b0;
			valid_S25 <= 1'b0;
			valid_S26 <= 1'b0;
			valid_S27 <= 1'b0;
			valid_S28 <= 1'b0;
			out_valid <= 1'b0;
    	end
    	else begin
    		// Cycle 1 - 8 for the full multiplication
    		
    		// Cycle 8
    		Plow_S9 <= product[383:0];
    		valid_S9 <= P511_valid;
    		
    		// Cycle 10
    		Plow_S10 <= Plow_S9;
    		valid_S10 <= valid_S9;
    		
    		// Cycle 11
    		Plow_S11 <= Plow_S10;
    		valid_S11 <= valid_S10;
    		
    		// Cycle 12
    		Plow_S12 <= Plow_S11;
    		valid_S12 <= valid_S11;
    		
    		// Cycle 13
    		Plow_S13 <= Plow_S12;
    		valid_S13 <= valid_S12;
    		
    		// Cycle 14
    		Plow_S14 <= Plow_S13;
    		valid_S14 <= valid_S13;
    		
    		// Cycle 15
    		Plow_S15 <= Plow_S14;
    		valid_S15 <= valid_S14;
    		
    		// Cycle 16
    		Plow_S16 <= Plow_S15;
    		valid_S16 <= valid_S15;
    		
    		// Cycle 17
    		foldLow_S17 <= Plow_S16[191:0] + constProduct[191:0];
    		foldHigh_S17 <= Plow_S16[383:192] + constProduct[383:192];
    		valid_S17 <= valid_S16;
    		
    		// Cycle 18
    		rOut_S18 <= {foldHigh_S17[192:0] + foldLow_S17[192],foldLow_S17[191:0]};
    		valid_S18 <= valid_S17;
    		
    		// Cycle 19
    		coarseGrainLow_S19 <= rOut_S18[255:0];
    		valid_S19 <= valid_S18;
    		
    		// Cycle 20
    		coarseGrainLow_S20 <= coarseGrainLow_S19;
    		valid_S20 <= valid_S19;
    		
    		// Cycle 21
    		cgSum0_S21 <= coarseGrainLow_S20 + CG1;
    		cgSum1_S21 <= CG2 + CG3;
    		cgSum2_S21 <= CG4 + CG5;
    		cgSum3_S21 <= CG6 + CG7;
    		cgSum4_S21 <= CG8 + CG9;
    		cgSum5_S21 <= CG10 + CG11;
    		cgSum6_S21 <= CG12 + CG13;
    		cgSum7_S21 <= CG14 + CG15;
    		valid_S21 <= valid_S20;
    		
    		// Cycle 22
    		cgSum0_S22 <= cgSum0_S21 + cgSum1_S21;
    		cgSum1_S22 <= cgSum2_S21 + cgSum3_S21;
    		cgSum2_S22 <= cgSum4_S21 + cgSum5_S21;
    		cgSum3_S22 <= cgSum6_S21 + cgSum7_S21;
    		valid_S22 <= valid_S21;
    		
    		// Cycle 23
    		cgSum0_S23 <= cgSum0_S22 + cgSum1_S22;
    		cgSum1_S23 <= cgSum2_S22 + cgSum3_S22;
    		valid_S23 <= valid_S22;
    		
    		// Cycle 24
    		coarseGrainSum_S24 <= cgSum0_S23 + cgSum1_S23;
    		valid_S24 <= valid_S23;
    		
    		// Cycle 25
    		coarseGrainSum_S25 <= coarseGrainSum_S24;
    		valid_S25 <= valid_S24;
    		
    		// Cycle 26
    		coarseGrainSum_S26 <= coarseGrainSum_S25;
    		valid_S26 <= valid_S25;
    		
    		// Cycle 27
    		fineGrainH1_S27[129:0] <= coarseGrainSum_S26[259:130] - MK1[259:130];
    		fineGrainH2_S27[129:0] <= coarseGrainSum_S26[259:130] - MK2[259:130];
    		{borrowL1_S27, fineGrainL1_S27[129:0]} <= {1'b0, coarseGrainSum_S26[129:0]} - {1'b0, MK1[129:0]};
    		{borrowL2_S27, fineGrainL2_S27[129:0]} <= {1'b0, coarseGrainSum_S26[129:0]} - {1'b0, MK2[129:0]};
    		valid_S27 <= valid_S26;
    		
    		// Cycle 28
    		fineGrain1_S28 <= {fineGrainH1_S27 - borrowL1_S27, fineGrainL1_S27};
    		fineGrain2_S28 <= {fineGrainH2_S27 - borrowL2_S27, fineGrainL2_S27};
    		valid_S28 <= valid_S27;
    		
    		// Final Cycle
    		Q[255:0] <= fineGrain2_S28[259]? fineGrain1_S28[255:0] : fineGrain2_S28[255:0];
    		out_valid <= valid_S28;
    		
    	end
    end
endmodule