module led
(
input wire key_in , //输入按键
output wire led_out //输出控制led灯
);

//led_out:led灯输出的结果为key_in按键的输入值
assign led_out = key_in;
endmodule