function f = enframe2(x, win, inc, windowtype)
    nx = length(x);
    if nargin < 4
        windowtype = 'hamming'; % 默认使用汉明窗
    end
    
    if strcmpi(windowtype, 'hamming')
        nwin = hamming(win);
    elseif strcmpi(windowtype, 'hann')
        nwin = hann(win);
    % 添加更多窗函数的选项，例如矩形窗、黑曼窗等
     elseif strcmpi(windowtype, 'rectangle')
         nwin = rectwin(win);
    else
        error('不支持的窗函数类型');
    end
    
    if (nwin == 1)
       len = win;
    else
       len = length(nwin);
    end
    
    if nargin < 3
       inc = len;
    end
    
    nf = fix((nx - len + inc) / inc);
    f = zeros(nf, len);
    indf = inc * (0:(nf-1)).';
    inds = (1:len);
    f(:) = x(indf(:, ones(1, len)) + inds(ones(nf, 1), :));
    
    if (len > 1)
        w = nwin(:)';
        f = f .* w(ones(nf, 1), :);
    end
end
