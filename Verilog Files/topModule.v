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
	input wire clock,
	input wire reset,
	input wire in_valid,
	input wire [255:0] Xin,
	input wire [255:0] Yin,
	output reg [255:0] Q,
	output reg out_valid
    );

	// First Multiplication Wires
	wire [511:0] product;
	wire prod_valid;
	
	reg [255:0] X, Y;

	karatsuba K1(.clock(clock),.in_valid(in_valid),.Xin(X),.Yin(Y),.reset(reset),.P(product),.out_valid(prod_valid));
	
	// Cycle 1
	reg redIn_valid;
	reg [383:0] Plow_1;
	reg [127:0] Ph;
	wire [383:0] redP;
	reg [64:0] X1X0;
	wire red_valid;
	reg valid_1;

	foldKaratsuba FK(.clock(clock),.reset(reset),.in_valid(redIn_valid),.X(Ph),.X1X0(X1X0),.P(redP),.out_valid(red_valid));
	
	// Cycle 2
	reg [383:0] Plow_2;
	reg valid_2;

	// Cycle 3
	reg [383:0] Plow_3;
	reg valid_3;

	// Cycle 4
	reg [383:0] Plow_4;
	reg valid_4;

	// Cycle 5
	reg [383:0] Plow_5;
	reg valid_5;

	// Cycle 6
	reg [383:0] Plow_6;
	reg valid_6;

	// Cycle 7
	reg [383:0] Plow_7;
	reg valid_7;
	
	// Cycle 8
	reg [383:0] Plow_8;
	reg valid_8;
	
	// Cycle 9
	reg [383:0] Plow_9;
	reg valid_9;
	
	// Cycle 10
	reg [383:0] Plow_10;
	reg valid_10;
	
	// Cycle 11
	reg [383:0] Plow_11;
	reg valid_11;

	// Cycle 11
	reg [192:0] foldLow_11;
	reg [192:0] foldHigh_11;
	reg valid_12;

	// Cycle 12
	reg [384:0] reductionOut;
	reg valid_13;
	
	// Coarse Grain Reduction memory blocks and wires
	reg [255:0] coarseGrainlow_1;
	reg [255:0] coarseGrainlow_2;
	wire [255:0] CG1, CG2, CG3, CG4, CG5, CG6, CG7, CG8, CG9, CG10, CG11, CG12, CG13, CG14, CG15; 
	reg valid_14, valid_15;
	
	// BRAM For Coarse Grain Reduction
	blk_mem_gen_0  BRAM0 (.clka(clock),.ena(valid_11),.wea(1'b0),.addra(reductionOut[264:256]),.dina(256'b0),.douta(CG1)); 
	blk_mem_gen_1  BRAM1 (.clka(clock),.ena(valid_11),.wea(1'b0),.addra(reductionOut[273:265]),.dina(256'b0),.douta(CG2));
	blk_mem_gen_3  BRAM2 (.clka(clock),.ena(valid_11),.wea(1'b0),.addra(reductionOut[282:274]),.dina(256'b0),.douta(CG3));
	blk_mem_gen_4  BRAM3 (.clka(clock),.ena(valid_11),.wea(1'b0),.addra(reductionOut[291:283]),.dina(256'b0),.douta(CG4));
	blk_mem_gen_5  BRAM4 (.clka(clock),.ena(valid_11),.wea(1'b0),.addra(reductionOut[300:292]),.dina(256'b0),.douta(CG5));
	blk_mem_gen_6  BRAM5 (.clka(clock),.ena(valid_11),.wea(1'b0),.addra(reductionOut[309:301]),.dina(256'b0),.douta(CG6));
	blk_mem_gen_7  BRAM6 (.clka(clock),.ena(valid_11),.wea(1'b0),.addra(reductionOut[318:310]),.dina(256'b0),.douta(CG7));
	blk_mem_gen_8  BRAM7 (.clka(clock),.ena(valid_11),.wea(1'b0),.addra(reductionOut[327:319]),.dina(256'b0),.douta(CG8));
	blk_mem_gen_9  BRAM8 (.clka(clock),.ena(valid_11),.wea(1'b0),.addra(reductionOut[336:328]),.dina(256'b0),.douta(CG9));
	blk_mem_gen_10 BRAM9 (.clka(clock),.ena(valid_11),.wea(1'b0),.addra(reductionOut[345:337]),.dina(256'b0),.douta(CG10));
	blk_mem_gen_11 BRAM10(.clka(clock),.ena(valid_11),.wea(1'b0),.addra(reductionOut[354:346]),.dina(256'b0),.douta(CG11));
	blk_mem_gen_12 BRAM11(.clka(clock),.ena(valid_11),.wea(1'b0),.addra(reductionOut[363:355]),.dina(256'b0),.douta(CG12));
	blk_mem_gen_13 BRAM12(.clka(clock),.ena(valid_11),.wea(1'b0),.addra(reductionOut[372:364]),.dina(256'b0),.douta(CG13));
	blk_mem_gen_14 BRAM13(.clka(clock),.ena(valid_11),.wea(1'b0),.addra(reductionOut[381:373]),.dina(256'b0),.douta(CG14));
	blk_mem_gen_15 BRAM14(.clka(clock),.ena(valid_11),.wea(1'b0),.addra(reductionOut[384:382]),.dina(256'b0),.douta(CG15));
	
	// Addition of Coarse Grain Memory outputs
	// Cycle 15
	reg [256:0] cgSum0, cgSum1, cgSum2, cgSum3, cgSum4, cgSum5, cgSum6, cgSum7;
	reg valid_16;
	
	// Cycle 16
	reg [257:0] cgSum10, cgSum11, cgSum12, cgSum13;
	reg valid_17;
	
	// Cycle 17
	reg [258:0] cgSum20, cgSum21;
	reg valid_18;
	
	// Cycle 18
	reg [259:0] coarseGrainSum;
	reg valid_19;
	
	// Fine Grain BRAMs
	wire [259:0] MK1, MK2;
	blk_mem_gen_2 FG1(.clka(clock),.ena(valid_17),.wea(1'b0),.addra(coarseGrainSum[259:255]),.dina(260'b0),.douta(MK1));
	blk_mem_gen_16 FG2(.clka(clock),.ena(valid_17),.wea(1'b0),.addra(coarseGrainSum[259:255]),.dina(260'b0),.douta(MK2));
	
	// Cycle 19
	reg [259:0] coarseGrainSum1;
	reg valid_20;
	
	// Cycle 20
	reg [259:0] coarseGrainSum2;
	reg valid_21;
	
	// Cycle 21
	reg [129:0] fineGrainH1, fineGrainL1, fineGrainH2, fineGrainL2;
	reg borrowL1, borrowL2;
	reg valid_22;
	
	// Cycle 22
	reg [259:0] fineGrain1, fineGrain2;
	reg valid_23;
		
	always @(posedge clock) begin
		if(reset) begin
			Q <= 256'b0;
			out_valid <= 1'b0;
			reductionOut <= 385'b0;
			coarseGrainSum <= 260'b0;
			X <= 256'b0;
			Y <= 256'b0;
		end
		
		else begin
			// Consider 0th Cycle to provide X * Y
			X <= Xin;
			Y <= Yin;
			
			// 1st Cycle
			Ph <= product[511:384];
			X1X0 <= product[511:448] + product[447:384];
			Plow_1 <= product[383:0];
			redIn_valid <= prod_valid;
			
			// 2nd Cycle
			Plow_2 <= Plow_1;
			valid_2 <= redIn_valid;
	
			// 3rd Cycle
			Plow_3 <= Plow_2;
			valid_3 <= valid_2;
	
			// 4th Cycle
			Plow_4 <= Plow_3;
			valid_4 <= valid_3;
	
			// 5th Cycle
			Plow_5 <= Plow_4;
			valid_5 <= valid_4;
	
			// 6th Cycle
			Plow_6 <= Plow_5;
			valid_6 <= valid_5;
	
			// 7th Cycle
			Plow_7 <= Plow_6;
			valid_7 <= valid_6;
			
			// 8th Cycle
			Plow_8 <= Plow_7;
			valid_8 <= valid_7;
			
			// 9th Cycle
			Plow_9 <= Plow_8;
			valid_9 <= valid_8;
			
			// 10th Cycle
			Plow_10 <= Plow_9;
			valid_10 <= valid_9;
			
			// 11th Cycle
			Plow_11 <= Plow_10;
			valid_11 <= valid_10;
			
			// 12th Cycle
			foldLow_11 <= Plow_11[191:0] + redP[191:0];
			foldHigh_11 <= Plow_11[383:192] + redP[383:192];
			valid_12 <= valid_11;
	
			// 13th Cycle 
			reductionOut <= {foldHigh_11[192:0]+foldLow_11[192],foldLow_11[191:0]};
			valid_13 <= valid_12;
			
			// 14th Cycle
			coarseGrainlow_1 <= reductionOut[255:0];
			valid_14 <= valid_13;
			
			// 15th Cycle
			coarseGrainlow_2 <= coarseGrainlow_1;
			valid_15 <= valid_14;
			
			// 16th Cycle
			cgSum0 <= coarseGrainlow_2 + CG1;
			cgSum1 <= CG2 + CG3;
			cgSum2 <= CG4 + CG5;
			cgSum3 <= CG6 + CG7;
			cgSum4 <= CG8 + CG9;
			cgSum5 <= CG10 + CG11;
			cgSum6 <= CG12 + CG13;
			cgSum7 <= CG14 + CG15;
			valid_16 <= valid_15;
			
			// 17th Cycle
			cgSum10 <= cgSum0 + cgSum1;
			cgSum11 <= cgSum2 + cgSum3;
			cgSum12 <= cgSum4 + cgSum5;
			cgSum13 <= cgSum6 + cgSum7;
			valid_17 <= valid_16;
			
			// 18th Cycle
			cgSum20 <= cgSum10 + cgSum11;
			cgSum21 <= cgSum12 + cgSum13;
			valid_18 <= valid_17;
			
			// 19th Cycle
			coarseGrainSum <= cgSum20 + cgSum21;
			valid_19 <= valid_18;
			
			// 20th Cycle
			coarseGrainSum1 <= coarseGrainSum;
			valid_20 <= valid_19;
			
			// 21st Cycle
			coarseGrainSum2 <= coarseGrainSum1;
			valid_21 <= valid_20;
			
			// 22nd Cycle
			fineGrainH1[129:0] <= coarseGrainSum2[259:130] - MK1[259:130];
			fineGrainH2[129:0] <= coarseGrainSum2[259:130] - MK2[259:130];
			{borrowL1, fineGrainL1[129:0]} <= {1'b0, coarseGrainSum2[129:0]} - {1'b0, MK1[129:0]};
			{borrowL2, fineGrainL2[129:0]} <= {1'b0, coarseGrainSum2[129:0]} - {1'b0, MK2[129:0]};
			valid_22 <= valid_21;
			
			// 23rd Cycle
			fineGrain1 <= {fineGrainH1 - borrowL1, fineGrainL1};
			fineGrain2 <= {fineGrainH2 - borrowL2, fineGrainL2};
			valid_23 <= valid_22;
			
			// Final Cycle
			Q[255:0] <= fineGrain2[259]? fineGrain1[255:0] : fineGrain2[255:0];
			out_valid <= valid_23;
		end
	end
endmodule