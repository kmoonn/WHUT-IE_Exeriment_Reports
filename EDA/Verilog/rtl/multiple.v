module multiple(
    input  [4-1:0] a,
    input  [4-1:0] b,
    output wire [8-1:0] product
);
    reg [8-1:0] temp;
    integer i;
    always @(a or b)
    begin
        temp = 0;
        for (i = 0; i < 4; i = i + 1) begin
            if (b[i] == 1) begin
                temp = temp + (a << i);
            end
        end
    end
    assign product = temp;
endmodule