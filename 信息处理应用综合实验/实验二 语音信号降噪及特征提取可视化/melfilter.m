function bank = melfilter(fs, N, p)
fl = 0; % fl是设计滤波器的最低频率
fh = fs / 2; % fh是设计滤波器的最高频率
bl = 1125 * log(1 + fl/700); % 最低频率对应的Mel频率
bh = 1125 * log(1 + fh/700); % 最高频率对应的Mel频率
MelF = linspace(0, bh-bl, p+2); % 在0至bh-bl的Mel频率范围内产生p+2个Mel频率值
F = 700 * (exp(MelF/1125) - 1); % 将上一步产生的p+2个Mel频率值转化为p+2个实际频率值
df = fs / N; % 计算频率分辨率
n = N; % 计算fs/2内对应的FFT点数
f = (0:n-1) * df; % 计算频率序列，共有n个频率点
bank = zeros(p, n); % 生成p行n列的全零矩阵

for m = 2:p+1
    F_left = F(m-1); F_mid = F(m); F_right = F(m+1);
    n_left = ceil(F_left / df);
    n_mid = ceil(F_mid / df);
    n_right = ceil(F_right / df);
    for k = 1:n
        if k-1 >= n_left && k-1 <= n_mid
            bank(m-1, k) = ((k-1)-n_left) / (n_mid-n_left);
        elseif k-1 > n_mid && k-1 <= n_right
            bank(m-1, k) = (n_right-(k-1)) / (n_right-n_mid);
        end
    end
end
