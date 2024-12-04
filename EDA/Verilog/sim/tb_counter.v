`timescale 1ns/1ns
module tb_counter();

reg clk;
reg [4-1:0] A;
reg [4-1:0] B;

reg D;
wire [4-1:0] Q;
wire Z_carry;


initial begin
    clk = 0;
    A = 4'd4;
    B = 4'd13;

    D = 1'b0;
end

always #5 clk = ~clk;

always #1000 D = ~D;    //反转方向

counter counter_inst(
    .clk(clk),
    .A(A),
    .B(B),
    .D(D),
    .Q(Q),
    .Z_carry(Z_carry)
);

endmodule