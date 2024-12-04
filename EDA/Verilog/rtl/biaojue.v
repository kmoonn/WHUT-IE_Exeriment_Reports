module biaojue(
    a, b, c, d, e,
    result
);
    input a, b, c, d, e;
    output result;
    reg result;
    reg[2:0] count;
    always @(a, b, c, d, e) begin
        count = a + b + c + d + e;
        result = (count >= 3) ? 1 : 0;
    end
endmodule