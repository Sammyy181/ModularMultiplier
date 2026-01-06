`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.09.2025 10:24:36
// Design Name: 
// Module Name: pipelineKaratsuba
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


module pipelineKaratsuba();

    reg clock, in_valid;
    reg [255:0] X, Y;
    reg reset;

    wire [511:0] P;
    wire out_valid;

    karatsuba K1(.clock(clock),.in_valid(in_valid),.reset(reset),.Xin(X),.Yin(Y),.P(P),.out_valid(out_valid));

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
        // P - 5b013b70ddf11560736ff50d7c982339f733c6715932f085be571f6bdf62d9c9f04df57594f140f730187fdd3d7a5c97f79df6f74821c3fb749521933b80fe01
        //#20 X <= 256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff;
        //#20 Y <= 256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff;
        in_valid <= 1;
        
        #20 X <= 256'h6b65a6a48b8148f6b38a088ca65ed389b74d0fb132e706298fadc1a606cb0fb3;
        Y <= 256'hc241330b01a9e71fde8a774bcf36d58b4737819096da1dac72ff5d2a386ecbe0;
		// P - 517e6281dfc302b2f9fef7b03b54d2670bbafc203e19e0141862d3c3d8cfc7047dbb18c691bd2c427ff764b215f348717d4cf77ad038328d42bd09b6de0aada0
		
		#20 X <= 256'h371ecd7b27cd813047229389571aa8766c307511b2b9437a28df6ec4ce4a2bbd;
		Y <= 256'h5be6128e18c267976142ea7d17be31111a2a73ed562b0f79c37459eef50bea63;
		// P - 13c97cb626a93194019484149429c09b374e20b7874d954873a212b45c9d2cde8609b00f7152c8fd3644d9bdfe04e6a617833260bc9977278056f26d54c8ac17
		
		#20 X <= 256'h759cde66bacfb3d00b1f9163ce9ff57f43b7a3a69a8dca03580d7b71d8f56413;
		Y <= 256'h4b0dbb418d5288f1142c3fe860e7a113ec1b8ca1f91e1d4c1ff49b7889463e85;
		// P - 227b442718292a6d25cd345d834f560b6dd2166e70d83b57270d30cde09b486a4fa04d5c445fc975bfafb723db9661006458c3f6f5e2372fa6ddc440adeb97df
		
		#20 X <= 256'h3139d32c93cd59bf5c941cf0dc98d2c1e2acf72f9e574f7aa0ee89aed453dd32;
		Y <= 256'hfc377a4c4a15544dc5e7ce8a3a578a8ea9488d990bbb259911ce5dd2b45ed1f0;
		// P - 307f96d07a1ea62188193a54dd9d6ed88718dd59b98d0ae637d63149ff52fec13c449aebce136cc604c67da5e71257bfb8f239d3f303bf5a0de85a95e69130e0
		
		#20 X <= 256'h7412b29347294739614ff3d719db3ad0ddd1dfb23b982ef8daf61a26146d3f31;
		Y <= 256'hab9099a435a240ae5af305535ec42e0829a3b2e95d65a441d58842dea2bc372f;
		// P - 4dca0d76746675cddfcf99790ddf4961aceb5351cb6c064e459ad6ccbcac773be64f5424d4504473d4a743f42c044caad7e9c62c6b484d5a97c08c16a29e20ff
		
		#20 X <= 256'ha28defe39bf0027312476f57a5e5a5abaefcfad8efc89849b3aa7efe4458a885;
		Y <= 256'h451b4cf36123fdf77656af7229d4beef3eabedcbbaa80dd488bd64072bcfbe01;
		// P - 2be1977d53aa0ce1fdfbcb5188910247ceb1713cef199572b9c0d28f5a7c18660fb6d0c9dc6834e0244590585d6c263fca00d9400223df993570ed59abf65e85
		
    end

	always @(posedge clock) begin
		
		if(P == 512'h5b013b70ddf11560736ff50d7c982339f733c6715932f085be571f6bdf62d9c9f04df57594f140f730187fdd3d7a5c97f79df6f74821c3fb749521933b80fe01)
			$display("Product 1 is correct");
		if(P == 512'h517e6281dfc302b2f9fef7b03b54d2670bbafc203e19e0141862d3c3d8cfc7047dbb18c691bd2c427ff764b215f348717d4cf77ad038328d42bd09b6de0aada0)
			$display("Product 2 is correct");
		if(P == 512'h13c97cb626a93194019484149429c09b374e20b7874d954873a212b45c9d2cde8609b00f7152c8fd3644d9bdfe04e6a617833260bc9977278056f26d54c8ac17)
			$display("Product 3 is correct");
		if(P == 512'h227b442718292a6d25cd345d834f560b6dd2166e70d83b57270d30cde09b486a4fa04d5c445fc975bfafb723db9661006458c3f6f5e2372fa6ddc440adeb97df)
			$display("Product 4 is correct");
		if(P == 512'h307f96d07a1ea62188193a54dd9d6ed88718dd59b98d0ae637d63149ff52fec13c449aebce136cc604c67da5e71257bfb8f239d3f303bf5a0de85a95e69130e0)
			$display("Product 5 is correct");
		if(P == 512'h4dca0d76746675cddfcf99790ddf4961aceb5351cb6c064e459ad6ccbcac773be64f5424d4504473d4a743f42c044caad7e9c62c6b484d5a97c08c16a29e20ff)
			$display("Product 6 is correct");
		if(P == 512'h2be1977d53aa0ce1fdfbcb5188910247ceb1713cef199572b9c0d28f5a7c18660fb6d0c9dc6834e0244590585d6c263fca00d9400223df993570ed59abf65e85)
			$display("Product 7 is correct");
	end

endmodule