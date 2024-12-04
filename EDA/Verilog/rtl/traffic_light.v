module traffic_light(
    input clk,
    input rst,  //高电平有效
    input EN,
    output reg [2:0] south_north_light, //001绿，010黄，100红
    output reg [2:0] east_west_light,
    output reg [3:0] south_north_count,
    output reg [3:0] east_west_count
);

// 定义状态参数(二段式状态机)
parameter   SN_GREEN = 3'b001,  //南北方向绿灯
            SN_YELLOW = 3'b010, //南北方向黄灯
            EW_GREEN = 3'b100,  //东西方向绿灯
            EW_YELLOW = 3'b101, //东西方向绿灯
            ALL_RED = 3'b110;   //全红 EN==1
// 一个方向为绿/黄灯，那么另一个方向一定为红灯，因此可以省略红灯状态机


reg [2:0] current_state;


// 状态机转换逻辑
always @(posedge clk or posedge rst) begin
    if (rst) begin
        current_state <= SN_GREEN;
        south_north_count <= 4'd9;
        east_west_count <= 4'd4;
    end else if (EN) begin
        current_state <= ALL_RED;
        south_north_count <= 4'd0;
        east_west_count <= 4'd0;
    end else begin
        case (current_state)
            SN_GREEN: begin
                if (south_north_count == 4'd0) begin
                    // 绿灯倒计时结束后转到黄灯状态机，并设置黄灯时间
                    current_state <= SN_YELLOW;
                    south_north_count <= 4'd1;
                end else
                    south_north_count <= south_north_count - 1'b1;
            end
            SN_YELLOW: begin
                if (south_north_count == 4'd0) begin
                    // 黄灯倒计时结束后转到另一条路绿灯状态机，并设置另一条路倒计时时间
                    current_state <= EW_GREEN;
                    east_west_count <= 4'd4;
                end else
                    south_north_count <= south_north_count - 1'b1;
            end
            EW_GREEN: begin
                if (east_west_count == 4'd0) begin
                    current_state <= EW_YELLOW;
                    east_west_count <= 4'd1;
                end else
                    east_west_count <= east_west_count - 1'b1;
            end
            EW_YELLOW: begin
                if (east_west_count == 4'd0) begin
                    current_state <= SN_GREEN;
                    south_north_count <= 4'd9;
                end else
                    east_west_count <= east_west_count - 1'b1;
            end
            ALL_RED: begin
                if (!EN) begin
                    current_state <= SN_GREEN;
                    south_north_count <= 4'd9;
                    east_west_count <= 4'd4;
                end
            end
            default: begin
                current_state <= SN_GREEN;
                south_north_count <= 4'd9;
                east_west_count <= 4'd4;
            end
        endcase
    end
end

// 根据状态设置灯光输出和剩余时长输出
always @(*) begin
    case (current_state)
        SN_GREEN: begin
            south_north_light = 3'b001;
            east_west_light = 3'b100;
        end
        SN_YELLOW: begin
            south_north_light = 3'b010;
            east_west_light = 3'b100;
        end
        EW_GREEN: begin
            south_north_light = 3'b100;
            east_west_light = 3'b001;
        end
        EW_YELLOW: begin
            south_north_light = 3'b100;
            east_west_light = 3'b010;
        end
        ALL_RED: begin
            south_north_light = 3'b100;
            east_west_light = 3'b100;
        end
        default: begin
            south_north_light = 3'b001;
            east_west_light = 3'b100;
        end
    endcase
end

endmodule