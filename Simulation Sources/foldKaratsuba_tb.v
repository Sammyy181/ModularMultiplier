`include "foldKaratsuba.v"

module foldKaratsuba_tb();

    reg clock, reset, in_valid;
    reg [127:0] X, Y;
    reg [64:0] X1X0, Y1Y0, Y2Y0, Y2Y1, Y3Y0, Y3Y1;

    wire [383:0] P;
    wire out_valid;
    wire [129:0] sum_1;
    wire [127:0] P00_2;
    wire [128:0] T1K_2;
    wire [128:0] P1P0;
    wire [129:0] S10_1;

    foldKaratsuba fK1 (.clock(clock),.reset(reset),.in_valid(in_valid),.X(X),.Y(Y),.X1X0(X1X0),.Y1Y0(Y1Y0),.Y2Y0(Y2Y0),.Y2Y1(Y2Y1),.Y3Y0(Y3Y0),.Y3Y1(Y3Y1),.P(P),.out_valid(out_valid));

    initial begin
        clock <= 1'b0;
        forever begin
            #10 clock <= ~clock;
        end
    end

    initial begin
        reset <= 1'b1;

        #15 reset <= 1'b0;
        in_valid <= 1'b1;
        //X <= 128'h5b013b70ddf11560736ff50d7c982339;
        X <= 128'hffffffffffffffffffffffffffffffff;
        Y <= 128'h1c424d77f1b750a99cc6df2b0ee713a2;
        X1X0 <= 65'h1fffffffffffffffe;
        Y1Y0 <= 65'hb9092ca3009e644b;
        Y2Y0 <= 65'hd2dd30d1fd8adefd;
        Y2Y1 <= 65'h52589f1ee05b1c04;
        Y3Y0 <= 65'h12faca19e5664357a;
        Y3Y1 <= 65'haf280feb39347281;

        $monitor("Time: %0t | P: %h | out_valid: %b", $time, P, out_valid);

        #10000 $finish;
    end


endmodule