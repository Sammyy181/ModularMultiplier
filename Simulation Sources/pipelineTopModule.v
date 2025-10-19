`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.10.2025 22:24:39
// Design Name: 
// Module Name: pipelineTopModule_tb
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

module pipelineTopModule_tb();

	reg clock, reset, in_valid;
	reg [255:0] X, Y;
	wire [255:0] Q;
	wire out_valid;
	
	topModule UUT(.clock(clock),.reset(reset),.in_valid(in_valid),.Xin(X),.Yin(Y),.out_valid(out_valid),.Q(Q));
	
	initial begin
		clock <= 1'b0;
		forever begin
			#10 clock <= ~clock;
		end
	end

	initial begin
		reset <= 1'b1;

		#15 reset <= 1'b0;
		#20 X <= 256'd68374361576449959379811878238702970795767227995234058958640265755013581201577;
		Y <= 256'd69709006495262083753438964270882567809667203355268795714903518762464260067737;
		// Q - 7aa790fb62f949ed3b4f3fce2d1b3c63c9f429ebabbbc258df59d4a4076784e0
		in_valid <= 1;
		
		#20 X <= 256'h6b65a6a48b8148f6b38a088ca65ed389b74d0fb132e706298fadc1a606cb0fb3;
		Y <= 256'hc241330b01a9e71fde8a774bcf36d58b4737819096da1dac72ff5d2a386ecbe0;
		// Q - 9a752f620a4f1a4372d8515a275ef48275cca23bb3ac0c591f15a3764007ff1
		
		#20 X <= 256'h371ecd7b27cd813047229389571aa8766c307511b2b9437a28df6ec4ce4a2bbd;
		Y <= 256'h5be6128e18c267976142ea7d17be31111a2a73ed562b0f79c37459eef50bea63;
		// Q - dc5d40d4a3a0ed5401bdd047567dac7042040ec1ff24d3a3b161db9a429c36a8
		
		#20 X <= 256'h759cde66bacfb3d00b1f9163ce9ff57f43b7a3a69a8dca03580d7b71d8f56413;
		Y <= 256'h4b0dbb418d5288f1142c3fe860e7a113ec1b8ca1f91e1d4c1ff49b7889463e85;
		// Q - ddc63c3bfbbe4e94631af5eb181ece990d1b9978a9dbdb3d67a4bfca0d490b5a
		
		#20 X <= 256'h3139d32c93cd59bf5c941cf0dc98d2c1e2acf72f9e574f7aa0ee89aed453dd32;
		Y <= 256'hfc377a4c4a15544dc5e7ce8a3a578a8ea9488d990bbb259911ce5dd2b45ed1f0;
		// Q - 5759a221f798ca020d682b76baa71dccfff69ae8aef740bdbf517ef20c400f91
		
		#20 X <= 256'h7412b29347294739614ff3d719db3ad0ddd1dfb23b982ef8daf61a26146d3f31;
		Y <= 256'hab9099a435a240ae5af305535ec42e0829a3b2e95d65a441d58842dea2bc372f;
		// Q - a7cd311780463695997aba4c33b490627dcce7308f965b93d49bfa3b4916e17e
		
		#20 X <= 256'ha28defe39bf0027312476f57a5e5a5abaefcfad8efc89849b3aa7efe4458a885;
		Y <= 256'h451b4cf36123fdf77656af7229d4beef3eabedcbbaa80dd488bd64072bcfbe01;
		// Q - a3345327fc93e2cd5fdb5a7d2cf11e835c9efe6316e6ba2f41768a3d452b821f
		
		#20 X <= 256'h5304317faf42e12f3838b3268e944239b02b61c4a3d70628ece66fa2fd5166e6;
		Y <= 256'hce177b4e0837b8a3d261a7ab3aa2e4f90e51f30dc6a7ee39c4b032ccd7c524a5;
		// Q - 585bee4642a7b9815de73c319bcf1ab5989e8befc99d50c1fb52adf22d23ee6b
		
		#20 X <= 256'h9132b63ef16287e4e9c349e03602f8ac10f1bc81448aaa9e66b2bc5b50c187fc;
		Y <= 256'he27a984d654821d07fcd9eb1a7cad415366eb16f508ebad7b7c93acfe059a0ee;
		// Q - 697e1e1a0a30f18859bb34497ba33ba58cc6c9c3d638eefa12f8d33f2b51d530
		
		#20 X <= 256'hbeb799193f22faf823bed01d43cf2fde24933b83757750a9a491f0b2ea1fca65;
		Y <= 256'h956269f0e5d7b8756dadd6c795a76d79bf3c4c06434308bc89fa6a688fb5d27b;
		// Q - d77d2621794bd6c0fa02fcd2bbf083c8c63f648ae8943bb6a6f44bfd41a87642
	end
	
	always @(posedge clock) begin	
		if(Q == 256'h7aa790fb62f949ed3b4f3fce2d1b3c63c9f429ebabbbc258df59d4a4076784e0)
			$display("Product 1 is correct");
		if(Q == 256'h9a752f620a4f1a4372d8515a275ef48275cca23bb3ac0c591f15a3764007ff1)
			$display("Product 2 is correct");
		if(Q == 256'hdc5d40d4a3a0ed5401bdd047567dac7042040ec1ff24d3a3b161db9a429c36a8)
			$display("Product 3 is correct");
		if(Q == 256'hddc63c3bfbbe4e94631af5eb181ece990d1b9978a9dbdb3d67a4bfca0d490b5a)
			$display("Product 4 is correct");
		if(Q == 256'h5759a221f798ca020d682b76baa71dccfff69ae8aef740bdbf517ef20c400f91)
			$display("Product 5 is correct");
		if(Q == 256'ha7cd311780463695997aba4c33b490627dcce7308f965b93d49bfa3b4916e17e)
			$display("Product 6 is correct");
		if(Q == 256'ha3345327fc93e2cd5fdb5a7d2cf11e835c9efe6316e6ba2f41768a3d452b821f)
			$display("Product 7 is correct");
		if(Q == 256'h585bee4642a7b9815de73c319bcf1ab5989e8befc99d50c1fb52adf22d23ee6b)
			$display("Product 8 is correct");
		if(Q == 256'h697e1e1a0a30f18859bb34497ba33ba58cc6c9c3d638eefa12f8d33f2b51d530)
			$display("Product 9 is correct");
		if(Q == 256'hd77d2621794bd6c0fa02fcd2bbf083c8c63f648ae8943bb6a6f44bfd41a87642)
			$display("Product 10 is correct");
	end
endmodule