`include "karatsuba.v"

module karatsuba_tb();

    reg clock, in_valid;
    reg [255:0] X, Y;
    reg reset;

    wire [511:0] P;
    wire out_valid;

    karatsuba K1(.clock(clock),.in_valid(in_valid),.reset(reset),.X(X),.Y(Y),.P(P),.out_valid(out_valid));

    initial begin
        clock <= 1'b0;
        forever begin
            #10 clock <= ~clock;
        end
    end

    initial begin
        reset <= 1'b1;

        #10 reset <= 1'b0;
        #20 X <= 256'd68374361576449959379811878238702970795767227995234058958640265755013581201577;
        #20 Y <= 256'd69709006495262083753438964270882567809667203355268795714903518762464260067737;
        //#20 X <= 256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff;
        //#20 Y <= 256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff;
        #20 in_valid <= 1;

        $monitor("Time: %t | P: %h | out_valid: %b", $time, P, out_valid);

        #100000 $finish;

    end

endmodule