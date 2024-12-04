`timescale 1ns/1ns
module tb_traffic_light();

reg clk;
reg rst;
reg EN;


wire [2:0] south_north_light;
wire [2:0] east_west_light;
wire [3:0] south_north_count;
wire [3:0] east_west_count;


initial begin
    clk = 0;
    rst = 1;
    #20 rst = 0;    //复位
    
    EN = 0;
    #300 EN = 1;    //保持一段时间全红
    #300 EN = 0;

end


always #5 clk = ~clk;

traffic_light traffic_light_inst(
    .clk(clk),
    .rst(rst),
    .EN(EN),
    .south_north_light(south_north_light),
    .east_west_light(east_west_light),
    .south_north_count(south_north_count),
    .east_west_count(east_west_count)
);

endmodule


