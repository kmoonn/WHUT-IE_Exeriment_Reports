% 统计图像像素总数
total_pixels = 60;

% 初始化阈值T为图像的中间灰度值
T = 9;

% 迭代求取阈值T
max_iterations = 12;
tolerance = 0.1;
for i = 1:max_iterations
    % 根据阈值T将图像分为前景和背景两部分
    fg_pixels = sum(counts(T+1:end));
    bg_pixels = sum(counts(1:T));
    
    % 计算前景和背景像素的平均灰度值
    fg_mean = sum(bins(T+1:end).*counts(T+1:end))/fg_pixels;
    bg_mean = sum(bins(1:T).*counts(1:T))/bg_pixels;
    
    % 更新阈值T
    new_T = round((fg_mean + bg_mean)/2);
    
    % 判断是否满足停止条件
    if abs(new_T - T) < tolerance
        break;
    end
    
    T = new_T;
end