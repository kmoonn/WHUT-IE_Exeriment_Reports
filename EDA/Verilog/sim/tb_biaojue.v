`timescale 1ns/1ns
module tb_biaojue();

// input
reg a;
reg b;
reg c;
reg d;
reg e;
// output
wire result ;

initial begin
    a <= 1'b0;
    b <= 1'b0;
    c <= 1'b0;
    d <= 1'b0;
    e <= 1'b0;
end

always #10
begin
    a <= {$random} % 2;
    b <= {$random} % 2;
    c <= {$random} % 2;
    d <= {$random} % 2;
    e <= {$random} % 2;
end

biaojue biaojue_inst
(
.a (a ), //input a
.b (b ), //input b
.c (c ), //input c
.d (d ), //input d
.e (e ), //input e

.result(result) //output result
);

endmodule

