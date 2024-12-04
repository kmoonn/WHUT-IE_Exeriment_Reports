`timescale 1ns/1ns
module tb_multiple();
    reg [4-1:0] a;
    reg [4-1:0] b;
    wire [8-1:0] product;

    initial begin
        a <= 4'b0000;
        b <= 4'b0000;
    end
    
    always #10 begin
        a <= {$random} % 16;
        b <= {$random} % 16;
    end

    multiple multiple_inst(
        .a(a),
        .b(b),
        .product(product)
    );
endmodule